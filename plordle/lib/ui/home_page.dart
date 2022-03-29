import 'package:flutter/material.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';
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
                })
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .1,
                    bottom: MediaQuery.of(context).size.width * .1),
                child: const Text(
                  TextConstants.gameSubtitle,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .1,
                    right: MediaQuery.of(context).size.width * .1),
                child: const SearchBox(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .1),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridNameHeader)),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridTeamHeader)),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridPositionHeader)),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridNumberHeader)),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridAgeHeader)),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: const Text(TextConstants.gridCountryHeader)),
                    ]),
              ),
              const Divider(
                height: 10,
                thickness: 10,
                color: Themes.premPurple,
              ),
              Expanded(
                child: Consumer<UserViewModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                        itemCount: model.guesses.length,
                        itemBuilder: (context, index) {
                          return GridRow(
                            index: index,
                            model: model,
                          );
                        });
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
