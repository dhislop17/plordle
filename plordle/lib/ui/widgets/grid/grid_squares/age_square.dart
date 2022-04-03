import 'package:flutter/cupertino.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
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
        child: _createAgeContainer(index, model),
      ),
    );
  }

  Container _createAgeContainer(int index, UserViewModel model) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _colorAgeSquare(index, model),
        ),
        child: _ageSquareChild(index, model));
  }

  Widget _ageSquareChild(int index, UserViewModel model) {
    String guessedNumber = model.guessedPlayers[index].age.toString();
    if (model.guesses[index].ageDiff == 0 ||
        model.guesses[index].ageDiff.abs() > 5) {
      return Container(child: Text(guessedNumber));
    } else if (model.guesses[index].ageDiff.abs() <= 5 &&
        model.guesses[index].ageDiff > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(guessedNumber),
          const Text(
            TextConstants.downArrow,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            TextConstants.upArrow,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(guessedNumber),
        ],
      );
    }
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
