import 'package:flutter/material.dart';
import 'package:plordle/ui/widgets/grid_squares/age_square.dart';
import 'package:plordle/ui/widgets/grid_squares/country_square.dart';
import 'package:plordle/ui/widgets/grid_squares/name_square.dart';
import 'package:plordle/ui/widgets/grid_squares/number_square.dart';
import 'package:plordle/ui/widgets/grid_squares/position_square.dart';
import 'package:plordle/ui/widgets/grid_squares/team_square.dart';
import 'package:plordle/view_models/user_view_model.dart';

class GridRow extends StatelessWidget {
  final int index;
  final UserViewModel model;
  const GridRow({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NameSquare(index: index, model: model),
        TeamSquare(index: index, model: model),
        PositionSquare(index: index, model: model),
        NumberSquare(index: index, model: model),
        AgeSquare(index: index, model: model),
        CountrySquare(index: index, model: model),
      ],
    );
  }
}
