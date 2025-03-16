import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/filter_chips_widget.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class IntroFilterColumn extends StatelessWidget {
  const IntroFilterColumn(
      {super.key,
      required this.isOnDesktop,
      required this.completeWelcomeFlow});

  final bool isOnDesktop;
  final void Function(UserViewModel) completeWelcomeFlow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          Constants.filterHelpTextFirstLine,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(Constants.filterHelpTextSecondLine,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        FilterChipsWidget(),
        _buildBottomButtons(context)
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    ButtonStyle resetButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: Colors.red, foregroundColor: Colors.white);
    var userModel = Provider.of<UserViewModel>(context, listen: false);

    Widget resetButton = SizedBox(
        child: ElevatedButton(
            style: resetButtonStyle,
            onPressed: () {
              Provider.of<PlayerViewModel>(context, listen: false)
                  .clearTeamExclusions();
            },
            child: const Text("Reset Filter")));

    if (isOnDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          resetButton,
          SizedBox(
              child: FilledButton(
                  onPressed: () {
                    completeWelcomeFlow(userModel);
                  },
                  child: const Text(Constants.startButtonLabel)))
        ],
      );
    } else {
      return resetButton;
    }
  }
}
