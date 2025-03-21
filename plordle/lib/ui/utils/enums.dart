enum GameState { pregame, inProgress, won, lost, doneForTheDay }

enum DifficultyOptions {
  easy("Relegation Battle"),
  normal("Mid Table Club"),
  hard("Top 4 Challenger"),
  challenge("PL Champion"),
  expert("Invincibles");

  const DifficultyOptions(this.label);
  final String label;
}
