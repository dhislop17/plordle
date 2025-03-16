import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';

class IntroTextColumn extends StatelessWidget {
  const IntroTextColumn({super.key, required this.isOnDesktop});

  final bool isOnDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child: Text(Constants.gameTitle,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
      SizedBox(height: 40),
      Text("A guessing game about Premier League Players"),
      SizedBox(height: 220),
      Text("Before we get started, let's customize some game settings"),
      SizedBox(height: 20),
      _buildSwipeOrClickHint()
    ]);
  }

  Widget _buildSwipeOrClickHint() {
    final hintText = (isOnDesktop)
        ? "Click the arrow to continue"
        : "Swipe right to continue";

    return Text(hintText);
  }
}
