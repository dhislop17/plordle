from lxml import html
from dataclasses import dataclass
import requests
import pandas as pd
import re
import time
import constants

@dataclass
class Player:
    name: str
    team: str
    position_type: str
    shirt_number: int
    position: str
    age: int
    country: str

def scrape_player_data(team_tree, css_row_type: str, team: str, player_list: list):
    attacker_types = {"Centre-Forward", "Right Winger", "Left Winger"}
    midfield_types = {"Attacking Midfield", "Central Midfield", "Defensive Midfield"}
    defender_types = {"Right-Back", "Centre-Back", "Left-Back"}

    for player in team_tree.cssselect(css_row_type):

        shirt_number = player.cssselect('td')[0].cssselect('td')[0].text_content()

        #Only process players who have assigned jersey numbers, avoids suspended/loaned out/youth players
        if shirt_number != '-':
            name = player.cssselect('td td a')[0].text.strip()
            position = player.cssselect('td table tr')[1].cssselect('td')[0].text.strip()

            #Map position to position type to help with player guesses 
            #Transfermarkt changed how this information is stored on the team page
            if position in defender_types:
                position_type = constants.DEFENDER
            elif position in midfield_types:
                position_type = constants.MIDFIELD
            elif position in attacker_types:
                position_type = constants.ATTACK
            else:
                position_type = constants.GOALKEEPER

            ageElement = player.cssselect('td.zentriert')[1].text_content() 
            strippedAge = re.search(r'\((\d{2})\)', ageElement).group(1)
            country = player.cssselect('td img.flaggenrahmen')[0].attrib['alt']

            #Weird special case with the ALT text for South Korea:
            if country == "Korea, South":
                country = "South Korea"

            player_list.append(Player(
                name=name,
                shirt_number=int(shirt_number),
                team=team,
                position_type=position_type,
                position=position, 
                age=int(strippedAge), 
                country=country))

def main():
    teamMap = {}
    player_list = []

    page = requests.get(constants.LEAGUE_ROUTE, headers= constants.HEADERS)
    league_tree = html.fromstring(page.content)
    start_time = time.time()

    for i in range(constants.NUMBER_OF_TEAMS):
        team = league_tree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['title']
        link = constants.BASE_ROUTE + league_tree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['href']
        teamMap[team] = link


    for team, teamUrl in teamMap.items():
        page = requests.get(teamUrl, headers= constants.HEADERS)
        teamTree = html.fromstring(page.content)

        #There are separate style sheets for odd and even rows on Transfermarkt player tables
        #Scrape data from both
        scrape_player_data(teamTree, ".items tbody tr.odd", team, player_list)
        scrape_player_data(teamTree, ".items tbody tr.even", team, player_list)

        player_data = pd.DataFrame(player_list)
        player_data.rename(columns= {'position_type': 'positionType',
                                    'shirt_number': 'shirtNumber',
                                    'country': 'country'}, inplace= True)

    #The teams on Transfermarkt are listed by finishing position from the previous season
    #Sort the list to be alphabetical by team name then by the player's shirt number
    player_data = player_data.sort_values(by=['team', 'shirtNumber'])
    player_data.to_csv("PlayerData.csv", index_label= "playerId")
    print("--- %s seconds ---" % (time.time() - start_time))

if __name__ == "__main__":
    main()