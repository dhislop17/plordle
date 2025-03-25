import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/filter_chips_widget.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class IntroFilterColumn extends StatelessWidget {
  const IntroFilterColumn({super.key, required this.isOnDesktop});

  final bool isOnDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(Constants.filterHelpTextFirstLine,
              style: TextStyle(fontSize: 16))),
      SizedBox(height: 8),
      Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Text(Constants.filterHelpTextSecondLine,
              style: TextStyle(fontSize: 16))),
      SizedBox(height: 8),
      Expanded(
        child: ListView(
          children: [FilterChipsWidget()],
        ),
      ),
      _buildBottomButtons(context)
    ]);
  }

  Widget _buildBottomButtons(BuildContext context) {
    var userModel = Provider.of<UserViewModel>(context, listen: false);
    var buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            child: OutlinedButton.icon(
                icon: Icon(Icons.restart_alt_outlined),
                onPressed: () {
                  Provider.of<PlayerViewModel>(context, listen: false)
                      .clearTeamExclusions();
                },
                label: const Text(Constants.resetFilterButtonLabel))),
        SizedBox(
            child: FilledButton(
                onPressed: () {
                  //save theme selection, team exclusions, difficulty level, and mark onboarding complete
                  Provider.of<ThemeViewModel>(context, listen: false)
                      .saveData();
                  Provider.of<PlayerViewModel>(context, listen: false)
                      .storeTeamExclusions();
                  userModel.saveDifficulty();
                  userModel.completeOnboarding();

                  Navigator.pushReplacementNamed(context, 'game');
                },
                child: const Text(Constants.startButtonLabel)))
      ],
    );

    if (isOnDesktop) {
      return Column(
        children: [buttonRow, SizedBox(height: 40)],
      );
    } else {
      return Column(
        children: [buttonRow, SizedBox(height: 28)],
      );
    }
  }
}
