import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/mystery_player_timer.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class EndOfGameDialog extends StatelessWidget {
  const EndOfGameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserViewModel>(context, listen: false);

    return AlertDialog(
      title: Center(
          child: (model.currentState == GameState.won)
              ? const Text(TextConstants.winnerText)
              : const Text(TextConstants.loserText)),
      content: SingleChildScrollView(
        child: (model.currentState == GameState.won)
            ? const MysteryPlayerTimer()
            : ListBody(
                children: [
                  const Text(TextConstants.playerHint),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(model.playerViewModel.todaysPlayer.toString()),
                  const SizedBox(
                    height: 20,
                  ),
                  const MysteryPlayerTimer()
                ],
              ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              model.resetToWait();
              //Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (_) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text("Hello")],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: const Text(TextConstants.viewStats)),
        TextButton(
            onPressed: () {
              model.getNewRandomPlayer();
              Navigator.pop(context);
            },
            child: const Text(TextConstants.continueGameText))
      ],
    );
  }
}
