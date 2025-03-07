import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/filter_player_list.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class FilterPlayersPage extends StatelessWidget {
  const FilterPlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeViewModel>(context, listen: false);
    return Consumer<PlayerViewModel>(builder: (context, model, child) {
      return PopScope(
          canPop: model.excludedTeams.length != 20,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                  content: const Text("You must include at least 1 team"),
                  actions: [
                    TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner(),
                        child: const Text("Dismiss"))
                  ]));
            } else {
              //TODO: This may need to work with Game State
              // depending on when the user changes the list there may
              // need to be additional calls to the api to get the correct player
              model.storeTeamExclusions();
            }
          },
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: themeModel.primarySelectedThemeColor,
                foregroundColor: themeModel.secondarySelectedThemeColor,
                title: const Text(Constants.filterPageTitle)),
            body: FilterPlayerList(),
          ));
    });
  }
}
