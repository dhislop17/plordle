import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';

class Player {
  //final int playerId;
  final String name;
  final String team;
  final String teamAbbr;
  final String shortPositionType;
  final String positionType;
  final int shirtNumber;
  final int age;
  final String country;
  final String countryCode;
  final String continent;

  const Player(
      {
      //required this.playerId,
      required this.name,
      required this.team,
      required this.teamAbbr,
      required this.shortPositionType,
      required this.positionType,
      required this.shirtNumber,
      required this.age,
      required this.country,
      required this.countryCode,
      required this.continent});

  factory Player.fromJson(Map<String, dynamic> json) {
    String? teamAbbr = Constants.teamAbbreviations[json['team']];
    String? shortPosType =
        Constants.shortenedPositionTypes[json['position_type']];

    return Player(
        //playerId: json['playerId'],
        name: json['name'],
        team: json['team'],
        teamAbbr: teamAbbr ?? "None",
        shortPositionType: shortPosType ?? 'None',
        positionType: json['position_type'],
        shirtNumber: json['shirt_number'],
        age: json['age'],
        country: json['country'],
        countryCode: json['country_code'],
        continent: json['continent']);
  }

  String getFullTeamName() {
    return Constants.teamAbbreviations.keys.firstWhere(
        (fullName) => Constants.teamAbbreviations[fullName] == team);
  }

  // String getFullPosition() {
  //   return TextConstants.shortenedPositons.keys.firstWhere(
  //       (fullName) => TextConstants.shortenedPositions[fullName] == position);
  // }

  @override
  String toString() {
    return "#$shirtNumber - $name - $positionType - $team - Age: $age - $country";
  }

  String getPlayerAdditionalInfo(DifficultyOptions difficultyOption) {
    String additionalInfo = "";
    switch (difficultyOption) {
      case DifficultyOptions.easy: //Relegation Battle
        additionalInfo =
            "#$shirtNumber - $positionType - $team - Age: $age - $country";
      case DifficultyOptions.normal: //Mid Table Club
        additionalInfo = "#$shirtNumber - $positionType - $team - $country";
      case DifficultyOptions.hard: //Top 4 Challenger
        additionalInfo = "#$shirtNumber - $positionType - $team - $continent";
      case DifficultyOptions.challenge: //Premier League Champion
        additionalInfo = "#$shirtNumber - $positionType - $team";
      default: //Invincibles
        additionalInfo = "";
    }

    return additionalInfo;
  }
}
