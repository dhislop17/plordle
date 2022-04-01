import 'package:flutter/foundation.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/view_models/player_view_model.dart';

enum GameState { inProgress, won, lost, doneForTheDay }

class UserViewModel extends ChangeNotifier {
  final List<Guess> _guesses = [];
  final List<Player> _guessedPlayers = [];
  late PlayerViewModel playerViewModel;
  int _numberOfGuesses = 1;
  int _maxNumOfGuesses = 10;
  GameState _currentState = GameState.inProgress;
  bool _inUnlimitedMode = false;
  //Number of wins per guesses?

  List<Guess> get guesses => _guesses;
  List<Player> get guessedPlayers => _guessedPlayers;
  int get numberOfGuesses => _numberOfGuesses;
  int get maxNumOfGuesses => _maxNumOfGuesses;
  GameState get currentState => _currentState;
  bool get isUnlimitedMode => _inUnlimitedMode;

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
    _numberOfGuesses++;
    if (_numberOfGuesses <= _maxNumOfGuesses + 1 && guess.guessName == 'True') {
      _currentState = GameState.won;
      //notifyListeners();
    } else if (_numberOfGuesses == _maxNumOfGuesses + 1 &&
        guess.guessName != 'True') {
      _currentState = GameState.lost;
      //notifyListeners();
    }
    _addGuess(guess);

    //Do state checking here

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
    _guessedPlayers.clear();
    _numberOfGuesses = 1;
    // Should this be done here
    _currentState = GameState.inProgress;
    playerViewModel.getNextRandom();
    notifyListeners();
  }

  void resetToWait() {
    _currentState = GameState.doneForTheDay;
    notifyListeners();
  }
}
