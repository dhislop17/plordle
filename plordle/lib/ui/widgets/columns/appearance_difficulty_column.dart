import 'package:flutter/material.dart';
import 'package:plordle/ui/widgets/change_difficulty_widget.dart';
import 'package:plordle/ui/widgets/theme_selection_dropdown.dart';

class AppearanceDifficultyColumn extends StatelessWidget {
  const AppearanceDifficultyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(padding: EdgeInsets.only(bottom: 20)),
        ThemeSelectionDropdown(),
        ChangeDifficultyWidget()
      ],
    );
  }
}
