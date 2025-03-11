import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';

class PlordleLayoutBuilder extends StatelessWidget {
  final Widget child;
  const PlordleLayoutBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > Constants.bigScreenCutoffWidth) {
        return Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Constants.bigScreenMaxWidth),
            child: child,
          ),
        );
      } else {
        return SafeArea(child: child);
      }
    });
  }
}
