import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';

class CountrySquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const CountrySquare({Key? key, required this.player, required this.guess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorCountrySquare(player, guess),
            ),
            child: Text(player.country,
                maxLines: 1, overflow: TextOverflow.ellipsis)),
      ),
    );
  }

  Color? _colorCountrySquare(Player player, Guess guess) {
    if (guess.sameCountry) {
      return Themes.guessGreen;
    } else {
      return Themes.guessGrey;
    }
  }
}
