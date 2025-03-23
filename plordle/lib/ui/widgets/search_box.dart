import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/ui/widgets/dialogs/end_of_game_dialog.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color boxColor = themeViewModel.getSearchBoxColor(isDarkMode);

    return Consumer<UserViewModel>(
      builder: (context, model, child) {
        return TypeAheadField<Player>(
          controller: textFieldController,
          builder: (context, controller, focusNode) {
            //TODO: Remove this selection area once TextFields have been fixed on Firefox/Safari
            return SelectionArea(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                cursorColor: boxColor,
                enabled:
                    (model.currentState == GameState.postgame) ? false : true,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: boxColor),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: boxColor),
                    ),
                    labelText: _buildTextFieldLabel(model)),
              ),
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
                subtitle: (model.currentDifficulty != DifficultyOptions.expert)
                    ? Text(
                        player.getPlayerAdditionalInfo(model.currentDifficulty))
                    : null);
          },
          onSelected: (selectedPlayer) {
            //Clear the textfield after selecting an answer
            setState(() {
              textFieldController.clear();
            });

            FocusManager.instance.primaryFocus?.unfocus();

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
        return "Guess ${model.numberOfGuesses} out of ${Constants.maxNumOfGuesses}";
      } else {
        return "Final Guess";
      }
    }
  }
}
