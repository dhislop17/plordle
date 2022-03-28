import 'package:flutter/foundation.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/view_models/player_view_model.dart';

class UserViewModel extends ChangeNotifier {
  final List<Guess> _guesses = [];
  final List<Player> _guessedPlayers = [];
  late PlayerViewModel playerViewModel;

  List<Guess> get guesses => _guesses;
  List<Player> get guessedPlayers => _guessedPlayers;
  //PlayerViewModel get playerViewModel => _playerViewModel;

  /*
  UserViewModel(){
    //call shared prefs service
  }
  */

  UserViewModel update(PlayerViewModel playerViewModel) {
    this.playerViewModel = playerViewModel;
    return this;
  }

  void comparePlayers(String name) {
    Player guessedPlayer =
        playerViewModel.players.firstWhere((element) => element.name == name);
    _guessedPlayers.add(guessedPlayer);
    Guess guess = _createGuess(guessedPlayer);
    _addGuess(guess);
    //notifyListeners();
  }

  Guess _createGuess(Player guessedPlayer) {
    return Guess(
        guessName: guessedPlayer.name == playerViewModel.todaysPlayer.name
            ? 'True'
            : guessedPlayer.name,
        sameTeam: guessedPlayer.team == playerViewModel.todaysPlayer.team,
        sameType: guessedPlayer.positionType ==
            playerViewModel.todaysPlayer.positionType,
        samePosition:
            guessedPlayer.position == playerViewModel.todaysPlayer.position,
        shirtNumberDiff: guessedPlayer.shirtNumber -
            playerViewModel.todaysPlayer.shirtNumber,
        ageDiff: guessedPlayer.age - playerViewModel.todaysPlayer.age,
        sameCountry:
            guessedPlayer.country == playerViewModel.todaysPlayer.country);
  }

  void _addGuess(Guess guess) {
    _guesses.add(guess);
    notifyListeners();
  }

  void clearGuesses() {
    _guesses.clear();
    notifyListeners();
  }
}
