import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/dialogs/end_of_game_dialog.dart';
import 'package:plordle/ui/widgets/grid/grid_header.dart';
import 'package:plordle/ui/widgets/grid/grid_row.dart';
import 'package:plordle/ui/widgets/dialogs/help_dialog.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    /* var model = Provider.of<UserViewModel>(context, listen: false);
    model.getSavedGameStatuses().then((value) {
      print(model.onboardingDone);
    }); */
    super.initState();
    /* var model = Provider.of<UserViewModel>(context, listen: false);
    model.loadSavedData();
    if (!model.onboardingDone) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context,
            builder: (context) {
              return const HelpDialog();
            }).then((value) => model.completeOnboarding());
      });
    } */
  }

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width * .1;
    double paddingHeight = MediaQuery.of(context).size.height * .05;
    //final model = context.watch<UserViewModel>();
    var model = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Themes.premPurple,
          title: const Text(
            TextConstants.gameTitle,
            style: TextStyle(fontSize: 32),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.help,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const HelpDialog();
                      });
                }),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                var model = Provider.of<UserViewModel>(context, listen: false);
                model.clearStats();
              },
            )
          ],
        ),
        body: /* Consumer<UserViewModel>(
          builder: (context, model, child) {
            return  */
            FutureBuilder(
          future: model.getDialogStatuses(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !model.onboardingDone) {
              /* print("we just go here for some reason");
              return MainBody(
                  paddingHeight: paddingHeight, paddingWidth: paddingWidth);
            } else  {*/
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                print("building");
                showDialog(
                    context: context,
                    builder: (context) {
                      return const HelpDialog();
                    }).then((value) => model.completeOnboarding());
              });
              //return Container();
              //return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData &&
                model.solvedMystery &&
                !model.isUnlimitedMode) {
              print("here");
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const EndOfGameDialog();
                    });
              });
            }
            return MainBody(
                paddingHeight: paddingHeight, paddingWidth: paddingWidth);
          },
          //);
          //},
        ));
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.paddingHeight,
    required this.paddingWidth,
  }) : super(key: key);

  final double paddingHeight;
  final double paddingWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: paddingHeight, bottom: paddingHeight),
            child: const Text(
              TextConstants.gameSubtitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
            child: const SearchBox(),
          ),
          Padding(
            padding: EdgeInsets.only(top: paddingHeight),
            child: const GridHeader(),
          ),
          const Divider(
            height: 10,
            thickness: 10,
            color: Themes.premPurple,
          ),
          Expanded(
            child: Consumer<UserViewModel>(
              builder: (context, model, child) {
                ScrollController _scrollController = ScrollController();
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: model.guesses.length,
                    itemBuilder: (context, index) {
                      return GridRow(
                        player: model.guessedPlayers[index],
                        guess: model.guesses[index],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
