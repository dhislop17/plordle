import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';

class NumberSquare extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const NumberSquare({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorNumberSquare(index, model),
            ),
            child: Text(model.guessedPlayers[index].shirtNumber.toString())),
      ),
    );
  }

  Color _colorNumberSquare(int index, UserViewModel model) {
    if (model.guesses[index].shirtNumberDiff == 0) {
      return Themes.guessGreen;
    } else if (model.guesses[index].shirtNumberDiff.abs() <= 5) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
