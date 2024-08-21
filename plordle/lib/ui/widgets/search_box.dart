import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/widgets/dialogs/end_of_game_dialog.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);

    return Consumer<UserViewModel>(
      builder: (context, model, child) {
        return TypeAheadField<Player>(
          controller: textFieldController,
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              cursorColor: themeViewModel.primarySelectedThemeColor,
              enabled: (model.currentState == GameState.doneForTheDay)
                  ? false
                  : true,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: themeViewModel.primarySelectedThemeColor),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: themeViewModel.primarySelectedThemeColor)),
                  labelText: _buildTextFieldLabel(model)),
            );
          },
          suggestionsCallback: (userInput) {
            //Don't show suggestions until the user has entered 3 characters
            if (userInput.length < 3) {
              return List.empty();
            } else {
              return model.playerViewModel.buildPlayerSuggestionList(userInput);
            }
          },
          itemBuilder: (context, player) {
            return ListTile(
              title: Text(player.name),
              subtitle: Text(player.getSecondaryPlayerInfo()),
            );
          },
          onSelected: (selectedPlayer) {
            FocusManager.instance.primaryFocus?.unfocus();

            //Clear the textfield after selecting an answer
            textFieldController.clear();

            model.comparePlayers(selectedPlayer);
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

  String _buildTextFieldLabel(UserViewModel model) {
    if (model.currentState == GameState.lost) {
      return "Game Over";
    } else {
      int guesses = model.numberOfGuesses;
      if (guesses < 10) {
        return "Guess ${model.numberOfGuesses} out of ${model.maxNumOfGuesses}";
      } else {
        return "Final Guess";
      }
    }
  }
}
