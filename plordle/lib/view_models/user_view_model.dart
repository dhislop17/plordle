import 'package:country_coder/country_coder.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/models/stat.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';
import 'package:plordle/view_models/player_view_model.dart';

enum GameState { inProgress, won, lost, doneForTheDay }

enum DifficultyOptions {
  easy("Relegation Battle"),
  normal("Mid Table Club"),
  hard("Top 4 Challenger"),
  extraHard("Title Challenger"),
  challenge("PL Champion"),
  expert("Invincibles");

  const DifficultyOptions(this.label);
  final String label;
}

class UserViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();
  final Logger logger = Logger(printer: PrettyPrinter());

  final List<Guess> _guesses = [];
  final List<Player> _guessedPlayers = [];
  late PlayerViewModel playerViewModel;
  late CountryCoder _countryCoder;
  int _numberOfGuesses = 1;
  final int _maxNumOfGuesses = 10;
  GameState _currentState = GameState.inProgress;
  DifficultyOptions _currentDifficulty = DifficultyOptions.normal;
  bool _inUnlimitedMode = false;
  late Stat _mysteryModeStat;
  late Stat _unlimitedModeStat;
  late bool _solvedMystery;
  late bool _onboardingDone;
  //Number of wins per guesses?

  List<Guess> get guesses => _guesses;
  List<Player> get guessedPlayers => _guessedPlayers;
  int get numberOfGuesses => _numberOfGuesses;
  int get maxNumOfGuesses => _maxNumOfGuesses;
  CountryCoder get countryCoder => _countryCoder;
  GameState get currentState => _currentState;
  DifficultyOptions get currentDifficulty => _currentDifficulty;
  bool get isUnlimitedMode => _inUnlimitedMode;
  bool get solvedMystery => _solvedMystery;
  bool get onboardingDone => _onboardingDone;
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
    _onboardingDone = await _storageService.getOnboardingStatus();
    _mysteryModeStat = await _storageService.getMysteryModeStat();
    _unlimitedModeStat = await _storageService.getUnlimitedModeStat();
    _solvedMystery = await _storageService.getSolvedMystery();
    var difficulty = await _storageService.getDifficulty();
    _currentDifficulty = DifficultyOptions.values.byName(difficulty);
    logger.i("Loaded Diff was $difficulty, set diff to $_currentDifficulty");
    _countryCoder = CountryCoder.instance
        .load(await compute(CountryCoder.prepareData, null));

    logger.i("Mystery Mode Stat: $_mysteryModeStat");
    logger.i("Unlimited Mode Stat: $_unlimitedModeStat");
    logger.i("Onboarding complete: $_onboardingDone");
    logger.i("Solved Today's Mystery Player: $_solvedMystery");
    notifyListeners();
  }

  void changeDifficulty(DifficultyOptions newDifficultyOption) {
    _currentDifficulty = newDifficultyOption;
    notifyListeners();
  }

  void saveDifficulty() async {
    logger.i("Saving diff as ${_currentDifficulty.name}");
    await _storageService.saveDifficulty(_currentDifficulty.name);
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

  void getNewMysteryPlayer() async {
    _guesses.clear();
    _guessedPlayers.clear();
    _inUnlimitedMode = false;
    _numberOfGuesses = 1;
    _currentState = GameState.inProgress;
    playerViewModel.getNewMysteryPlayer();
    notifyListeners();
  }

  // TODO: Look into this for refactoring and renaming
  /// Used for saving game stats and mystery status
  void saveGameStatData() async {
    await _storageService.saveMysteryModeStat(_mysteryModeStat);
    await _storageService.saveUnlimitedModeStat(_unlimitedModeStat);
    await _storageService.saveSolvedMystery(_solvedMystery);
  }

  void resetToWait() {
    _inUnlimitedMode = false;
    _currentState = GameState.doneForTheDay;
    notifyListeners();
  }

  void deleteSavedUserModelData() async {
    _storageService.clearUserModelData();
    _unlimitedModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
    _mysteryModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
    notifyListeners();
  }

  void resetGameStats() async {
    _storageService.resetStats();
    _unlimitedModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
    _mysteryModeStat = Stat(gamesPlayed: 0, wins: 0, losses: 0);
    notifyListeners();
  }

  void completeOnboarding() async {
    _onboardingDone = true;
    _storageService.saveOnboardingStatus(_onboardingDone);
    logger.i("Onboarding Complete");
    notifyListeners();
  }

  void comparePlayers(Player guessedPlayer) {
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
      _unlimitedModeStat.gamesPlayed++;
    } else {
      if (_currentState == GameState.won) {
        _mysteryModeStat.wins++;
      } else {
        _mysteryModeStat.losses++;
      }
      _mysteryModeStat.gamesPlayed++;
      _solvedMystery = true;
    }
    saveGameStatData();
  }

  Guess _createGuess(Player guessedPlayer) {
    return Guess(
        guessName:
            guessedPlayer.name == playerViewModel.currentMysteryPlayer.name
                ? 'True'
                : guessedPlayer.name,
        sameTeam:
            guessedPlayer.team == playerViewModel.currentMysteryPlayer.team,
        sameType: guessedPlayer.positionType ==
            playerViewModel.currentMysteryPlayer.positionType,
        samePosition: guessedPlayer.position ==
            playerViewModel.currentMysteryPlayer.position,
        shirtNumberDiff: guessedPlayer.shirtNumber -
            playerViewModel.currentMysteryPlayer.shirtNumber,
        ageDiff: guessedPlayer.age - playerViewModel.currentMysteryPlayer.age,
        sameCountry: guessedPlayer.country ==
            playerViewModel.currentMysteryPlayer.country,
        sameContinent: guessedPlayer.continent ==
            playerViewModel.currentMysteryPlayer.continent);
  }

  void _addGuess(Guess guess) {
    _guesses.add(guess);
    notifyListeners();
  }
}
