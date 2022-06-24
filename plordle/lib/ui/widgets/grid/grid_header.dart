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
          child: const Text(TextConstants.gridNameHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridTeamHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridPositionHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridNumberHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridAgeHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      Container(
          width: 55,
          alignment: Alignment.center,
          child: const Text(TextConstants.gridCountryHeader,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
    ]);
  }
}
