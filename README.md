# PLORDLE
A guessing game about English Premier League players

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=fff)](#)
[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff)](#)
[![Firebase](https://img.shields.io/badge/Firebase-039BE5?logo=Firebase&logoColor=white)](#)

## Features
### Game Features
- Includes every player from all 20 Premier League teams' 2024-25 squads (up to date as of March 25, 2025)
    - Players who don't have a shirt number are not included
- 2 Game Modes
    - Normal - unlimited tries per day, with the ability to filter out players by team
    - Challenge - one attempt per day, no filtering allowed
- Guesses are updated with the flag emoji for the player's country (or a Shamrock For Northern Ireland)
- 5 Difficulty Levels
- 21 different themes and support for Light and Dark Mode
    - Default Theme based on the Premier League's color scheme
    - All 20 teams have their own theme matching their color scheme
- Stat tracking

### Technical Features
- Players list is generated using a Python script that pulls data from API-FOOTBALL and FBRef
    - Uses fuzzy matching to combine player information from each data source into a useable datapoint for the app
- Diacritic (accent mark) insensitive search on player names

## How To Play
- 10 guesses to figure out the mystery player
- Each guess has color-coded columns giving the player feedback on how close they are to the correct answer
    - Green in any column means a successful match
    - Yellow in the number column means the mystery player is within 10 of the guessed player's shirt number
    - Yellow in the age column means the mystery player is within 5 of the guessed player's age
    - Yellow in the country column means the mystery player is from the same continent but not the same country

## Demo
*Guessing the daily player for 3/25/25 - Matai Akinmboni (Bournemouth Defender)*
  

<img alt="3/25/25 Player of the Day - Matai Akinmboni" src = "./plordle-media/plordleDemo.gif" width = 300>


## Example Theme Screenshots

| Manchester United Light Theme | Newcastle United Light Theme | Brighton & Hove Albion Light Theme | 
| :---: | :---: | :---: | 
| <img alt="Manchester United Light Mode Theme" src = "./plordle-media/Manchester United Light Mode.jpg" width = 300> |<img alt="Newcastle Light Mode Theme" src = "./plordle-media/Newcastle Light Theme.jpg" width = 300> | <img alt="Brighton & Hove Albion Light Mode Theme" src = "./plordle-media/Brighton Light Mode.jpg" width = 300> | 


| Premier League Dark Theme | Liverpool Dark Theme | Aston Villa Dark Theme | 
| :---: | :---: | :---: | 
| <img alt="Premier League Dark Mode Theme" src = "./plordle-media/Premier League Dark Mode.jpg" width = 300> |<img alt="Liverpool Dark Mode Theme" src = "./plordle-media/Liverpool Dark Mode.jpg" width = 300> | <img alt="Aston Villa Light Mode Theme" src = "./plordle-media/Aston Villa Dark Theme.jpg" width = 300> | 


## Stretch Goals
- More options for filtering players (by country/continent, min/max age, or shirt number)
- Support for historical squads 
- Cross platform stat tracking
