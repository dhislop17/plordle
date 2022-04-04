import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/grid/grid_header.dart';
import 'package:plordle/ui/widgets/grid/grid_row.dart';
import 'package:plordle/ui/widgets/dialogs/help_dialog.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width * .1;
    double paddingHeight = MediaQuery.of(context).size.height * .05;

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
      ),
    );
  }
}
