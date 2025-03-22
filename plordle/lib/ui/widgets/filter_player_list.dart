import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';

class FilterPlayerList extends StatelessWidget {
  final List<String> teams = Constants.teamsList;

  FilterPlayerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [_buildSelectAllRow(), ...teams.map(_buildFilterListRow)],
    );
  }

  Widget _buildSelectAllRow() {
    bool selected = true;
    return Consumer<PlayerViewModel>(
      builder: (context, model, child) {
        return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.platform,
            title: const Text("All Teams"),
            value: model.excludedTeams.isEmpty && selected,
            onChanged: (status) {
              if (model.excludedTeams.isEmpty) {
                model.includeManyTeams(teams);
              } else {
                model.clearTeamExclusions();
              }
            });
      },
    );
  }

  Widget _buildFilterListRow(String teamName) {
    return Consumer<PlayerViewModel>(
      builder: (context, model, child) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.platform,
          title: Text(teamName),
          value: !model.excludedTeams.contains(teamName),
          onChanged: (status) {
            model.updateTeamExclusions(teamName);
          },
        );
      },
    );
  }
}
