import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';

class CountrySquare extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const CountrySquare({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: model.guesses[index].sameCountry
                  ? Themes.guessGreen
                  : Themes.guessGrey,
            ),
            child: Text(model.guessedPlayers[index].country,
                maxLines: 1, overflow: TextOverflow.ellipsis)),
      ),
    );
  }
}
