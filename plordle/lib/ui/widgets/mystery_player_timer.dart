import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class MysteryPlayerTimer extends StatelessWidget {
  const MysteryPlayerTimer({super.key, required this.completedChallenge});
  final bool completedChallenge;

  @override
  Widget build(BuildContext context) {
    final currDate = DateTime.now();
    final nextTime = DateTime(currDate.year, currDate.month, currDate.day)
        .add(const Duration(days: 1));

    var model = Provider.of<UserViewModel>(context, listen: false);
    var rowChildren = [
      _buildTimerContent(),
      TimerCountdown(
        format: CountDownTimerFormat.hoursMinutesSeconds,
        endTime: nextTime,
        onEnd: () async {
          Navigator.pop(context);
          model.getNextChallengeModePlayer();
        },
        timeTextStyle: const TextStyle(
            color: Themes.premGreen, fontWeight: FontWeight.bold, fontSize: 20),
        spacerWidth: 2,
        enableDescriptions: false,
      )
    ];

    //Return the row as is, if the challenge has been completed for that day
    if (completedChallenge) {
      return Row(children: rowChildren);
    } else {
      //reverse the list so that the text comes after the timer
      return Row(children: rowChildren.reversed.toList());
    }
  }

  Widget _buildTimerContent() {
    Text timerText = (completedChallenge)
        ? Text("New challenge mode player in: ")
        : Text(" remaining to complete today's challenge.");

    return timerText;
  }
}
