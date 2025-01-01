# Plordle Player Generator

A Python script that uses data from FBref and API-FOOTBALL to generate a list of all current Premier League Players in the form of a JSON file

## Features
- Pulls player data such as Name, Position, Shirt Number, Age, and Nationality from each team in the Premier League using data from FBRef and API-FOOTBALL
    - API-FOOTBALL is used as the main source of truth, while FBRef is used to enhance the data
    - The player names from each data set don't directly match up so fuzzy matching is used to do the comparison
- Country data is sourced from the RestCountries API in order to populate a player's country, ISO3 country code, and continent
- Generates a json list of players in the league