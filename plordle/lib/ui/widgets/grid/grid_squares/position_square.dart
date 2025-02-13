import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';

class PositionSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const PositionSquare({super.key, required this.player, required this.guess});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorPositionSquare(player, guess),
            ),
            child: Text(player.position)),
      ),
    );
  }

  Color _colorPositionSquare(Player player, Guess guess) {
    if (guess.sameType) {
      return Themes.guessGreen;
      // } else if (guess.sameType) {
      //   return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }
}
