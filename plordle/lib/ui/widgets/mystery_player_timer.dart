import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class MysteryPlayerTimer extends StatelessWidget {
  const MysteryPlayerTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final currDate = DateTime.now();
    final nextTime = DateTime(currDate.year, currDate.month, currDate.day)
        .add(const Duration(days: 1));

    var model = Provider.of<UserViewModel>(context, listen: false);
    return Row(
      children: [
        const Text("New mystery player in: "),
        TimerCountdown(
          format: CountDownTimerFormat.hoursMinutesSeconds,
          endTime: nextTime,
          onEnd: () async {
            model.getNewMysteryPlayer();
            Navigator.pop(context);
          },
          timeTextStyle: const TextStyle(
              color: Themes.premGreen,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          spacerWidth: 2,
          enableDescriptions: false,
        )
      ],
    );
  }
}
