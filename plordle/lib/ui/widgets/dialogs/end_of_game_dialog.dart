import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/ui/widgets/mystery_player_timer.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class EndOfGameDialog extends StatelessWidget {
  const EndOfGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserViewModel>(context, listen: false);

    return AlertDialog(
        title: Center(child: _buildDialogTitle(context, model)),
        content: SingleChildScrollView(
          child: (model.currentState == GameState.won)
              ? MysteryPlayerTimer(
                  completedChallenge: model.completedDailyChallenge)
              : ListBody(
                  children: [
                    const Text(Constants.playerHint),
                    const SizedBox(height: 16),
                    Text(model.playerViewModel.currentMysteryPlayer.toString()),
                    const SizedBox(height: 16),
                    MysteryPlayerTimer(
                        completedChallenge: model.completedDailyChallenge)
                  ],
                ),
        ),
        actions: _buildDialogActions(context, model));
  }

  Widget _buildDialogTitle(BuildContext context, UserViewModel model) {
    bool wonGame = model.currentState == GameState.won;
    if (model.inChallengeMode) {
      if (wonGame) {
        return Text("Challenge Complete");
      } else {
        return Text("Challenge Failed");
      }
    } else {
      if (wonGame) {
        return Text(Constants.winnerText);
      } else {
        return Text(Constants.loserText);
      }
    }
  }

  List<Widget> _buildDialogActions(BuildContext context, UserViewModel model) {
    List<Widget> buttons = [];

    buttons.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          model.getNewRandomPlayer();
        },
        child: const Text(Constants.continueNormalModeText)));

    if (!model.completedDailyChallenge) {
      buttons.add(TextButton(
          onPressed: () async {
            Navigator.pop(context);
            model.getNextChallengeModePlayer();
          },
          child: const Text(Constants.tryChallengeModeText)));
    }

    return buttons;
  }
}
