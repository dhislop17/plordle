import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class PositionSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final double screenWidth;
  const PositionSquare(
      {super.key,
      required this.player,
      required this.guess,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Expanded(
      child: AspectRatio(
        aspectRatio: (screenWidth > TextConstants.bigScreenCutoffWidth)
            ? TextConstants.bigScreenGridAspectRatio
            : TextConstants.smallScreenGridAspectRatio,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorPositionSquare(player, guess),
            ),
            child: (screenWidth > TextConstants.bigScreenCutoffWidth)
                ? Text(player.positionType)
                : Text(player.shortPositionType)),
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
