from lxml import html
import requests
import pandas as pd
import numpy as np
import re
import time

baseRoute = 'https://www.transfermarkt.us'
leagueRoute = 'https://www.transfermarkt.us/premier-league/startseite/wettbewerb/GB1'
headers = {'User-Agent': 
           'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'}

page = requests.get(leagueRoute, headers= headers)
leagueTree = html.fromstring(page.content)
start_time = time.time()

teamMap = {}

for i in range(20):
    team = leagueTree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['title']
    link = baseRoute + leagueTree.cssselect(".items tbody tr")[i].cssselect("td a")[0].attrib['href']
    teamMap[team] = link

teamMap

names = []
teams = []
ages = []
shirtNumbers = []
nationalities = []
positions = []
positionsTypes = []

for k,v in teamMap.items():
    page = requests.get(v, headers= headers)
    teamTree = html.fromstring(page.content)

    for player in teamTree.cssselect('.items tbody tr.odd'):
        number = player.cssselect('td')[0].cssselect('td')[0].text_content()
        name = player.cssselect('td td a')[1].attrib['title']
        position = player.cssselect('td table tr')[1].cssselect('td')[0].text_content()
        positionType = player.cssselect('td')[0].attrib['title'].lower()
        age = re.search(r'\((\d{2})\)',player.cssselect('td')[6].text_content()).group(1)
        country = player.cssselect('td img.flaggenrahmen')[0].attrib['alt']
        
        if number != '-':
            names.append(name)
            teams.append(k)
            ages.append(int(age))
            shirtNumbers.append(int(number))
            nationalities.append(country)
            positions.append(position)
            positionsTypes.append(positionType)

    for player in teamTree.cssselect('.items tbody tr.even'):
        number = player.cssselect('td')[0].cssselect('td')[0].text_content()
        name = player.cssselect('td td a')[1].attrib['title']
        position = player.cssselect('td table tr')[1].cssselect('td')[0].text_content()
        positionType = player.cssselect('td')[0].attrib['title'].lower()
        age = re.search(r'\((\d{2})\)',player.cssselect('td')[6].text_content()).group(1)
        country = player.cssselect('td img.flaggenrahmen')[0].attrib['alt']

        if number != '-':
            names.append(name)
            teams.append(k)
            ages.append(int(age))
            shirtNumbers.append(int(number))
            nationalities.append(country)
            positions.append(position)
            positionsTypes.append(positionType)


playerData = pd.DataFrame({
    'Name': names,
    'Team': teams,
    'PositionType': positionsTypes,
    'Position': positions,
    'ShirtNumber' : shirtNumbers,
    'Age': ages,
    'Country' : nationalities,
})

playerData = playerData.sort_values(by=['Team', 'ShirtNumber'])
playerData.to_csv("PlayerData.csv", index_label="PlayerId")
print("--- %s seconds ---" % (time.time() - start_time))

