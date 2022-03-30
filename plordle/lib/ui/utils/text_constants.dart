class TextConstants {
  //Titles and info strings
  static const String gameTitle = 'PLORDLE';
  static const String gameSubtitle = 'EPL Player Guessing Game';
  static const String gridNameHeader = 'Name';
  static const String gridTeamHeader = 'Team';
  static const String gridPositionHeader = 'Position';
  static const String gridNumberHeader = 'Number';
  static const String gridAgeHeader = 'Age';
  static const String gridCountryHeader = 'Country';

  //Grid number boxes arrows
  static const String downArrow = '\u{2193}';
  static const String upArrow = '\u{2191}';

  //Abbreviations Maps
  static final Map<String, String> shortenedPositons = {
    'Goalkeeper': 'GK',
    'Right-Back': 'RB',
    'Centre-Back': 'CB',
    'Left-Back': 'LB',
    'Right Midfield': 'RM',
    'Defensive Midfield': 'DM',
    'Central Midfield': 'CM',
    'Left Midfield': 'LM',
    'Right Winger': 'RW',
    'Attacking Midfield': 'AM',
    'Left Winger': 'LW',
    'Second Striker': 'SS',
    'Centre-Forward': 'CF'
  };

  static final Map<String, String> teamAbbreviations = {
    'Arsenal FC': 'ARS',
    'Aston Villa': 'AVL',
    'Brentford FC': 'BRE',
    'Brighton & Hove Albion': 'BHA',
    'Burnley FC': 'BUR',
    'Chelsea FC': 'CHE',
    'Crystal Palace': 'CRY',
    'Everton FC': 'EVE',
    'Leeds United': 'LEE',
    'Leicester City': 'LEI',
    'Liverpool FC': 'LIV',
    'Manchester City': 'MCI',
    'Manchester United': 'MUN',
    'Newcastle United': 'NEW',
    'Norwich City': 'NOR',
    'Southampton FC': 'SOU',
    'Tottenham Hotspur': 'TOT',
    'Watford FC': 'WAT',
    'West Ham United': 'WHU',
    'Wolverhampton Wanderers': 'WOL'
  };
}
