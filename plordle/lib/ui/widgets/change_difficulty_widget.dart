import 'package:flutter/material.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/enums.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class ChangeDifficultyWidget extends StatelessWidget {
  const ChangeDifficultyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.sizeOf(context).width * .1;
    Player demoPlayer = const Player(
        age: 26,
        //playerId: 1,
        name: "Example Player",
        continent: "North America",
        country: "Canada",
        countryCode: "CAN",
        shortPositionType: "Left Winger", //This isn't displayed
        positionType: "Midfielder",
        shirtNumber: 17,
        team: "Manchester United",
        teamAbbr: "MUN");

    return Consumer<UserViewModel>(builder: (context, model, child) {
      return Column(children: [
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
        const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  "Changing the difficulty level adjusts the additional details shown for the suggested players that match your current guess."),
            )),
        const Text("Preview",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Padding(
          padding: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
          child: Card(
            child: ListTile(
                title: Text(demoPlayer.name),
                subtitle: (model.currentDifficulty != DifficultyOptions.expert)
                    ? Text(demoPlayer
                        .getPlayerAdditionalInfo(model.currentDifficulty))
                    : null),
          ),
        ),
      ]);
    });
  }
}
