import 'package:flutter/material.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class ClearSavedDataDialog extends StatelessWidget {
  const ClearSavedDataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete all saved data?"),
      content: const Text(
          "This will reset the currently selected theme, filtered teams, and all game stats. You will be returned to the welcome screen."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              //Push the onboarding screen and clear the navigator stack so there is no back arrow
              Navigator.pushNamedAndRemoveUntil(
                  context, "welcome", (_) => false);

              Provider.of<UserViewModel>(context, listen: false)
                  .deleteSavedUserModelData();
              Provider.of<PlayerViewModel>(context, listen: false)
                  .deleteSavedTeamExclusions();
              Provider.of<ThemeViewModel>(context, listen: false)
                  .clearThemeData();
            },
            child: const Text("Confirm"))
      ],
    );
  }
}
