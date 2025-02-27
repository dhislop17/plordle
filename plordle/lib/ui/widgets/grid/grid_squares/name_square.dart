import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class NameSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final double screenWidth;
  const NameSquare(
      {super.key,
      required this.player,
      required this.guess,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: (screenWidth > TextConstants.bigScreenCutoffWidth)
            ? TextConstants.bigScreenGridAspectRatio
            : TextConstants.smallScreenGridAspectRatio,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorNameSquare(player, guess),
            ),
            child: Text(
              player.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }

  Color? _colorNameSquare(Player player, Guess guess) {
    if (guess.guessName == 'True') {
      return Themes.guessGreen;
    } else {
      return null;
    }
  }
}
