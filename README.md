# Plordle
An English Premier League themed Wordle game to practice my Flutter skills and try out some new technologies

## Features
### Game Features
- Includes every player from all 20 Premier League teams' 2024-25 squads (up to date as of February 15, 2025)
    - Players who don't have a shirt number are not included
- Guesses are updated with the flag emoji for the player's country (or a Shamrock For Northern Ireland)
- 5 Difficulty Levels
- 21 different themes and support for Light and Dark Mode
    - Default Theme based on the Premier League's color scheme
    - All 20 teams have their own theme matching their color scheme
- Options to guess a new mystery player every day or continuously guess random players
- Options to to choose which teams to guess players from
- Stat tracking

### Technical Features
- Built using Flutter 3.27, .NET, Python, and MongoDB
- Player database populated using a Python script that pulls data from API-FOOTBALL and FBRef
    - Uses fuzzy matching to combine player information from each datasource into a useable datapoint for the app
- Diacrtic (accent mark) insensitve search on player names
- Dockerized API

## How To Play
- 10 guesses to figure out the mystery player
- Each guess has color-coded columns giving the player feedback on how close they are to the correct answer
    - Green in any column means a successful match
    - Yellow in the number column means the mystery player is within 10 of the guessed player's shirt number
    - Yellow in the age column means the mystery player is within 5 of the guessed player's age
    - Yellow in the country column means the mystery player is from the same continent but not the same country

## Demo
*Guessing the daily player for 2/15/25 - Guglielmo Vicario (Tottenham Goalkeeper)*
  

<img alt="2/15/25 Player of the Day - Guglielmo Vicario" src = "./plordle-media/newPlordleRecording.gif" width = 300>


## Example Theme Screenshots

| Manchester United Light Theme | Newcastle United Light Theme | Brighton & Hove Albion Light Theme | 
| :---: | :---: | :---: | 
| <img alt="Manchester United Light Mode Theme" src = "./plordle-media/Manchester United Light Mode.jpg" width = 300> |<img alt="Newcastle Light Mode Theme" src = "./plordle-media/Newcastle Light Theme.jpg" width = 300> | <img alt="Brighton & Hove Albion Light Mode Theme" src = "./plordle-media/Brighton Light Mode.jpg" width = 300> | 


| Premier League Dark Theme | Liverpool Dark Theme | Aston Villa Dark Theme | 
| :---: | :---: | :---: | 
| <img alt="Premier League Dark Mode Theme" src = "./plordle-media/Premier League Dark Mode.jpg" width = 300> |<img alt="Liverpool Dark Mode Theme" src = "./plordle-media/Liverpool Dark Mode.jpg" width = 300> | <img alt="Aston Villa Light Mode Theme" src = "./plordle-media/Aston Villa Dark Theme.jpg" width = 300> | 

## To-Do
- [ ] Finish up game flow

## Stretch Goals
- More Options for Filtering Players (by country/continent, min/max age, or shirt number)
- Support for historical squads 
    - Support for squads after specific points during a season (after the summer or winter transfer windows)
    - Support for multiple seasons
