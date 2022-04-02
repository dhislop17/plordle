import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
import 'package:plordle/ui/widgets/grid_header.dart';
import 'package:plordle/ui/widgets/grid_row.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  //TODO: Refactor this page for win and lose states
  // Could use a method wrapped in a listener?

  @override
  Widget build(BuildContext context) {
    double paddingWidth = MediaQuery.of(context).size.width * .1;
    double paddingHeight = MediaQuery.of(context).size.height * .05;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerViewModel>(
            create: (context) => PlayerViewModel()),
        ChangeNotifierProxyProvider<PlayerViewModel, UserViewModel>(
            create: (_) => UserViewModel(),
            update: (_, player, user) => user!.update(player))
      ],
      child: Scaffold(
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
                  //Bring up help widget
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Dialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("How To Play",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28)),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Guess the player in 10 tries",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "The column color after each guess will inidicate how close the guess was to the correct answer",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: const [
                                      Text("Green in any column",
                                          style: TextStyle(
                                              backgroundColor:
                                                  Themes.guessGreen,
                                              fontSize: 16)),
                                      //Text("means a successful match")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
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
                padding:
                    EdgeInsets.only(left: paddingWidth, right: paddingWidth),
                child: const SearchBox(),
              ),
              Padding(
                padding: EdgeInsets.only(top: paddingHeight),
                child: GridHeader(),
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
                    return Scrollbar(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: model.guesses.length,
                          itemBuilder: (context, index) {
                            return GridRow(
                              index: index,
                              model: model,
                            );
                          }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
