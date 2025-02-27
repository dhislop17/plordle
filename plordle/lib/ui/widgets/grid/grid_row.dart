import 'package:country_coder/country_coder.dart';
import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/age_square.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/country_square.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/name_square.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/number_square.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/position_square.dart';
import 'package:plordle/ui/widgets/grid/grid_squares/team_square.dart';

class GridRow extends StatelessWidget {
  final Player player;
  final Guess guess;
  final CountryCoder countryCoder;
  const GridRow(
      {super.key,
      required this.player,
      required this.guess,
      required this.countryCoder});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NameSquare(
          player: player,
          guess: guess,
          screenWidth: screenWidth,
        ),
        TeamSquare(player: player, guess: guess, screenWidth: screenWidth),
        PositionSquare(player: player, guess: guess, screenWidth: screenWidth),
        NumberSquare(player: player, guess: guess, screenWidth: screenWidth),
        AgeSquare(player: player, guess: guess, screenWidth: screenWidth),
        CountrySquare(
            player: player,
            guess: guess,
            countryCoder: countryCoder,
            screenWidth: screenWidth)
      ],
    );
  }
}
