import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/widgets/dialogs/end_of_game_dialog.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, model, child) {
        return TypeAheadField(
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              cursorColor: Themes.premGreen,
              enabled: (model.currentState == GameState.doneForTheDay)
                  ? false
                  : true,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Themes.premPurple)),
                  focusColor: Themes.premPurple,
                  labelText: (model.currentState == GameState.doneForTheDay)
                      ? "Game Over"
                      : "Guess ${model.numberOfGuesses} out of ${model.maxNumOfGuesses}"),
            );
          },
          suggestionsCallback: (pattern) {
            if (pattern.length < 3) {
              return List.empty();
            } else {
              return model.playerViewModel.filterPlayerList(pattern);
            }
          },
          itemBuilder: (context, itemData) {
            return ListTile(
              title: Text(itemData.toString()),
            );
          },
          onSelected: (suggestion) {
            FocusManager.instance.primaryFocus?.unfocus();
            //Guess player
            model.comparePlayers(suggestion.toString());
            if (model.currentState == GameState.lost ||
                model.currentState == GameState.won) {
              _showGameEndDialog(context);
            }
          },
          hideOnEmpty: true,
          hideOnError: true,
          retainOnLoading: false,
        );
      },
    );
  }

  Future<void> _showGameEndDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const EndOfGameDialog();
        });
  }
}
