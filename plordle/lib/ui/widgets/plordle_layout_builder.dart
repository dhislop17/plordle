import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';

class PlordleLayoutBuilder extends StatelessWidget {
  final Widget childWidget;
  const PlordleLayoutBuilder({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > Constants.bigScreenCutoffWidth) {
        return Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Constants.bigScreenMaxWidth),
            child: childWidget,
          ),
        );
      } else {
        return SafeArea(child: childWidget);
      }
    });
  }
}
