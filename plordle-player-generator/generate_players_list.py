from typing import Dict
from dotenv import dotenv_values
from rapidfuzz import process, fuzz
from sportsipy.fb.team import Team as fb_team
from pathlib import Path
from retry import retry
from player import Player
from utils import country_utils, data_utils
import constants
import country_converter as coco
import pandas as pd
import requests, time, orjson

@retry(requests.ReadTimeout, tries=2, delay=10, backoff=2)
def pull_players_from_fbref():
    """
    Use the sportipy libary to pull down all current players from each team's page
    on FBRef and save it to a file. This will not run if the fbref_players.json file
    already exists.

    This will be used to enhance the data coming from API-FOOTBALL
    """

    player_list = []
    teams = []

    team_ids = constants.SPORTSIPY_TEAM_IDS

    for i in range (len(team_ids)):
        #FBRef rate limits to 10 requests per about a minute
        #So set a sleep that will keep us under that
        if 0 < i <= 15 and i % 5 == 0:
            time.sleep(40)

        team = fb_team(team_ids[i])
        print(f"Pulled {team}")
        teams.append(team)
        
    #Create the players from FBref data
    for team in teams:
        for player in team.roster:
            player_data = {
                'name': data_utils.shorten_FBRef_player_names(player.name),
                'team': team.name,
                'country': player.nationality,
                'age': data_utils.convert_FBRef_player_age(player._age),
                'position_type': None,
                'shirt_number': None,
                'country_code': None,
                'continent': None
            }
            player_list.append(player_data)

    with open(constants.FBREF_PLAYERS_FILE_NAME, "wb") as output_file:
        output_file.write(orjson.dumps(player_list, "wb", option=orjson.OPT_INDENT_2))

    return

def set_player_country_data(players_df: pd.DataFrame):
    """
        Fill in a player's country, country_code and continent
    """
    cc = coco.CountryConverter()
    continent_map = country_utils.pull_continents()

    #Countries with spaces in the names have dashes for some reason in FBRef so remove the dash
    players_df['country'] = players_df['country'].map(lambda x: x.replace("-", " "))

    #Convert the country name into the more common short name/native name. 
    #For the sub contries within the UK just use hard coded values
    players_df['country'] = players_df['country'].map(lambda country: country_utils.transform_country(country, cc))

    #Set the three letter ISO code for each player's country
    #For the sub contries within the UK just use hard coded values
    players_df['country_code'] = players_df['country'].map(lambda country: country_utils.get_country_code(country, cc))

    #Set the continent for each player's country
    players_df['continent'] = players_df['country_code'].map(lambda country: country_utils.map_player_continent(country, continent_map))

    return

def pull_players_from_api_football(api_key: str, team_ids: Dict[str, str]):
    """
    Get all players from each squad from API FOOTBALL.
    This is the main source where players come from.
    This will not run if the apifootball_players.json file already exists.
    
    Args:
        api_key: Rapid API key
        team_ids: list of team_ids from API-FOOTBAL
    
    Returns:
        JSON response from the API
    """
    #maps api football id to player custom player object
    players_list = []

    #Loop through all teams and get their squad lists
    for id in team_ids:
        params = {"team": id}
        team_squad_response = data_utils.call_api_football(constants.API_FOOTBALL_SQUADS_ENDPOINT, api_key, params)
        team_squad = team_squad_response['response'][0]['players']

        #Create a player object for reach player in the squad
        for player_json in team_squad:                
            player_data = {
                'name': data_utils.fix_api_football_player_names(player_json['name'], team_ids[id]),
                'team': team_ids[id],
                'country': None,
                'age': player_json['age'],
                'position_type': player_json['position'] if player_json['position'] != "Attacker" else "Forward",
                'shirt_number': player_json['number'],
                'country_code': None,
                'continent': None
            }
            players_list.append(player_data)

    
    with open(constants.API_FOOTBALL_PLAYERS_FILE_NAME, "wb") as output_file:
        output_file.write(orjson.dumps(players_list, "wb", option=orjson.OPT_INDENT_2))

    return

