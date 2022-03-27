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

  void comparePlayers(String name) {
    Player guessedPlayer =
        _players.firstWhere((element) => element.name == name);
    Guess guess = _createGuess(guessedPlayer);
    _addGuess(guess);
    print(_guesses);
    notifyListeners();
  }

  Guess _createGuess(Player guessedPlayer) {
    return Guess(
        guessName: guessedPlayer.name == _todaysPlayer.name
            ? 'True'
            : guessedPlayer.name,
        sameTeam: guessedPlayer.team == _todaysPlayer.team,
        sameType: guessedPlayer.positionType == _todaysPlayer.positionType,
        samePosition: guessedPlayer.position == _todaysPlayer.position,
        shirtNumberDiff: guessedPlayer.shirtNumber - _todaysPlayer.shirtNumber,
        ageDiff: guessedPlayer.age - _todaysPlayer.age,
        sameCountry: guessedPlayer.country == _todaysPlayer.country);
  }

  void _addGuess(Guess guess) {
    _guesses.add(guess);
  }

  void clearGuesses() {
    _guesses.clear();
    notifyListeners();
  }
}
