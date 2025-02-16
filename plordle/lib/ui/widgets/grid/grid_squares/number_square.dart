import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class NumberSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const NumberSquare({super.key, required this.player, required this.guess});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
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
    if (guess.shirtNumberDiff == 0 || guess.shirtNumberDiff.abs() > 10) {
      return Text(guessedNumber);
    } else if (guess.shirtNumberDiff.abs() <= 10 && guess.shirtNumberDiff > 0) {
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

  Color _colorNumberSquare(Player player, Guess guess) {
    if (guess.shirtNumberDiff == 0) {
      return Themes.guessGreen;
    } else if (guess.shirtNumberDiff.abs() <= 10) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
