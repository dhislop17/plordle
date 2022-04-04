class Stat {
  int wins;
  int losses;

  Stat({required this.wins, required this.losses});

  @override
  String toString() {
    return "Wins: $wins, Losses: $losses";
  }
}
