import 'package:flutter/foundation.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/models/stat.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';
import 'package:plordle/view_models/player_view_model.dart';

enum GameState { inProgress, won, lost, doneForTheDay }

class UserViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  final List<Guess> _guesses = [];
  final List<Player> _guessedPlayers = [];
  late PlayerViewModel playerViewModel;
  int _numberOfGuesses = 1;
  final int _maxNumOfGuesses = 10;
  GameState _currentState = GameState.inProgress;
  bool _inUnlimitedMode = false;
  late Stat _mysteryModeStat;
  late Stat _unlimitedModeStat;
  late bool _solvedMystery;
  //Number of wins per guesses?

  List<Guess> get guesses => _guesses;
  List<Player> get guessedPlayers => _guessedPlayers;
  int get numberOfGuesses => _numberOfGuesses;
  int get maxNumOfGuesses => _maxNumOfGuesses;
  GameState get currentState => _currentState;
  bool get isUnlimitedMode => _inUnlimitedMode;
  bool get solvedMystery => _solvedMystery;
  Stat get mysteryModeStat => _mysteryModeStat;
  Stat get unlimitedModeStat => _unlimitedModeStat;

  UserViewModel() {
    _loadSavedData();
  }

  UserViewModel update(PlayerViewModel playerViewModel) {
    this.playerViewModel = playerViewModel;
    return this;
  }

  void _loadSavedData() async {
    _mysteryModeStat = await _storageService.getMysteryModeStat();
    _unlimitedModeStat = await _storageService.getUnlimitedModeStat();
    _solvedMystery = await _storageService.getSolvedMystery();

    print(_mysteryModeStat.toString() + " MYSTERY");
    print(_unlimitedModeStat.toString() + " UNLIMITED");
    print(_solvedMystery);
    notifyListeners();
  }

  void getNewRandomPlayer() {
    _guesses.clear();
    _guessedPlayers.clear();
    _numberOfGuesses = 1;
    _inUnlimitedMode = true;
    _currentState = GameState.inProgress;
    playerViewModel.getNextRandom();
    notifyListeners();
  }

  void saveData() async {
    _storageService.saveMysteryModeStat(_mysteryModeStat);
    _storageService.saveUnlimitedModeStat(_unlimitedModeStat);
    _storageService.saveSolvedMystery(_solvedMystery);
  }

  void getNewMysteryPlayer() async {
    _guesses.clear();
    _guessedPlayers.clear();
    _inUnlimitedMode = false;
    _numberOfGuesses = 1;
    _currentState = GameState.inProgress;
    playerViewModel.getNewMysteryPlayer();
    notifyListeners();
  }

  void resetToWait() {
    _inUnlimitedMode = false;
    _currentState = GameState.doneForTheDay;
    notifyListeners();
  }

  void clearStats() async {
    _storageService.clearSavedData();
    _unlimitedModeStat = Stat(wins: 0, losses: 0);
    _mysteryModeStat = Stat(wins: 0, losses: 0);
    notifyListeners();
  }

  void comparePlayers(String name) {
    Player guessedPlayer =
        playerViewModel.players.firstWhere((element) => element.name == name);
    _guessedPlayers.add(guessedPlayer);
    Guess guess = _createGuess(guessedPlayer);
    _numberOfGuesses++;
    if (_numberOfGuesses <= _maxNumOfGuesses + 1 && guess.guessName == 'True') {
      _currentState = GameState.won;
      _completeGame();
    } else if (_numberOfGuesses == _maxNumOfGuesses + 1 &&
        guess.guessName != 'True') {
      _currentState = GameState.lost;
      _completeGame();
    }
    _addGuess(guess);
  }

  void _completeGame() async {
    if (_inUnlimitedMode) {
      if (_currentState == GameState.won) {
        _unlimitedModeStat.wins++;
      } else {
        _unlimitedModeStat.losses++;
      }
    } else {
      if (_currentState == GameState.won) {
        _mysteryModeStat.wins++;
      } else {
        _mysteryModeStat.losses++;
      }
      _solvedMystery = true;
    }
    saveData();
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
}
