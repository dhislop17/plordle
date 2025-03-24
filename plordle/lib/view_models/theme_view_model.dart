import 'package:flutter/material.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/services/storage_service.dart';
import 'package:plordle/ui/utils/app_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  String _selectedTheme = "";
  late Color _primarySelectedThemeColor = Themes.premPurple;
  late Color _secondarySelectedThemeColor = Themes.premGreen;
  late Color _accentColor = Colors.black;

  String get selectedTheme => _selectedTheme;
  Color get primarySelectedThemeColor => _primarySelectedThemeColor;
  Color get secondarySelectedThemeColor => _secondarySelectedThemeColor;
  Color get accentColor => _accentColor;

  ThemeViewModel() {
    _loadData();
  }

  void _loadData() async {
    _selectedTheme = await _storageService.getThemeName();
    setSelectedTheme(_selectedTheme);
  }

  void saveData() async {
    await _storageService.saveThemeName(_selectedTheme);
  }

  void setSelectedTheme(String themeName) {
    var teamColors = Themes.teamThemes[themeName]!;
    _selectedTheme = themeName;
    _primarySelectedThemeColor = teamColors[0];
    _secondarySelectedThemeColor = teamColors[1];

    //Team has an accent color so use it
    if (teamColors.length == 3) {
      _accentColor = teamColors[2];
    } //Case where team only has two colors and its white --> use the main color again
    else if (teamColors.length == 2 &&
        _secondarySelectedThemeColor == Colors.white) {
      _accentColor = _primarySelectedThemeColor;
    } //Team only has two colors but there is enough contrast
    else {
      _accentColor = _secondarySelectedThemeColor;
    }

    notifyListeners();
  }

  Color getDivColor(bool isDarkMode) {
    if (isDarkMode && accentColor == Colors.black) {
      return primarySelectedThemeColor;
    } else {
      return accentColor;
    }
  }

  Color getDecorationColor(bool isDarkMode) {
    //Avoid too dark primary color in dark mode or too light primary color in light mode
    if ((isDarkMode &&
            Themes.primaryColorDarkModeClashThemes.contains(_selectedTheme)) ||
        (!isDarkMode &&
            Themes.primaryColorLightModeClashThemes.contains(_selectedTheme))) {
      return _secondarySelectedThemeColor;
    } else {
      return _primarySelectedThemeColor;
    }
  }

  void clearThemeData() async {
    _storageService.clearThemeModelData();
    //Reset theme to default
    setSelectedTheme('Premier League');
    notifyListeners();
  }
}
