import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class ThemeSelectionList extends StatelessWidget {
  const ThemeSelectionList({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> teams = Themes.teamThemes.keys.toList();

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildTeamRow(teams[index]),
        itemCount: Themes.teamThemes.length);
  }

  Widget _buildTeamRow(String teamName) {
    return Consumer<ThemeViewModel>(builder: (context, model, child) {
      return RadioListTile(
        title: Text(teamName),
        value: teamName,
        groupValue: model.selectedTheme,
        onChanged: (selectedTeam) {
          model.setSelectedTheme(selectedTeam!);
        },
        activeColor: model.primarySelectedThemeColor,
        selected: teamName == model.selectedTheme,
      );
    });
  }
}
