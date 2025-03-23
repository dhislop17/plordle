import 'package:plordle/models/stat.dart';

class User {
  Stat normalModeStat;
  Stat challengeModeStat;
  DateTime lastAttemptedChallengeDate;

  String get normalModeStatString => normalModeStat.toString();

  String get challengeModeStatString => challengeModeStat.toString();

  User(
      {required this.normalModeStat,
      required this.challengeModeStat,
      required this.lastAttemptedChallengeDate});

  void playedNormalModeGame(bool wonGame) {
    normalModeStat.gamesPlayed++;
    if (wonGame) {
      normalModeStat.wins++;
    } else {
      normalModeStat.losses++;
    }
  }

  void playedChallengeModeGame(bool wonGame) {
    challengeModeStat.gamesPlayed++;
    var today = DateTime.now();
    lastAttemptedChallengeDate = DateTime(today.year, today.month, today.day);

    if (wonGame) {
      challengeModeStat.wins++;
    } else {
      challengeModeStat.losses++;
    }
  }

  void resetUser() {
    resetStats();
    lastAttemptedChallengeDate = DateTime(2016);
  }

  void resetStats() {
    normalModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
    challengeModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
  }
}
