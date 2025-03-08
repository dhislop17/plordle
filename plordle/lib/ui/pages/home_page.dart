import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/dialogs/help_dialog.dart';
import 'package:plordle/ui/widgets/columns/main_game_column.dart';
import 'package:plordle/ui/widgets/plordle_layout_builder.dart';
import 'package:plordle/ui/widgets/settings_anchor_menu.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return const HelpDialog();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color divColor = themeViewModel.accentColor;

    if (isDarkMode && divColor == Colors.black) {
      divColor = themeViewModel.primarySelectedThemeColor;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeViewModel.primarySelectedThemeColor,
        foregroundColor: themeViewModel.secondarySelectedThemeColor,
        title: const Text(
          Constants.gameTitle,
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        actions: [
          //TODO: Make Cancel Button appear conditionally after the first guess
          // IconButton(
          //   icon: const Icon(Icons.flag_rounded),
          //   onPressed: () {
          //     //On pressed this should show a confirmation for giving up before
          //     //showing the game over dialog
          //   },
          // ),
          IconButton(
              icon: const Icon(
                Icons.help,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const HelpDialog();
                    });
              }),
          const SettingsAnchorMenu()
        ],
      ),
      body: PlordleLayoutBuilder(child: MainGameColumn(divColor: divColor)),
    );
  }
}
