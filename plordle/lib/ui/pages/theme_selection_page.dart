import 'package:flutter/material.dart';
import 'package:plordle/ui/widgets/theme_selection_list.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Provider.of<ThemeViewModel>(context, listen: false).saveData();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Provider.of<ThemeViewModel>(context).primarySelectedThemeColor,
          foregroundColor:
              Provider.of<ThemeViewModel>(context).secondarySelectedThemeColor,
          title: const Text(
            "Select a Theme",
            style: TextStyle(fontSize: 32),
          ),
          centerTitle: false,
        ),
        body: const ThemeSelectionList(),
      ),
    );
  }
}
