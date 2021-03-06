import 'package:plordle/models/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<Stat> getUnlimitedModeStat() async {
    final prefs = await SharedPreferences.getInstance();
    int gamesPlayed = prefs.getInt('unlimited_gp') ?? 0;
    int wins = prefs.getInt('unlimited_wins') ?? 0;
    int losses = prefs.getInt('unlimited_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<Stat> getMysteryModeStat() async {
    final prefs = await SharedPreferences.getInstance();
    int gamesPlayed = prefs.getInt('mystery_gp') ?? 0;
    int wins = prefs.getInt('mystery_wins') ?? 0;
    int losses = prefs.getInt('mystery_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveUnlimitedModeStat(Stat stat) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('unlimited_gp', stat.gamesPlayed);
    prefs.setInt('unlimited_wins', stat.wins);
    prefs.setInt('unlimited_losses', stat.losses);
  }

  Future<void> saveMysteryModeStat(Stat stat) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('mystery_gp', stat.gamesPlayed);
    prefs.setInt('mystery_wins', stat.wins);
    prefs.setInt('mystery_losses', stat.losses);
  }

  Future<bool> getSolvedMystery() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('solved_mystery') ?? false;
  }

  Future<void> saveSolvedMystery(bool solvedMystery) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('solved_mystery', solvedMystery);
  }

  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_done') ?? false;
  }

  Future<void> saveOnboardingStatus(bool onboardingFinished) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding_done', onboardingFinished);
  }

  void clearSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //TODO: implement saving guesses and loading guess
}
