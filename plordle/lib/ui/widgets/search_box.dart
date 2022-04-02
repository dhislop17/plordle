import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, model, child) {
        return TypeAheadField(
          getImmediateSuggestions: false,
          textFieldConfiguration: TextFieldConfiguration(
            cursorColor: Themes.premGreen,
            enabled:
                (model.currentState == GameState.doneForTheDay) ? false : true,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Themes.premPurple)),
                focusColor: Themes.premPurple,
                labelText: (model.currentState == GameState.doneForTheDay)
                    ? "No Guesses Remaining"
                    : "Guess ${model.numberOfGuesses} out of ${model.maxNumOfGuesses}"),
          ),
          suggestionsCallback: (pattern) {
            return model.playerViewModel.filterPlayerList(pattern);
          },
          itemBuilder: (context, itemData) {
            return ListTile(
              title: Text(itemData.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            FocusManager.instance.primaryFocus?.unfocus();
            //Guess player
            model.comparePlayers(suggestion.toString());
            if (model.currentState == GameState.lost ||
                model.currentState == GameState.won) {
              _showGameEndDialog(context, model);
            }
          },
          minCharsForSuggestions: 3,
          hideOnEmpty: true,
          hideOnError: true,
          keepSuggestionsOnLoading: false,
        );
      },
    );
  }

  Future<void> _showGameEndDialog(
      BuildContext context, UserViewModel model) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (model.currentState == GameState.won) {
            return AlertDialog(
              title: const Text(TextConstants.winnerText),
              content: Container(
                child: const SingleChildScrollView(
                  child: Text("Time remaining is: time_goes_here"),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      model.resetToWait();
                      Navigator.pop(context);
                    },
                    child: const Text(TextConstants.waitForNextGame)),
                TextButton(
                    onPressed: () {
                      model.clearGuesses();
                      Navigator.pop(context);
                    },
                    child: const Text(TextConstants.continueGameText))
              ],
            );
          } else {
            return AlertDialog(
                title: const Text(TextConstants.loserText),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      const Text(TextConstants.playerHint),
                      Text(model.playerViewModel.todaysPlayer.toString()),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Try again in: time_goes_here"),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        model.resetToWait();
                        Navigator.pop(context);
                      },
                      child: const Text(TextConstants.waitForNextGame)),
                  TextButton(
                      onPressed: () {
                        model.clearGuesses();
                        Navigator.pop(context);
                      },
                      child: const Text(TextConstants.continueGameText))
                ]);
          }
        });
  }
}
