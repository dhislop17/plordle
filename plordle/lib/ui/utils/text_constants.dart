class TextConstants {
  //Titles and info strings
  static const String onboardingPageTitle = 'Welcome to Plordle';
  static const String gameTitle = 'PLORDLE';
  static const String gameSubtitle = 'Guess The Player';
  static const String filterPageTitle = 'Choose Teams to Include';
  static const String gridNameHeader = 'Name';
  static const String gridTeamHeader = 'Team';
  static const String gridPositionHeader = 'Position';
  static const String gridNumberHeader = 'Number';
  static const String gridAgeHeader = 'Age';
  static const String gridCountryHeader = 'Country';

  //Gameover Dialog
  static const String winnerText = 'You Win';
  static const String loserText = 'Game Over';
  static const String viewStats = 'View Stats';
  static const String continueGameText = 'Unlimited Mode';
  static const String playerHint = 'The correct player was:';

  //Help Dialog
  static const String helpDialogTitle = 'How To Play';
  static const String helpDialogSubtitle = 'Guess the player in 10 tries';
  static const String helpDialogInfoText =
      'The column color after each guess will inidicate how close the guess was to the correct answer';
  static const String helpDialogGreenText = 'Green in any column';
  static const String helpDialogGreenSub = ' means a successful match';
  static const String helpDialogPositionText = 'Yellow in the position column';
  static const String helpDialogPositionSubtext =
      ' means the mystery player has the same position type but plays in a different role';
  static const String helpDialogNumberText =
      'Yellow in the age or number column';
  static const String helpDialogNumberSubtext =
      " means guessed player is within 5 of the mystery player's age or shirt number";
  static const String helpDialogGameInfo =
      "New mystery player at midnight in your timezone, or play in unlimited mode to keep getting a new mystery player";

  //Grid number boxes arrows
  static const String downArrow = '\u{2193}';
  static const String upArrow = '\u{2191}';

  //Home Nations Emoji Flag Data - UK's subcountires don't
  //have offical flag emojis

  //England, Scotland, and Wales all have to use converted unicode values
  //to have their flag represented
  static const Map<String, List<int>> albionNationsFlagMap = {
    'ENG': [127988, 917607, 917602, 917605, 917614, 917607, 917631],
    'SCT': [127988, 917607, 917602, 917619, 917603, 917620, 917631],
    'WLS': [127988, 917607, 917602, 917623, 917612, 917619, 917631],
  };

  //Northern Ireland doesn't have a flag emoji just use a shamrock
  static const List<String> northernIrelandCharSequence = [
    '\u{2618}',
    '\u{FE0F}'
  ];

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

  static final List<String> teamsList = [
    'Arsenal FC',
    'Aston Villa',
    'AFC Bournemouth',
    'Brentford FC',
    'Brighton & Hove Albion',
    'Chelsea FC',
    'Crystal Palace',
    'Everton FC',
    'Fulham FC',
    'Ipswich Town',
    'Leicester City',
    'Liverpool FC',
    'Manchester City',
    'Manchester United',
    'Newcastle United',
    'Nottingham Forest',
    'Southampton FC',
    'Tottenham Hotspur',
    'West Ham United',
    'Wolverhampton Wanderers'
  ];

  static final Map<String, String> teamAbbreviations = {
    'Arsenal FC': 'ARS',
    'Aston Villa': 'AVL',
    'AFC Bournemouth': 'BOU',
    'Brentford FC': 'BRE',
    'Brighton & Hove Albion': 'BHA',
    'Burnley FC': 'BUR', //Championship
    'Chelsea FC': 'CHE',
    'Crystal Palace': 'CRY',
    'Everton FC': 'EVE',
    'Fulham FC': 'FUL',
    'Ipswich Town': 'IPS',
    'Leeds United': 'LEE', //Championship
    'Leicester City': 'LEI',
    'Liverpool FC': 'LIV',
    'Luton Town': 'LUT', //Championship
    'Manchester City': 'MCI',
    'Manchester United': 'MUN',
    'Middlesbrough FC': 'MID', //Championship
    'Newcastle United': 'NEW',
    'Norwich City': 'NOR', //Championship
    'Nottingham Forest': 'NFO',
    'Sheffield United': 'SHU', //Championship
    'Southampton FC': 'SOU',
    'Tottenham Hotspur': 'TOT',
    'Watford FC': 'WAT', //Championship
    'West Ham United': 'WHU',
    'Wolverhampton Wanderers': 'WOL',
    'West Bromwich Albion': 'WBA' //Championship
  };
}
