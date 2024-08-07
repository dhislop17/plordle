from lxml import html
import requests
import pandas as pd
import re
import time

BASE_ROUTE = 'https://www.transfermarkt.us'
LEAGUE_ROUTE = 'https://www.transfermarkt.us/premier-league/startseite/wettbewerb/GB1'
HEADERS = {'User-Agent': 
           'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'}
NUMBER_OF_TEAMS = 20
GOALKEEPER = "goalkeeper"
DEFENDER = "defender"
MIDFIELD = "midfielder"
ATTACK = "attacker"


page = requests.get(LEAGUE_ROUTE, headers= HEADERS)
league_tree = html.fromstring(page.content)
start_time = time.time()

teamMap = {}


for i in range(NUMBER_OF_TEAMS):
    team = league_tree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['title']
    link = BASE_ROUTE + league_tree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['href']
    teamMap[team] = link

names = []
teams = []
ages = []
shirt_numbers = []
nationalities = []
positions = []
positions_types = []

attacker_types = {"Centre-Forward", "Right Winger", "Left Winger"}
midfield_types = {"Attacking Midfield", "Central Midfield", "Defensive Midfield"}
defender_types = {"Right-Back", "Centre-Back", "Left-Back"}

for team, teamUrl in teamMap.items():
    page = requests.get(teamUrl, headers= HEADERS)
    teamTree = html.fromstring(page.content)


    for player in teamTree.cssselect('.items tbody tr.odd'):
        number = player.cssselect('td')[0].cssselect('td')[0].text_content()
        name = player.cssselect('td td a')[0].text.strip()
        position = player.cssselect('td table tr')[1].cssselect('td')[0].text.strip()

        #Map position to position type to help with player guesses 
        #Transfermarkt changed how this information is stored on the team page
        if position in defender_types:
            position_type = DEFENDER
        elif position in midfield_types:
            position_type = MIDFIELD
        elif position in attacker_types:
            position_type = ATTACK
        else:
            position_type = GOALKEEPER

        ageElement = player.cssselect('td.zentriert')[1].text_content() 
        strippedAge = re.search(r'\((\d{2})\)', ageElement).group(1)
        country = player.cssselect('td img.flaggenrahmen')[0].attrib['alt']
        
        #Only Add Players who have assigned numbers to data frame, avoids suspended/loaned out/youth players
        if number != '-':
            names.append(name)
            teams.append(team)
            ages.append(int(strippedAge))
            shirt_numbers.append(int(number))
            nationalities.append(country)
            positions.append(position)
            positions_types.append(position_type)

    for player in teamTree.cssselect('.items tbody tr.even'):
        number = player.cssselect('td')[0].cssselect('td')[0].text_content()
        name = player.cssselect('td td a')[0].text.strip()
        position = player.cssselect('td table tr')[1].cssselect('td')[0].text.strip()

        #Map position to position type to help with player guesses 
        #Transfermarkt changed how this information is stored on the team page
        if position in defender_types:
            position_type = DEFENDER
        elif position in midfield_types:
            position_type = MIDFIELD
        elif position in attacker_types:
            position_type = ATTACK
        else:
            position_type = GOALKEEPER

        ageElement = player.cssselect('td.zentriert')[1].text_content() 
        strippedAge = re.search(r'\((\d{2})\)', ageElement).group(1)
        country = player.cssselect('td img.flaggenrahmen')[0].attrib['alt']

        if number != '-':
            names.append(name)
            teams.append(team)
            ages.append(int(strippedAge))
            shirt_numbers.append(int(number))
            nationalities.append(country)
            positions.append(position)
            positions_types.append(position_type)


player_data = pd.DataFrame({
    'Name': names,
    'Team': teams,
    'PositionType': positions_types,
    'Position': positions,
    'ShirtNumber' : shirt_numbers,
    'Age': ages,
    'Country' : nationalities,
})

player_data = player_data.sort_values(by=['Team', 'ShirtNumber'])
player_data.to_csv("PlayerData24.csv", index_label="PlayerId")
print("--- %s seconds ---" % (time.time() - start_time))