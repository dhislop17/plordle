import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/services/player_service.dart';
import 'package:plordle/services/service_locator.dart';

class PlayerViewModel extends ChangeNotifier {
  final PlayerService _playerService = serviceLocator<PlayerService>();

  List<Player> _players = [];
  late Player _todaysPlayer;

  List<Player> get players => _players;
  Player get todaysPlayer => _todaysPlayer;

  PlayerViewModel() {
    _loadData();
  }

  void _loadData() async {
    _players = await _playerService.getPlayers();
    //might need to do something special for todays player to update
    _todaysPlayer = await _playerService.getTodaysPlayer();
    notifyListeners();
  }

  void getNextRandom() async {
    _todaysPlayer = await _playerService.getRandomPlayer();
  }

  void getNewMysteryPlayer() async {
    _todaysPlayer = await _playerService.getTodaysPlayer();
    notifyListeners();
  }

  //Build a list of players to suggest to the user for guesses
  //based on what they have typed so far
  List<Player> buildPlayerSuggestionList(String userInput) {
    List<Player> players = _players.map((player) => player).where((player) {
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
