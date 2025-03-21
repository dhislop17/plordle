import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/constants.dart';

class NumberSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final double screenWidth;
  const NumberSquare(
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
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorNumberSquare(player, guess),
            ),
            child: _createNumberContainer(player, guess)),
      ),
    );
  }

  Container _createNumberContainer(Player player, Guess guess) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _colorNumberSquare(player, guess),
        ),
        child: _numberSquareChild(player, guess));
  }

  Widget _numberSquareChild(Player player, Guess guess) {
    String guessedNumber = player.shirtNumber.toString();
    if (guess.shirtNumberDiff == 0 ||
        guess.shirtNumberDiff.abs() > Constants.numberGuessThreshold) {
      return Text(guessedNumber);
    } else if (guess.shirtNumberDiff > 0 &&
        guess.shirtNumberDiff.abs() <= Constants.numberGuessThreshold) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(guessedNumber),
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
          Text(guessedNumber),
        ],
      );
    }
  }

  Color _colorNumberSquare(Player player, Guess guess) {
    if (guess.shirtNumberDiff == 0) {
      return Themes.guessGreen;
    } else if (guess.shirtNumberDiff.abs() <= Constants.numberGuessThreshold) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
