import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/columns/appearance_difficulty_column.dart';
import 'package:plordle/ui/widgets/plordle_layout_builder.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class AppearanceDifficultyPage extends StatelessWidget {
  const AppearanceDifficultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            Provider.of<UserViewModel>(context, listen: false).saveDifficulty();
            Provider.of<ThemeViewModel>(context, listen: false).saveData();
          }
        },
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Provider.of<ThemeViewModel>(context)
                  .primarySelectedThemeColor,
              foregroundColor: Provider.of<ThemeViewModel>(context)
                  .secondarySelectedThemeColor,
              title: const Text(Constants.appAndDiffPageTitle)),
          body: const PlordleLayoutBuilder(child: AppearanceDifficultyColumn()),
        ));
  }
}
