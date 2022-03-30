import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/services/player_service.dart';
import 'package:plordle/services/service_locator.dart';

class PlayerViewModel extends ChangeNotifier {
  final PlayerService _playerService = serviceLocator<PlayerService>();

  List<Player> _players = [];
  late Player _todaysPlayer;
  final List<Guess> _guesses = [];

  List<Player> get players => _players;
  Player get todaysPlayer => _todaysPlayer;
  List<Guess> get guesses => _guesses;

  PlayerViewModel() {
    _loadData();
  }

  void _loadData() async {
    _players = await _playerService.getPlayers();
    //might need to do something special for todays player to update
    _todaysPlayer = await _playerService.getTodaysPlayer();
    notifyListeners();
  }

  List<String> filterPlayerList(String suggestion) {
    List<String> result = _players.map((player) => player.name).where((val) {
      var stripped = removeDiacritics(val);
      var strippedSug = removeDiacritics(suggestion);
      return stripped.toLowerCase().contains(strippedSug.toLowerCase());
    }).toList();
    return result;
  }
}
