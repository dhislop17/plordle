import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class GridHeader extends StatelessWidget {
  const GridHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridNameHeader)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridTeamHeader)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridPositionHeader)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridNumberHeader)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridAgeHeader)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridCountryHeader)),
    ]);
  }
}
