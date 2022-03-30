import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the model but dont listen for changes
    var uModel = Provider.of<UserViewModel>(context);
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        cursorColor: Themes.premGreen,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Themes.premPurple)),
            focusColor: Themes.premPurple,
            labelText:
                "Guess ${uModel.numberOfGuesses} out of ${uModel.maxNumOfGuesses}"),
      ),
      suggestionsCallback: (pattern) {
        return uModel.playerViewModel.filterPlayerList(pattern);
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        //Guess player
        uModel.comparePlayers(suggestion.toString());
        if (uModel.currentState == GameState.lost ||
            uModel.currentState == GameState.won) {
          _showGameEndDialog(context, uModel);
        }
      },
      minCharsForSuggestions: 3,
      hideOnEmpty: true,
      hideOnError: true,
    );
  }

  Future<void> _showGameEndDialog(
      BuildContext context, UserViewModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          if (model.currentState == GameState.won) {
            return AlertDialog(
              title: const Text("YOU WIN"),
              content: Container(
                child: const SingleChildScrollView(
                  child: Text("Time remaining is: time_goes_here"),
                ),
              ),
              actions: [
                TextButton(onPressed: () {}, child: const Text("Wait")),
                TextButton(
                    onPressed: () {},
                    child: const Text("Switch to unlimited mode"))
              ],
            );
          } else {
            return AlertDialog(
                title: const Text("YOU LOST"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text("The correct player was:"),
                      Text(model.playerViewModel.todaysPlayer.name +
                          " for " +
                          model.playerViewModel.todaysPlayer.team),
                      Text("Time remaining is: time_goes_here"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () {}, child: const Text("Wait")),
                  TextButton(
                      onPressed: () {},
                      child: const Text("Switch to unlimited mode"))
                ]);
          }
        });
  }
}
