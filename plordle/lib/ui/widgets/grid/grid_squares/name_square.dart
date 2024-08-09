import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';

class NameSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const NameSquare({super.key, required this.player, required this.guess});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
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
