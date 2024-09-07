import 'package:flutter/material.dart';
import 'package:plordle/ui/widgets/change_difficulty_widget.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class ChangeDifficultyPage extends StatelessWidget {
  const ChangeDifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserViewModel>(context, listen: false);
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            userModel.saveDifficulty();
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Change Difficulty")),
          body: const ChangeDifficultyWidget(),
        ));
  }
}