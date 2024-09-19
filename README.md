# Plordle
(Updates in progress ahead of the new season) <br>
An English Premier League themed Wordle game to practice my Flutter skills and try out some new technologies

## Features
- Player database populated from all 20 Premier League teams' 2024-25 squads (up to date as of September 19, 2024)
- Guesses are updated with the flag emoji for the player's country (or a Shamrock For Northern Ireland)
- Variable Themes and Difficulties
- Options to guess a new mystery player every day or continuously guess random players (players who don't have a shirt number are not included)
- Stat tracking
- Dockerized API
- Customizable web scraper to pull player data from Transfermarkt


## How To Play
- 10 guesses to figure out the mystery player
- Each guess has color-coded columns giving the player feedback on how close they are to the correct answer
    - Green in any column means a successful match
    - Yellow in the position column means the mystery player has the same position type but normally plays in a different role (ex: Correctly guessed a Defender but specifically guessed a Left Back when the mystery player was a Center Back)
    - Yellow in the age or number column means the mystery player is within 5 of the guessed player's age or shirt number
    - Yellow in the country column means the mystery player is from the same continent but not the same country

## Demo
*NEW GIF COMING SOON  - Guessing the daily player for 7/8/22 - Harry Lewis (former Southampton Goalkeeper)*
  

<img alt="7/8/22 Player of the Day -  Harry Lewis" src = "./readme-gifs/plordleDemoGif.gif" width = 300>
  



## To-Do
- [x] Finish Readme
- [x] Finish Containerization of API
- [ ] Finish Updates For 2024-25 Season
    - [x] UI Updates (Flag Emojis, Variable Themes)
    - [x] Filtering The List of Teams to Play Against
    - [x] Migrate away from the default SharedPreferences API
    - [x] Difficulty Options 
    - [x] Add support for hints for the country box in guesses
    - [x] Update the players list once the transfer window closes and squad lists are finalized
    - [ ] Update Readme GIF
- [ ] Finish App onboarding flow

## Stretch Goals
- More Options for Filtering Players (by country/continent, min/max age, or shirt number)
- Support for historical squads 
    - Support for squads after specific points during a season (after the summer or winter transfer windows)
    - Support for multiple seasons
