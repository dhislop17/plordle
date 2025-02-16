from typing import Dict
import country_converter as coco
import requests

import constants as constants


def pull_continents() -> Dict[str, set]:
    #Hardcoding the Home Nations, Kosovo, and Turkey to be in Europe
    #Save time and resources by hard coding the most likely Oceanic countries
    continent_map = {constants.EUROPE: {"ENG", "SCT", "WLS", "NIR", "TUR", "XKX"}, constants.OCEANIA : {'AUS', 'NZL'}}

    params = {
        'fields': 'cca3'
    }

    #### Africa #####
    continent_map[constants.AFRICA] = set()
    response = requests.get(f"{constants.REST_COUNTRIES_BASE_URL}africa", params=params)
    continent_data = response.json()

    for mapping in continent_data:
        continent_map[constants.AFRICA].add(mapping['cca3'])
    
    #### Asia #####
    continent_map[constants.ASIA] = set()
    response = requests.get(f"{constants.REST_COUNTRIES_BASE_URL}asia", params=params)
    continent_data = response.json()

    for mapping in continent_data:
        continent_map[constants.ASIA].add(mapping['cca3'])

    #Turkey is a member of UEFA and the EU so it will be included in only Europe
    continent_map[constants.ASIA].remove("TUR")

    #### EUROPE #####
    response = requests.get(f"{constants.REST_COUNTRIES_BASE_URL}europe", params=params)
    continent_data = response.json()

    for mapping in continent_data:
        continent_map[constants.EUROPE].add(mapping['cca3'])
    #The UK is replaced with the unoffical three letter codes for each of the Home Nations
    continent_map[constants.EUROPE].remove("GBR")

    ##### South America #####
    continent_map[constants.SOUTH_AMERICA] = set()
    response = requests.get(f"{constants.REST_COUNTRIES_BASE_URL}south america", params=params)
    continent_data = response.json()

    for mapping in continent_data:
        continent_map[constants.SOUTH_AMERICA].add(mapping['cca3'])

    # By process of elimiation anywhere else is in North America. 
    # Doing this avoids doing extra calls for each of the subregions in North America
    return continent_map

def transform_country(country_name: str, country_converter: coco.CountryConverter) -> str:
    if country_name not in constants.HOME_NATIONS_MAP.keys():
        return country_converter.convert(country_name, to="short_name")
    else:
        return country_name

def get_country_code(country_name: str, country_converter: coco.CountryConverter) -> str:
    #The Home Nations don't have offical codes
    #So use the ones in the constants map
    if country_name in constants.HOME_NATIONS_MAP:
        return constants.HOME_NATIONS_MAP[country_name]
    else:
        return country_converter.convert([country_name], to="ISO3")

def map_player_continent(country_code: str, continent_map: Dict[str, str]):
    #Map the player's country to the continent
    if country_code in continent_map[constants.AFRICA]:
        return constants.AFRICA
    elif country_code in continent_map[constants.ASIA]:
        return constants.ASIA
    elif country_code in continent_map[constants.EUROPE]:
        return constants.EUROPE
    elif country_code in continent_map[constants.OCEANIA]:
        return constants.OCEANIA
    elif country_code in continent_map[constants.SOUTH_AMERICA]:
        return constants.SOUTH_AMERICA
    else:
        return constants.NORTH_AMERICA

