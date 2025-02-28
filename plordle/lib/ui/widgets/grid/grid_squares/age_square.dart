import 'package:flutter/cupertino.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/constants.dart';

class AgeSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final double screenWidth;
  const AgeSquare(
      {super.key,
      required this.player,
      required this.guess,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: (screenWidth > Constants.bigScreenCutoffWidth)
            ? Constants.bigScreenGridAspectRatio
            : Constants.smallScreenGridAspectRatio,
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
    if (guess.ageDiff == 0 ||
        guess.ageDiff.abs() > Constants.ageGuessThreshold) {
      return Text(guessedAge);
    } else if (guess.ageDiff > 0 &&
        guess.ageDiff.abs() <= Constants.ageGuessThreshold) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(guessedAge),
          const Text(
            Constants.downArrow,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            Constants.upArrow,
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
    } else if (guess.ageDiff.abs() <= Constants.ageGuessThreshold) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
