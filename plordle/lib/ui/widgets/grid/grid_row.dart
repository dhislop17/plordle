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
  const GridRow({Key? key, required this.player, required this.guess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NameSquare(player: player, guess: guess),
        TeamSquare(player: player, guess: guess),
        PositionSquare(player: player, guess: guess),
        NumberSquare(player: player, guess: guess),
        AgeSquare(player: player, guess: guess),
        CountrySquare(player: player, guess: guess),
      ],
    );
  }
}
