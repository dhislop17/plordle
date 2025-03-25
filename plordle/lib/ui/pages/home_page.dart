import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/ui/widgets/dialogs/end_of_game_dialog.dart';
import 'package:plordle/ui/widgets/dialogs/help_dialog.dart';
import 'package:plordle/ui/widgets/columns/main_game_column.dart';
import 'package:plordle/ui/widgets/plordle_layout_builder.dart';
import 'package:plordle/ui/widgets/settings_anchor_menu.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
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
    Color divColor = themeViewModel.getDivColor(isDarkMode);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeViewModel.primarySelectedThemeColor,
        foregroundColor: themeViewModel.secondarySelectedThemeColor,
        title: const Text(
          Constants.gameTitle,
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          Consumer<UserViewModel>(
            builder: (context, model, child) {
              if (model.currentState == GameState.inGame) {
                return IconButton(
                  icon: const Icon(Icons.flag_rounded),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Center(
                            child: Text("Give Up?"),
                          ),
                          content: Text(
                              "Giving up will end the current game and count as a loss in your game stats."),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  model.abandonGame();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return EndOfGameDialog();
                                    },
                                  );
                                },
                                child: Text("Confirm"))
                          ],
                        );
                      },
                    );
                  },
                );
              } else if (!model.completedDailyChallenge &&
                  model.currentState == GameState.pregame) {
                return IconButton(
                    onPressed: () {
                      model.swapModes();
                    },
                    icon: Icon(Icons.swap_horizontal_circle_rounded));
              } else {
                return SizedBox.shrink();
              }
            },
          ),
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
