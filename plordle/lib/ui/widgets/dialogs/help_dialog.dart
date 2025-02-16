import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

//TODO: Update dialog to include info about filtering players, themes, etc.
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
              Text(TextConstants.helpDialogTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              Text(
                TextConstants.helpDialogSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 15),
              Text(
                TextConstants.helpDialogInfoText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 15),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: TextConstants.helpDialogGreenText,
                        style: TextStyle(backgroundColor: Themes.guessGreen)),
                    TextSpan(text: TextConstants.helpDialogGreenSub)
                  ])),
              const SizedBox(
                height: 10,
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
                        text: TextConstants.helpDialogShirtText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: TextConstants.helpDialogShirtSubtext)
                  ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: TextConstants.helpDialogNumberText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: TextConstants.helpDialogNumberSubtext)
                  ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: const [
                    TextSpan(
                        text: TextConstants.helpDialogCountryText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: TextConstants.helpDialogCountrySubtext)
                  ])),
              const SizedBox(
                height: 10,
              ),
              Text(
                TextConstants.helpDialogGameInfo,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
