import 'package:flutter/foundation.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/view_models/player_view_model.dart';

class UserModel extends ChangeNotifier {
  final List<Guess> _guesses = [];
  final PlayerViewModel _playerViewModel;

  List<Guess> get guesses => _guesses;
  PlayerViewModel get playerViewModel => _playerViewModel;

  UserModel(this._playerViewModel);
}
