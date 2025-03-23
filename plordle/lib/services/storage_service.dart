import 'package:plordle/models/stat.dart';
import 'package:plordle/models/user.dart';
import 'package:plordle/ui/utils/storage_service_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferencesAsync prefs;

  StorageService() {
    prefs = SharedPreferencesAsync();
  }

  //UserViewModel Saved Data
  Future<User> getUser() async {
    Stat normalModeStat = await _getNormalModeStat();
    Stat challengeModeStat = await _getChallengeModeStat();
    DateTime lastSolvedDate = await _getLastSolvedDate() ?? DateTime(2016);

    return User(
        normalModeStat: normalModeStat,
        challengeModeStat: challengeModeStat,
        lastAttemptedChallengeDate: lastSolvedDate);
  }

  Future<void> saveUser(User user) async {
    await saveNormalModeStat(user.normalModeStat);
    await saveMysteryModeStat(user.challengeModeStat);
    await _saveLastSolvedDate(user.lastAttemptedChallengeDate);
  }

  Future<Stat> _getNormalModeStat() async {
    int gamesPlayed =
        await prefs.getInt(StorageServiceKeys.normalModeGamesPlayed) ?? 0;
    int wins = await prefs.getInt(StorageServiceKeys.normalModeWins) ?? 0;
    int losses = await prefs.getInt(StorageServiceKeys.normalModeLosses) ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveNormalModeStat(Stat stat) async {
    await prefs.setInt(
        StorageServiceKeys.normalModeGamesPlayed, stat.gamesPlayed);
    await prefs.setInt(StorageServiceKeys.normalModeWins, stat.wins);
    await prefs.setInt(StorageServiceKeys.normalModeLosses, stat.losses);
  }

  Future<Stat> _getChallengeModeStat() async {
    int gamesPlayed =
        await prefs.getInt(StorageServiceKeys.challengeModeGamesPlayed) ?? 0;
    int wins = await prefs.getInt(StorageServiceKeys.challengeModeWins) ?? 0;
    int losses =
        await prefs.getInt(StorageServiceKeys.challengeModeLosses) ?? 0;

    return Stat(gamesPlayed: gamesPlayed, wins: wins, losses: losses);
  }

  Future<void> saveMysteryModeStat(Stat stat) async {
    await prefs.setInt(
        StorageServiceKeys.challengeModeGamesPlayed, stat.gamesPlayed);
    await prefs.setInt(StorageServiceKeys.challengeModeWins, stat.wins);
    await prefs.setInt(StorageServiceKeys.challengeModeLosses, stat.losses);
  }

  Future<bool> getOnboardingStatus() async {
    return await prefs.getBool(StorageServiceKeys.onboardingDone) ?? false;
  }

  Future<void> saveOnboardingStatus(bool onboardingFinished) async {
    await prefs.setBool(StorageServiceKeys.onboardingDone, onboardingFinished);
  }

  Future<String> getDifficulty() async {
    return await prefs.getString(StorageServiceKeys.difficulty) ?? 'easy';
  }

  Future<void> saveDifficulty(String difficulty) async {
    await prefs.setString(StorageServiceKeys.difficulty, difficulty);
  }

  Future<DateTime?> _getLastSolvedDate() async {
    String lastDate =
        await prefs.getString(StorageServiceKeys.lastSolvedDate) ?? 'none';
    return DateTime.tryParse(lastDate);
  }

  Future<void> _saveLastSolvedDate(DateTime date) async {
    await prefs.setString(StorageServiceKeys.lastSolvedDate, date.toString());
  }

  //ThemeViewModel Saved Data

  /// Gets the name of the theme saved in data or defaults
  /// to the Premier League theme
  Future<String> getThemeName() async {
    return await prefs.getString(StorageServiceKeys.themeName) ??
        'Premier League';
  }

  /// Saves the name of the theme in use
  Future<void> saveThemeName(String themeName) async {
    await prefs.setString(StorageServiceKeys.themeName, themeName);
  }

  //PlayerViewModel Saved Data
  Future<List<String>> getExcludedTeams() async {
    return await prefs.getStringList(StorageServiceKeys.excludedTeams) ?? [];
  }

  Future<void> saveExcludedTeams(List<String> excludedTeams) async {
    await prefs.setStringList(StorageServiceKeys.excludedTeams, excludedTeams);
  }

  //Saved Data Clear Functions

  void clearThemeModelData() async {
    await prefs.remove(StorageServiceKeys.themeName);
  }

  void clearFilterListData() async {
    await prefs.remove(StorageServiceKeys.excludedTeams);
  }

  void clearUserModelData() async {
    await prefs.remove(StorageServiceKeys.onboardingDone);
    await prefs.remove(StorageServiceKeys.difficulty);
    await prefs.remove(StorageServiceKeys.lastSolvedDate);
    resetStats();
  }

  void resetStats() async {
    await prefs.remove(StorageServiceKeys.normalModeGamesPlayed);
    await prefs.remove(StorageServiceKeys.normalModeWins);
    await prefs.remove(StorageServiceKeys.normalModeLosses);
    await prefs.remove(StorageServiceKeys.challengeModeGamesPlayed);
    await prefs.remove(StorageServiceKeys.challengeModeWins);
    await prefs.remove(StorageServiceKeys.challengeModeLosses);
  }

  //TODO: implement handling a game that is in progess when the app closes
}
