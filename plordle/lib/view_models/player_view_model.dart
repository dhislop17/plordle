import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/services/player_file_service.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';

class PlayerViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();
  final PlayerFileService _playerFileService =
      serviceLocator<PlayerFileService>();
  final Logger logger = Logger(printer: PrettyPrinter());

  final Set<String> _excludedTeams = {};
  List<Player> _players = [];
  List<Player> _normalModePlayset = [];
  late Player _currentMysteryPlayer;

  List<Player> get players => _players;
  Player get currentMysteryPlayer => _currentMysteryPlayer;
  Set<String> get excludedTeams => _excludedTeams;

  PlayerViewModel() {
    _loadData();
  }

  void _loadData() async {
    logger.d("Player View Model loaded data");
    _players = await _playerFileService.loadSeasonList();

    _excludedTeams.addAll(await _storageService.getExcludedTeams());
    _buildNormalModePlayset();

    //TODO: Consider if additional work is necessary for todays player to update across days
    getNextRandomPlayer(isChallengeMode: false);
    notifyListeners();
  }

  void _buildNormalModePlayset() {
    _normalModePlayset = _players
        .where((player) => !_excludedTeams.contains(player.team))
        .toList();
    logger.d("Current playset now has ${_normalModePlayset.length} players");
    notifyListeners();
  }

  void getNextRandomPlayer({required bool isChallengeMode}) {
    Random rng;
    List<Player> playset;

    if (isChallengeMode) {
      var date = DateTime.now();
      var dateSeed = date.year * 1000 + date.month * 100 + date.day;
      rng = Random(dateSeed);
      playset = _players;
      logger.d("Retrieving challenge mode player");
    } else {
      rng = Random();
      playset = _normalModePlayset;
      logger.d("Retrieving normal mode player");
    }
    var nextRandomIdx = rng.nextInt(playset.length);
    _currentMysteryPlayer = playset[nextRandomIdx];
    logger.d("Player from file is ${playset[nextRandomIdx]}");
    notifyListeners();
  }

  /// Update the team exclusions list with a single team.
  /// Used by every team row in the filter player list widget
  void updateTeamExclusions(String teamName) {
    if (_excludedTeams.contains(teamName)) {
      logger.d("Removing $teamName from the exclusions list");
      _excludedTeams.remove(teamName);
    } else {
      logger.d("Adding $teamName to the exclusions list");
      _excludedTeams.add(teamName);
    }
    notifyListeners();
  }

  /// Clears the list of excluded teams used by the Player View Model
  void clearTeamExclusions() {
    _excludedTeams.clear();
    notifyListeners();
  }

  /// Add all teams to the exclusion list.
  /// Used by the All teams multi-select row in the filter player list widget.
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
    _buildNormalModePlayset();
  }

  /// Deletes the locally stored list of team exclusions from shared preferences
  void deleteSavedTeamExclusions() {
    _storageService.clearFilterListData();
    clearTeamExclusions();
  }

  ///Build a list of players to suggest to the user for guesses
  /// based on what they have typed so far
  List<Player> buildPlayerSuggestionList(String userInput) {
    List<Player> filteredPlayers = _normalModePlayset.where((player) {
      //remove diacritical marks from the user input and
      //player names to simplify filtering and searching for players
      var strippedInput = removeDiacritics(userInput);
      var strippedPlayerName = removeDiacritics(player.name);
      return strippedPlayerName
          .toLowerCase()
          .contains(strippedInput.toLowerCase());
    }).toList();
    return filteredPlayers;
  }
}
