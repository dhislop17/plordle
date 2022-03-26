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
    return Player(
        playerId: json['playerId'],
        name: json['name'],
        team: json['team'],
        position: json['position'],
        positionType: json['positionType'],
        shirtNumber: json['shirtNumber'],
        age: json['age'],
        country: json['country']);
  }

  @override
  String toString() {
    return name;
  }
}
