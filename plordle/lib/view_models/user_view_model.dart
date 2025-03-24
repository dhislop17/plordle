import 'package:country_coder/country_coder.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/models/user.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/view_models/player_view_model.dart';

class UserViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();
  final Logger logger = Logger(printer: PrettyPrinter());

  final List<Guess> _guesses = [];
  final List<Player> _guessedPlayers = [];
  late PlayerViewModel playerViewModel;
  late CountryCoder _countryCoder;
  int _numberOfGuesses = 1;
  GameState _currentState = GameState.pregame;
  DifficultyOptions _currentDifficulty = DifficultyOptions.normal;
  bool _inChallengeMode = false;
  late User _user;
  late bool _completedDailyChallenge;
  late bool _onboardingDone;
  //Number of wins per guesses?

  List<Guess> get guesses => _guesses;
  List<Player> get guessedPlayers => _guessedPlayers;
  int get numberOfGuesses => _numberOfGuesses;
  CountryCoder get countryCoder => _countryCoder;
  GameState get currentState => _currentState;
  DifficultyOptions get currentDifficulty => _currentDifficulty;
  User get user => _user;
  bool get completedDailyChallenge => _completedDailyChallenge;
  bool get onboardingDone => _onboardingDone;
  bool get inChallengeMode => _inChallengeMode;

  UserViewModel() {
    _loadSavedData();
  }

  UserViewModel update(PlayerViewModel playerViewModel) {
    this.playerViewModel = playerViewModel;
    return this;
  }

  void _loadSavedData() async {
    _onboardingDone = await _storageService.getOnboardingStatus();
    _user = await _storageService.getUser();
    _completedDailyChallenge = _user.lastAttemptedChallengeDate
        .isAtSameMomentAs(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    var difficulty = await _storageService.getDifficulty();
    _currentDifficulty = DifficultyOptions.values.byName(difficulty);
    logger.d(
        "Loaded difficulty was $difficulty, set diff to $_currentDifficulty");
    _countryCoder = CountryCoder.instance
        .load(await compute(CountryCoder.prepareData, null));

    logger.d("Onboarding complete: $_onboardingDone");
    logger.d("Attempted Daily Challenge: $_completedDailyChallenge");
    notifyListeners();
  }

  void changeDifficulty(DifficultyOptions newDifficultyOption) {
    _currentDifficulty = newDifficultyOption;
    notifyListeners();
  }

  void saveDifficulty() async {
    logger.d("Saving diff as ${_currentDifficulty.name}");
    await _storageService.saveDifficulty(_currentDifficulty.name);
  }

  void getNewRandomPlayer() {
    _guesses.clear();
    _guessedPlayers.clear();
    _numberOfGuesses = 1;
    _inChallengeMode = false;
    _currentState = GameState.pregame;
    playerViewModel.getNextRandomPlayer(isChallengeMode: _inChallengeMode);
    notifyListeners();
  }

  void getNextChallengeModePlayer() async {
    _guesses.clear();
    _guessedPlayers.clear();
    _inChallengeMode = true;
    _completedDailyChallenge = false;
    _numberOfGuesses = 1;
    _currentState = GameState.pregame;
    playerViewModel.getNextRandomPlayer(isChallengeMode: _inChallengeMode);
    notifyListeners();
  }

  /// Used for saving game stats and mystery status
  void saveGameStatData() async {
    await _storageService.saveUser(_user);
  }

  void deleteSavedUserModelData() async {
    _storageService.clearUserModelData();
    _user.resetUser();
    _completedDailyChallenge = false;
    _onboardingDone = false;
    _currentDifficulty = DifficultyOptions.easy;
    getNewRandomPlayer();
  }

  void resetGameStats() async {
    _storageService.resetStats();
    _user.resetStats();
    notifyListeners();
  }

  void completeOnboarding() async {
    _onboardingDone = true;
    _storageService.saveOnboardingStatus(_onboardingDone);
    logger.d("Onboarding Complete");
    notifyListeners();
  }

  void comparePlayers(Player guessedPlayer) {
    // Flip the game state after the first guess
    if (_numberOfGuesses == 1) {
      _currentState = GameState.inGame;
    }
    _guessedPlayers.add(guessedPlayer);
    Guess guess = _createGuess(guessedPlayer);
    _numberOfGuesses++;

    if (_numberOfGuesses <= Constants.maxNumOfGuesses + 1 &&
        guess.guessName == "Matched") {
      _currentState = GameState.won;
      _completeGame();
    } else if (_numberOfGuesses == Constants.maxNumOfGuesses + 1 &&
        guess.guessName != "Matched") {
      _currentState = GameState.lost;
      _completeGame();
    }
    _addGuess(guess);
  }

  void abandonGame() {
    _currentState = GameState.lost;
    _completeGame();
  }

  void _completeGame() async {
    bool wonGame = _currentState == GameState.won;
    if (_inChallengeMode) {
      _user.playedChallengeModeGame(wonGame);
      _completedDailyChallenge = true;
    } else {
      _user.playedNormalModeGame(wonGame);
    }
    saveGameStatData();
  }

  Guess _createGuess(Player guessedPlayer) {
    return Guess(
        guessName:
            guessedPlayer.name == playerViewModel.currentMysteryPlayer.name
                ? "Matched"
                : guessedPlayer.name,
        sameTeam:
            guessedPlayer.team == playerViewModel.currentMysteryPlayer.team,
        sameType: guessedPlayer.positionType ==
            playerViewModel.currentMysteryPlayer.positionType,
        // samePosition: guessedPlayer.position ==
        //     playerViewModel.currentMysteryPlayer.position,
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
