import 'package:flutter/material.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class ChangeDifficultyWidget extends StatelessWidget {
  const ChangeDifficultyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, model, child) {
      Player demoPlayer = const Player(
          age: 26,
          //playerId: 1,
          name: "Example Player",
          continent: "North America",
          country: "Canada",
          countryCode: "CAN",
          position: "Left Winger", //This isn't displayed
          positionType: "Midfielder",
          shirtNumber: 17,
          team: "Manchester United",
          teamAbbr: "MUN");

      return SafeArea(
          child: Column(children: [
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        DropdownMenu<DifficultyOptions>(
            label: const Text("Difficulty"),
            initialSelection: model.currentDifficulty,
            onSelected: (newOption) => model.changeDifficulty(newOption!),
            dropdownMenuEntries: DifficultyOptions.values
                .map<DropdownMenuEntry<DifficultyOptions>>(
                    (DifficultyOptions option) {
              return DropdownMenuEntry(value: option, label: option.label);
            }).toList()),
        const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
        const Text("Preview",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Card(
          child: ListTile(
              title: Text(demoPlayer.name),
              subtitle: (model.currentDifficulty != DifficultyOptions.expert)
                  ? Text(demoPlayer
                      .getPlayerAdditionalInfo(model.currentDifficulty))
                  : null),
        )
      ]));
    });
  }
}
