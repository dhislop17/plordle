import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({
    Key? key,
  }) : super(key: key);

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
              const Text(TextConstants.helpDialogTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              const SizedBox(height: 20),
              const Text(
                TextConstants.helpDialogSubtitle,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              const Text(
                TextConstants.helpDialogInfoText,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                    TextSpan(
                        text: TextConstants.helpDialogGreenText,
                        style: TextStyle(backgroundColor: Themes.guessGreen)),
                    TextSpan(text: TextConstants.helpDialogGreenSub)
                  ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                    TextSpan(
                        text: TextConstants.helpDialogPositionText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: TextConstants.helpDialogPositionSubtext)
                  ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                    TextSpan(
                        text: TextConstants.helpDialogNumberText,
                        style: TextStyle(backgroundColor: Themes.guessYellow)),
                    TextSpan(text: TextConstants.helpDialogNumberSubtext)
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
