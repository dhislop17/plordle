import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/constants.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Constants.helpDialogTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              Text(
                Constants.helpDialogSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                Constants.helpDialogInfoText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: Constants.helpDialogGreenText,
                        style: TextStyle(backgroundColor: Themes.guessGreen)),
                    TextSpan(text: Constants.helpDialogGreenSub)
                  ])),
              const SizedBox(
                height: 8,
              ),
              // Old section text for specific positions
              // RichText(
              //     text: TextSpan(
              //         style: Theme.of(context).textTheme.bodyMedium,
              //         children: const [
              //       TextSpan(
              //           text: TextConstants.helpDialogPositionText,
              //           style: TextStyle(backgroundColor: Themes.guessYellow)),
              //       TextSpan(text: TextConstants.helpDialogPositionSubtext)
              //     ])),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: Constants.helpDialogShirtText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: Constants.helpDialogShirtSubtext)
                  ])),
              const SizedBox(
                height: 8,
              ),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: Constants.helpDialogNumberText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: Constants.helpDialogNumberSubtext)
                  ])),
              const SizedBox(
                height: 8,
              ),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: Constants.helpDialogCountryText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: Constants.helpDialogCountrySubtext)
                  ])),
              const SizedBox(
                height: 8,
              ),
              Text(
                Constants.helpDialogGameInfo,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Constants.modeSwitchText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
