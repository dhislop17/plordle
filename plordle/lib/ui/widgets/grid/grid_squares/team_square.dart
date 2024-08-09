import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';

class TeamSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  const TeamSquare({super.key, required this.player, required this.guess});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorTeamSquare(player, guess),
            ),
            child: Text(player.team)),
      ),
    );
  }

  Color? _colorTeamSquare(Player player, Guess guess) {
    if (guess.sameTeam) {
      return Themes.guessGreen;
    } else {
      return Themes.guessGrey;
    }
  }
}
