import 'package:plordle/models/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferencesAsync prefs;

  StorageService() {
    prefs = SharedPreferencesAsync();
  }

  Future<Stat> getUnlimitedModeStat() async {
    int gamesPlayed = await prefs.getInt('unlimited_gp') ?? 0;
    int wins = await prefs.getInt('unlimited_wins') ?? 0;
    int losses = await prefs.getInt('unlimited_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveUnlimitedModeStat(Stat stat) async {
    await prefs.setInt('unlimited_gp', stat.gamesPlayed);
    await prefs.setInt('unlimited_wins', stat.wins);
    await prefs.setInt('unlimited_losses', stat.losses);
  }

  Future<Stat> getMysteryModeStat() async {
    int gamesPlayed = await prefs.getInt('mystery_gp') ?? 0;
    int wins = await prefs.getInt('mystery_wins') ?? 0;
    int losses = await prefs.getInt('mystery_losses') ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveMysteryModeStat(Stat stat) async {
    await prefs.setInt('mystery_gp', stat.gamesPlayed);
    await prefs.setInt('mystery_wins', stat.wins);
    await prefs.setInt('mystery_losses', stat.losses);
  }

  Future<bool> getSolvedMystery() async {
    return await prefs.getBool('solved_mystery') ?? false;
  }

  Future<void> saveSolvedMystery(bool solvedMystery) async {
    await prefs.setBool('solved_mystery', solvedMystery);
  }

  Future<bool> getOnboardingStatus() async {
    return await prefs.getBool('onboarding_done') ?? false;
  }

  Future<void> saveOnboardingStatus(bool onboardingFinished) async {
    await prefs.setBool('onboarding_done', onboardingFinished);
  }

  /// Gets the name of the theme saved in data or defaults
  /// to the Premier League theme
  Future<String> getThemeName() async {
    return await prefs.getString('theme_name') ?? 'Premier League';
  }

  /// Saves the name of the theme in use
  Future<void> saveThemeName(String themeName) async {
    await prefs.setString('theme_name', themeName);
  }

  Future<List<String>> getExcludedTeams() async {
    return await prefs.getStringList('excluded_teams') ?? [];
  }

  Future<void> saveExcludedTeams(List<String> excludedTeams) async {
    await prefs.setStringList('excluded_teams', excludedTeams);
  }

  void clearThemeModelData() async {
    await prefs.remove('theme_name');
  }

  void clearFilterListData() async {
    await prefs.remove('excluded_teams');
  }

  void clearUserModelData() async {
    await prefs.remove('onboarding_done');
    await prefs.remove('solved_mystery');
    resetStats();
  }

  void resetStats() async {
    await prefs.remove('unlimited_gp');
    await prefs.remove('unlimited_wins');
    await prefs.remove('unlimited_losses');
    await prefs.remove('mystery_gp');
    await prefs.remove('mystery_wins');
    await prefs.remove('mystery_losses');
  }

  //TODO: implement handling a game that is in progess when the app closes
}
