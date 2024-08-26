import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/grid/grid_header.dart';
import 'package:plordle/ui/widgets/grid/grid_row.dart';
import 'package:plordle/ui/widgets/dialogs/help_dialog.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return const HelpDialog();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width * .1;
    double paddingHeight = MediaQuery.of(context).size.height * .05;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeViewModel>(context).primarySelectedThemeColor,
        foregroundColor:
            Provider.of<ThemeViewModel>(context).secondarySelectedThemeColor,
        title: const Text(
          TextConstants.gameTitle,
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        actions: [
          //TODO: Make Cancel Button appear conditionally after the first guess
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              //On pressed this should show a confirmation for giving up before
              //showing the game over dialog
            },
          ),
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
              Navigator.pushNamed(context, 'settings');
            },
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: paddingHeight, bottom: paddingHeight),
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
            Divider(
                height: 10,
                thickness: 10,
                color: Provider.of<ThemeViewModel>(context).accentColor),
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
        ),
      ),
    );
  }
}
