##### Countries Constants #####
EUROPE = "Europe"
ASIA = "Asia"
AFRICA = "Africa"
OCEANIA = "Oceania"
NORTH_AMERICA = "North America"
SOUTH_AMERICA = "South America"
REST_COUNTRIES_BASE_URL = "https://restcountries.com/v3.1/region/"

HOME_NATIONS_MAP = {"England": "ENG", "Scotland" : "SCT", "Wales": "WLS", "Northern Ireland": "NIR"}


##### File Name Constants #####
FBREF_PLAYERS_FILE_NAME = 'fbref_players.json'
MANUAL_PLAYERS_FILE_NAME = "manually_created_players.json"
API_FOOTBALL_PLAYERS_FILE_NAME = "apifootball_players.json"
FINAL_OUTPUT_FILE_NAME = "final_plordle_players.json"
INTRA_LEAGUE_TRANSFERS_FILE_NAME = "winter_intra_league_transfers.json"

##### API FOOTBALL Constants #####
API_FOOTBALL_BASE_URL = "https://api-football-v1.p.rapidapi.com/v3"
API_FOOTBALL_PL_ID = 39
API_FOOTBALL_SEASON = 2024
LEAGUE_API_PARAMS = {
    "league": API_FOOTBALL_PL_ID,
    "season": API_FOOTBALL_SEASON
}
API_FOOTBALL_LEAGUE_ENDPOINT = "teams"
API_FOOTBALL_SQUADS_ENDPOINT = "players/squads"


SPORTSIPY_TEAM_IDS = [
    '18bb7c10', #arsenal
    '8602292d', #aston villa
    '4ba7cbea', #bournemouth 
    'cd051869', #brentford
    'd07537b9', #brighton & hove albion
    'cff3d9bb', #chelsea
    '47c64c55', #crystal palace
    'd3fd31cc', #everton
    'fd962109', #fulham
    'b74092de', #ipswich town 
    '822bd0ba', #liverpool                                                     
    'a2d435b3', #leicester city
    'b8fd03ef', #manchester city
    '19538871', #manchester united
    'b2b47a98', #newcastle united
    'e4a775cb', #nottingham forest
    '33c895d4', #southampton
    '361ca564', #tottenham hotspur
    '7c21e445', #west ham united  
    '8cec06e1' #wolverhampton wanderers
]

LEAGUE_API_PARAMS = {
    "league": API_FOOTBALL_PL_ID,
    "season": API_FOOTBALL_SEASON
}


######### (TODO: find a use in the future) Leftover constants from the old Transfermarkt Scraper  ############
# GOALKEEPER = "Goalkeeper"
# DEFENDER = "Defender"
# MIDFIELD = "Midfielder"
# FORWARD = "Forward"
# FORWARD_TYPES = {"Centre-Forward", "Second Striker", "Right Winger", "Left Winger"}
# MIDFIELD_TYPES = {"Attacking Midfield", "Central Midfield", "Left Midfield", "Right Midfield", "Defensive Midfield"}
# DEFENDER_TYPES = {"Right-Back", "Centre-Back", "Left-Back"}


