import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';

class PositionSquare extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const PositionSquare({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorPositionSquare(index, model),
            ),
            child: Text(model.guessedPlayers[index].position)),
      ),
    );
  }

  Color _colorPositionSquare(int index, UserViewModel model) {
    if (model.guesses[index].sameType && model.guesses[index].samePosition) {
      return Themes.guessGreen;
    } else if (model.numberOfGuesses == model.maxNumOfGuesses + 1) {
      return Themes.guessRed;
    } else if (model.guesses[index].sameType) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
