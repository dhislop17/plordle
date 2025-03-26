from typing import Dict
import requests
import constants as constants


def call_api_football(endpoint: str, api_key: str, params: Dict[str, str] = None):
    """
    Base function for calling API-FOOTBALL via Rapid API.
    
    Args:
        endpoint: API endpoint to call
        params: Optional query parameters
    
    Returns:
        JSON response from the API
    """

    if params is None:
        params = {}
    
    headers = {
        "x-rapidapi-key": api_key
    }
    url = f"{constants.API_FOOTBALL_BASE_URL}/{endpoint}"
    response = requests.get(
        url,
        headers=headers,
        params=params, timeout=30
    )
    # Raises an HTTPError for bad responses
    response.raise_for_status()  

    return response.json()


def shorten_FBRef_player_names(player_name: str) -> str:
    """
    FBRef has the uncommon longer version of certain players' names.
    This function corrects that using the hardcoded shorter versions (not ideal)
    """
    common_name_map = {
        "Manuel Ugarte Ribeiro": "Manuel Ugarte",
        "Valentino Livramento": "Tino Livramento",
        "Bobby Reid":"Bobby De Cordova-Reid",
        "Emerson Palmieri": "Emerson",
        "Kepa Arrizabalaga": "Kepa",
        "Kim Jisoo":"Kim Ji-soo",
        "Edmond-Paris Maghoma": "Paris Maghoma",
        "Jaden Philogene Bidace": "Jaden Philogene",
        "Chidozie Obi-Martin": "Chido Obi",
        "Victor Bernth Kristiansen": "Victor Kristiansen",
        "Abdul Fatawu Issahaku": "Abdul Fatawu",
        "Sávio" : "Savinho"
    }

    if player_name in common_name_map:
        return common_name_map[player_name]
    else:
        return player_name
    
def convert_FBRef_player_age(age_string: str) -> int:
    """
    FBRef tracks a player's age as a string in the form years-days.
    This function strips out the years from a player's age and returns it as an int
    """
    year_and_days = age_string.split("-")
    
    #Some players don't have an age on there for some reason so just return 0
    return int(year_and_days[0]) if len(age_string) > 0 else 0
    
def fix_api_football_player_names(player_name: str, team_name: str) -> str:
    """
    This method breaks ambiguiites between certain names from API-FOOTBALL
    to make fuzzy matching easier
    """

    if player_name == "A. Onana" :
        if team_name == "Aston Villa":
            return "Amadou Onana"
        else:
            return "Andre Onana"
    elif player_name == "J. Mateta":
        return "Jean-Philippe Mateta"
    elif player_name == "C. Doucouré":
        return "Cheick Doucouré"
    elif player_name == "A. Doucouré":
        return "Abdoulaye Doucouré"
    elif player_name == "C. Taylor":
        return  "Charlie Taylor"
    elif player_name == "J. Taylor":
        return "Jack Taylor"
    elif player_name == "F. Umeh":
        return "Franco Umeh-Chibueze"
    elif player_name == "W. Dennis":
        return "Will Dennis"
    elif player_name == "O. Martin":
        return "Chido Obi"
    elif player_name == "Sávio":
        return "Savinho"
    # elif player_name == "E. Dennis":
    #     return "Emmanuel Dennis"
    else:
        return player_name