def finalize_players(fbref_df: pd.DataFrame, api_football_players_map: Dict[str, Player]):
    """
    Combines data from the main source (API FOOTBALL) and the enhancing source (FBRef)
    to create a final list of players to be used by Plordle.

    Args:
        fbref_df: A pandas data frame containing data from FBRef
        api_football_players_map: A Dictionary mapping a player's name as its was from API FOOTBALL and it's player object.\
              These will be the objects in the final json list

    Returns:
        Nothing but generates a json list that will be saved to disk
    """


    mapped_teams = {}
    mapped_players = {}
    final_player_list = []

    #Use the player names and team names from FBRef to as the reference lists for fuzzy matching
    full_player_names = fbref_df['name']
    full_team_names = fbref_df['team'].unique()

    for short_player_name in api_football_players_map:      
        player = api_football_players_map[short_player_name]
        short_team_name = player.team

        #If we've already seen this team then we don't have to redo the fuzzy matching
        if short_team_name in mapped_teams:
            full_team_name = mapped_teams[short_team_name]
        else:
            full_team_name = process.extractOne(short_team_name, full_team_names, scorer=fuzz.WRatio)[0] 
        
        #Try and find a player name from FBRef that matches the current name from API-FOOTBALL
        #within a resonable fuzzy match score (50 seems to work well)
        matched_player_and_score = process.extractOne(short_player_name, full_player_names, scorer=fuzz.token_sort_ratio, score_cutoff=50)        

        #If there was a match, and we haven't already successfully matched against this name
        if matched_player_and_score and matched_player_and_score[0] not in mapped_players:
            candidate_full_player_name = matched_player_and_score[0]
            
            #Using the full team name and a potential full player name, see if there is there a row in the FBRef data 
            correct_player_row = fbref_df.loc[(fbref_df['name'] == candidate_full_player_name) & (fbref_df['team'] == full_team_name)]
            
            #if we find a row, then we have successfully matched the player
            if not correct_player_row.empty:
                #Save the mapping so that we don't try to match against it again (preventing False positives)
                mapped_players[candidate_full_player_name] = short_player_name
        
                print(f"API_FOOTBALL: {short_player_name} - {short_team_name}, FBREF: {matched_player_and_score}, Found match: {not correct_player_row.empty}")
                player.name = candidate_full_player_name
                player.team = full_team_name
                player.country = correct_player_row['country'].values[0]
                player.country_code = correct_player_row['country_code'].values[0]
                player.continent = correct_player_row['continent'].values[0]
                player.age = int(correct_player_row['age'].values[0])
                if player.shirt_number is None:
                    player.shirt_number = int(correct_player_row['shirt_number'].values[0])
                final_player_list.append(player)
            else:
                #The fuzzy match returned a false positive
                print(f"False positive match between API-FOOTBALL: {short_player_name} - {short_team_name} and FBREF:{matched_player_and_score}")
        else:
            #There wasn't a player name that matched between the data sets
            print(f"No mapping found for {short_player_name} - {short_team_name}")
    
    
    print(f"Successfully parsed and mapped {len(final_player_list)} players")
    
    #Write the final player list to a json file
    with open(constants.FINAL_OUTPUT_FILE_NAME, "wb") as output_file:
        output_file.write(orjson.dumps(final_player_list, "wb", option=orjson.OPT_INDENT_2))

    return


def main():
    #Create the list of player names if it doesn't exist   
    file_path = Path(constants.FBREF_PLAYERS_FILE_NAME)
    if not file_path.exists():
        print('Pulling from FBRef')
        pull_players_from_fbref()

    #load in the player names list
    fbref_players_df = pd.read_json(file_path)
    
    #Load in players who arent on their teams on FBref for some reason (injuries, etc.)
    #These players are formated in the same way as if they were pulled from FBRef
    manual_players_df = pd.read_json(Path(constants.MANUAL_PLAYERS_FILE_NAME))

    #Merge the maunal players into the FBRef dataset
    #fbref_players_df = pd.concat([fbref_players_df, manual_players_df], ignore_index=True)
    fbref_players_df = pd.concat([fbref_players_df, manual_players_df])

    intra_league_file_path = Path(constants.INTRA_LEAGUE_TRANSFERS_FILE_NAME)
    if intra_league_file_path.exists():
        intra_league_df = pd.read_json(intra_league_file_path)
        fbref_players_df = fbref_players_df.merge(intra_league_df, on="name", how="left")
        fbref_players_df['team'] = fbref_players_df['newTeam'].combine_first(fbref_players_df['team'])
        fbref_players_df.drop(columns=['newTeam'], inplace=True)


    #Fill in the country data for every player on fbref
    set_player_country_data(fbref_players_df)

    # If there already isn't a saved list of players from API-FOOTBALL we need to pull a fresh one down
    api_football_path = Path(constants.API_FOOTBALL_PLAYERS_FILE_NAME)
    if not api_football_path.exists():
        try:
            api_key = dotenv_values(".env")["RAPID_API_KEY"]
        except KeyError:
            print(f"Missing Rapid Api Key. Exiting")
            return
    
        #Call Teams Endpoint to get team ids
        teams = data_utils.call_api_football(constants.API_FOOTBALL_LEAGUE_ENDPOINT, api_key, constants.LEAGUE_API_PARAMS)
        team_map = {team_object['team']['id']:team_object['team']['name'] for team_object in teams['response']}

        #For each team, call the squads endpoint to get Team, "Name", Position Type, Age, Number
        #Save that data in a json file for future use and manual verification
        pull_players_from_api_football(api_key, team_map)    
    
    #Load in the players
    api_football_player_map = Player.load_into_player_map(api_football_path)
    
    #Create the final list to be used by Plordle
    finalize_players(fbref_players_df, api_football_player_map)


if __name__ == "__main__":
    main()