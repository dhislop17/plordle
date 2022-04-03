import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';

class TeamSquare extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const TeamSquare({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorTeamSquare(index, model),
            ),
            child: Text(model.guessedPlayers[index].team)),
      ),
    );
  }

  Color? _colorTeamSquare(int index, UserViewModel model) {
    if (model.guesses[index].sameTeam) {
      return Themes.guessGreen;
    } else {
      return Themes.guessGrey;
    }
  }
}
