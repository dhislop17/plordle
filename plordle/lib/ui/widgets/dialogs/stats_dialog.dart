import 'package:flutter/material.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class StatsDialog extends StatelessWidget {
  const StatsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserViewModel>(context, listen: false);

    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Game Stats",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20),
            const Text("Normal Mode Stats:"),
            Text(model.user.normalModeStatString),
            const SizedBox(height: 20),
            const Text("Challenge Mode Stats:"),
            Text(model.user.challengeModeStatString),
          ],
        ),
      ),
    );
  }
}
