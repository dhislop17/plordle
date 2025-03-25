import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:plordle/view_models/theme_view_model.dart';
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
    var themeModel = Provider.of<ThemeViewModel>(context, listen: false);
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTimerContent(),
        TimerCountdown(
          format: CountDownTimerFormat.hoursMinutesSeconds,
          endTime: nextTime,
          onEnd: () async {
            Navigator.pop(context);
            model.getNextChallengeModePlayer();
          },
          timeTextStyle: TextStyle(
              color: themeModel.getDecorationColor(isDarkMode),
              fontWeight: FontWeight.bold,
              fontSize: 24),
          spacerWidth: 2,
          hoursDescription: "hr",
          minutesDescription: "m",
          secondsDescription: "s",
        ),
      ],
    );
  }

  Widget _buildTimerContent() {
    Text timerText = (completedChallenge)
        ? Text("New daily challenge in:")
        : Text("Time left for today's challenge:");

    return timerText;
  }
}
