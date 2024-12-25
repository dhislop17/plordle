import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/services/player_service.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';

class PlayerViewModel extends ChangeNotifier {
  final PlayerService _playerService = serviceLocator<PlayerService>();
  final StorageService _storageService = serviceLocator<StorageService>();
  final Logger logger = Logger(printer: PrettyPrinter());

  final Set<String> _excludedTeams = {};
  List<Player> _players = [];
  late Player _currentMysteryPlayer;

  List<Player> get players => _players;
  Player get currentMysteryPlayer => _currentMysteryPlayer;
  Set<String> get excludedTeams => _excludedTeams;

  PlayerViewModel() {
    _loadData();
  }

  void _loadData() async {
    _players = await _playerService.getPlayers();
    _excludedTeams.addAll(await _storageService.getExcludedTeams());
    //TODO: Consider if additional work is necessary for todays player to update across days
    _currentMysteryPlayer =
        await _playerService.getTodaysPlayer(_excludedTeams);
    logger.i("Today's Player Loaded");
    logger.i("Loaded ${_players.length} players");
    notifyListeners();
  }

  void getNextRandom() async {
    _currentMysteryPlayer =
        await _playerService.getRandomPlayer(_excludedTeams);
    logger.i("Loaded New Random Player");
  }

  void getNewMysteryPlayer() async {
    _currentMysteryPlayer =
        await _playerService.getTodaysPlayer(_excludedTeams);
    logger.i("Loaded New Mystery Player");
    notifyListeners();
  }

  void updateTeamExclusions(String teamName) {
    if (_excludedTeams.contains(teamName)) {
      _excludedTeams.remove(teamName);
    } else {
      _excludedTeams.add(teamName);
    }
    notifyListeners();
  }

  /// Clears the list of excluded teams used by the Player View Model
  void clearTeamExclusions() {
    _excludedTeams.clear();
    notifyListeners();
  }

  void includeManyTeams(List<String> teams) {
    _excludedTeams.addAll(teams);
    notifyListeners();
  }

  void getStoredTeamExclusions() async {
    List<String> exclusions = await _storageService.getExcludedTeams();
    _excludedTeams.addAll(exclusions);
  }

  void storeTeamExclusions() {
    _storageService.saveExcludedTeams(_excludedTeams.toList());
  }

  /// Deletes the locally stored list of team exclusions from shared preferences
  void deleteSavedTeamExclusions() {
    _storageService.clearFilterListData();
    clearTeamExclusions();
  }

  //Build a list of players to suggest to the user for guesses
  //based on what they have typed so far
  List<Player> buildPlayerSuggestionList(String userInput) {
    List<Player> players = _players
        .where((player) => !_excludedTeams
            .contains(player.team)) //filter out players from excluded teams
        .where((player) {
      //remove diacritical marks from the user input and
      //player names to simplify filtering and searching for players
      var strippedInput = removeDiacritics(userInput);
      var strippedPlayerName = removeDiacritics(player.name);
      return strippedPlayerName
          .toLowerCase()
          .contains(strippedInput.toLowerCase());
    }).toList();
    return players;
  }
}
