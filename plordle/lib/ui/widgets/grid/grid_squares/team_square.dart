import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/constants.dart';

class TeamSquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final double screenWidth;
  const TeamSquare(
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
              color: _colorTeamSquare(player, guess),
            ),
            child: (screenWidth > Constants.bigScreenCutoffWidth)
                ? Text(player.team, textAlign: TextAlign.center)
                : Text(player.teamAbbr)),
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
