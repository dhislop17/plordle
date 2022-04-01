import 'package:plordle/ui/utils/text_constants.dart';

class Player {
  final int playerId;
  final String name;
  final String team;
  final String position;
  final String positionType;
  final int shirtNumber;
  final int age;
  final String country;

  const Player({
    required this.playerId,
    required this.name,
    required this.team,
    required this.position,
    required this.positionType,
    required this.shirtNumber,
    required this.age,
    required this.country,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    String? teamAbbr = TextConstants.teamAbbreviations[json['team']];
    String? pos = TextConstants.shortenedPositons[json['position']];

    return Player(
        playerId: json['playerId'],
        name: json['name'],
        team: teamAbbr ?? "None",
        position: pos ?? 'None',
        positionType: json['positionType'],
        shirtNumber: json['shirtNumber'],
        age: json['age'],
        country: json['country']);
  }

  String getFullTeamName() {
    return TextConstants.teamAbbreviations.keys.firstWhere(
        (fullName) => TextConstants.teamAbbreviations[fullName] == team);
  }

  String getFullPosition() {
    return TextConstants.shortenedPositons.keys.firstWhere(
        (fullName) => TextConstants.shortenedPositons[fullName] == position);
  }

  @override
  String toString() {
    return name + " - " + getFullTeamName();
    //return name + " - " + position + " - " + getFullTeamName();
  }
}
