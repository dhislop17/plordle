import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/view_models/user_view_model.dart';

class EndOfGameDialog extends StatelessWidget {
  final UserViewModel model;

  const EndOfGameDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.currentState == GameState.won) {
      return AlertDialog(
        title: const Text(TextConstants.winnerText),
        content: Container(
          child: const SingleChildScrollView(
            child: Text("Time remaining is: time_goes_here"),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                model.resetToWait();
                Navigator.pop(context);
              },
              child: const Text(TextConstants.waitForNextGame)),
          TextButton(
              onPressed: () {
                model.clearGuesses();
                Navigator.pop(context);
              },
              child: const Text(TextConstants.continueGameText))
        ],
      );
    } else {
      return AlertDialog(
          title: const Text(TextConstants.loserText),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text(TextConstants.playerHint),
                Text(model.playerViewModel.todaysPlayer.toString()),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Try again in: time_goes_here"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  model.resetToWait();
                  Navigator.pop(context);
                },
                child: const Text(TextConstants.waitForNextGame)),
            TextButton(
                onPressed: () {
                  model.clearGuesses();
                  Navigator.pop(context);
                },
                child: const Text(TextConstants.continueGameText))
          ]);
    }
  }
}
