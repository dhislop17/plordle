import 'package:flutter/cupertino.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class AgeSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const AgeSquare({super.key, required this.player, required this.guess});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: _createAgeContainer(player, guess),
      ),
    );
  }

  Container _createAgeContainer(Player player, Guess guess) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _colorAgeSquare(player, guess),
        ),
        child: _ageSquareChild(player, guess));
  }

  Widget _ageSquareChild(Player player, Guess guess) {
    String guessedAge = player.age.toString();
    if (guess.ageDiff == 0 || guess.ageDiff.abs() > 5) {
      return Text(guessedAge);
    } else if (guess.ageDiff.abs() <= 5 && guess.ageDiff > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(guessedAge),
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
          Text(guessedAge),
        ],
      );
    }
  }

  Color _colorAgeSquare(Player player, Guess guess) {
    if (guess.ageDiff == 0) {
      return Themes.guessGreen;
    } else if (guess.ageDiff.abs() <= 5) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
