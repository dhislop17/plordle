import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/constants.dart';
import 'package:plordle/ui/widgets/grid/grid_header.dart';
import 'package:plordle/ui/widgets/grid/grid_row.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class MainGameColumn extends StatelessWidget {
  const MainGameColumn({
    super.key,
    required this.divColor,
  });

  final Color divColor;

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.sizeOf(context).width * .1;
    double paddingHeight = MediaQuery.sizeOf(context).height * .05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: paddingHeight, bottom: paddingHeight),
          child: Consumer<UserViewModel>(
            builder: (context, model, child) {
              return Text(
                (model.inChallengeMode)
                    ? Constants.challengeModeSubtitle
                    : Constants.normalModeSubtitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        Consumer<UserViewModel>(
          builder: (context, model, child) {
            if (model.inChallengeMode) {
              return Text("One try per day and the filter is disabled");
            } else {
              return Text("Unlimited tries per day with the filter enabled");
            }
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 4, left: paddingWidth, right: paddingWidth),
          child: const SearchBox(),
        ),
        Padding(
          padding: EdgeInsets.only(top: paddingHeight),
          child: const GridHeader(),
        ),
        Divider(height: 10, thickness: 10, color: divColor),
        Expanded(
          child: Consumer<UserViewModel>(
            builder: (context, model, child) {
              ScrollController scrollController = ScrollController();
              SchedulerBinding.instance.addPostFrameCallback((_) {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return ListView.builder(
                  controller: scrollController,
                  itemCount: model.guesses.length,
                  itemBuilder: (context, index) {
                    return GridRow(
                      player: model.guessedPlayers[index],
                      guess: model.guesses[index],
                      countryCoder: model.countryCoder,
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
