import 'package:flutter/cupertino.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';

class AgeSquare extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const AgeSquare({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorAgeSquare(index, model),
            ),
            child: Text(model.guessedPlayers[index].age.toString())),
      ),
    );
  }

  Color _colorAgeSquare(int index, UserViewModel model) {
    if (model.guesses[index].ageDiff == 0) {
      return Themes.guessGreen;
    } else if (model.guesses[index].ageDiff.abs() <= 5) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
