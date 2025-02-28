import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';

class GridHeader extends StatelessWidget {
  const GridHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridNameHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridTeamHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridPositionHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridNumberHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridAgeHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(Constants.gridCountryHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
    ]);
  }
}
