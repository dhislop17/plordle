class Stat {
  int wins;
  int losses;
  int gamesPlayed;

  Stat({required this.gamesPlayed, required this.wins, required this.losses});

  @override
  String toString() {
    return "Games Played: $gamesPlayed, Wins: $wins, Losses: $losses";
  }
}
