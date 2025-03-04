import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class ThemeSelectionDropdown extends StatelessWidget {
  const ThemeSelectionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> teams = Themes.teamThemes.keys.toList();
    return Consumer<ThemeViewModel>(builder: (context, model, child) {
      bool isDarkMode =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      Color divColor = model.accentColor;

      if (isDarkMode && divColor == Colors.black) {
        divColor = model.primarySelectedThemeColor;
      }

      return Column(
        children: [
          DropdownMenu<String>(
              menuHeight: 400,
              label: const Text("Change Theme"),
              initialSelection: model.selectedTheme,
              onSelected: (selectedTheme) =>
                  model.setSelectedTheme(selectedTheme!),
              dropdownMenuEntries:
                  teams.map<DropdownMenuEntry<String>>((String teamName) {
                return DropdownMenuEntry(value: teamName, label: teamName);
              }).toList()),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                height: 10,
                thickness: 10,
                color: divColor,
              ))
        ],
      );
    });
  }
}
