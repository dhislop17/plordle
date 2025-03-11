import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';

class FilterChipsWidget extends StatelessWidget {
  FilterChipsWidget({super.key});

  final List<String> teams = Constants.teamsList;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(builder: (context, model, child) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 4,
            runSpacing: 8,
            children: teams.map((String teamName) {
              return FilterChip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(teamName),
                  selected: !model.excludedTeams.contains(teamName),
                  onSelected: (bool selected) {
                    if (!selected && model.excludedTeams.length == 19) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("You must include at least 1 team")));
                    } else {
                      model.updateTeamExclusions(teamName);
                    }
                  });
            }).toList(),
          ),
          const SizedBox(height: 80)
        ],
      ));
    });
  }
}
