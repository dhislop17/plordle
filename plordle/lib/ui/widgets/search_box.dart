import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plordle/ui/app_theme.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the model but dont listen for changes
    var model = Provider.of<PlayerViewModel>(context);
    return TypeAheadField(
      textFieldConfiguration: const TextFieldConfiguration(
        cursorColor: Themes.premPurple,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusColor: Themes.premPurple,
            labelText: "Guess a player"),
      ),
      suggestionsCallback: (pattern) async {
        return model.filterPlayerList(pattern);
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {
        //Guess player
        model.comparePlayers(suggestion.toString());
      },
      minCharsForSuggestions: 3,
      hideOnEmpty: true,
      hideOnError: true,
    );
  }
}
