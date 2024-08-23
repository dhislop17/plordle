import 'package:plordle/models/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Migrate all methods to new async shared prefrences interface
class StorageService {
  Future<Stat> getUnlimitedModeStat() async {
    final prefs = await SharedPreferences.getInstance();
    int gamesPlayed = prefs.getInt('unlimited_gp') ?? 0;
    int wins = prefs.getInt('unlimited_wins') ?? 0;
    int losses = prefs.getInt('unlimited_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveUnlimitedModeStat(Stat stat) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('unlimited_gp', stat.gamesPlayed);
    prefs.setInt('unlimited_wins', stat.wins);
    prefs.setInt('unlimited_losses', stat.losses);
  }

  Future<Stat> getMysteryModeStat() async {
    final prefs = await SharedPreferences.getInstance();
    int gamesPlayed = prefs.getInt('mystery_gp') ?? 0;
    int wins = prefs.getInt('mystery_wins') ?? 0;
    int losses = prefs.getInt('mystery_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
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

  /// Gets the name of the theme saved in data or defaults
  /// to the Premier League theme
  Future<String> getThemeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme_name') ?? 'Premier League';
  }

  /// Saves the name of the theme in use
  Future<void> saveThemeName(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_name', themeName);
  }

  void clearSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<List<String>> getExcludedTeams() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('excluded_teams') ?? [];
  }

  Future<void> saveExcludedTeams(List<String> excludedTeams) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('excluded_teams', excludedTeams);
  }

  //TODO: implement saving guesses and loading guess
}
