class Guess {
  final String guessName;
  final bool sameTeam;
  final bool sameType;
  //final bool samePosition;
  final int ageDiff;
  final int shirtNumberDiff;
  final bool sameCountry;
  final bool sameContinent;

  const Guess(
      {required this.guessName,
      required this.sameTeam,
      //required this.samePosition,
      required this.sameType,
      required this.shirtNumberDiff,
      required this.ageDiff,
      required this.sameCountry,
      required this.sameContinent});

  @override
  String toString() {
    return '$guessName Team:$sameTeam Position:$sameType';
  }
}
