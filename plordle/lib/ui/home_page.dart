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

  @override
  Widget build(BuildContext context) {
    const data = [
      Text("Alex Oxlade-Chamberlain",
          maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("AM"),
      Text("15"),
      Text("30"),
      Text("England", maxLines: 2),
      Text("Donny van de Beek", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("EVE"),
      Text("CM"),
      Text("30"),
      Text("24"),
      Text("Netherlands", maxLines: 2),
      Text("Jonny Evans", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LEI"),
      Text("CB"),
      Text("6"),
      Text("34"),
      Text("Northern Ireland", maxLines: 2),
      Text("Trent Alexander-Arnold",
          maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("RB"),
      Text("66"),
      Text("21"),
      Text("England", maxLines: 2),
      Text("Andrew Robertson", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("LIV"),
      Text("LB"),
      Text("27"),
      Text("30"),
      Text("Scotland", maxLines: 2),
      Text("Timo Werner", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("CHE"),
      Text("AM"),
      Text("11"),
      Text("25"),
      Text("Germany", maxLines: 2),
      Text("Heung-Min Son", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("TOT"),
      Text("LW"),
      Text("7"),
      Text("29"),
      Text("Korea, South", maxLines: 2),
      Text("Asmir Begovic", maxLines: 2, overflow: TextOverflow.ellipsis),
      Text("EVE"),
      Text("GK"),
      Text("15"),
      Text("34"),
      Text("Bosnia-Herzegovina", maxLines: 1, overflow: TextOverflow.ellipsis),
    ];

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
                icon: const Icon(Icons.help),
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
                          child: Text("Name")),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: Text("Team")),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: Text("Position")),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: Text("Number")),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: Text("Age")),
                      Container(
                          width: 55,
                          alignment: Alignment.center,
                          child: Text("Country")),
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
              /* Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        //height: 50,
                        //width: 50,
                        child: const Text(
                          "Alex Oxlade-Chamberlain",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Themes.guessYellow,
                        ),
                        //height: 50,
                        //width: 50,
                        child: const Text("BHA")),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Themes.guessYellow,
                        ),
                        //height: 50,
                        //width: 50,
                        child: const Text("AM")),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Themes.guessYellow,
                        ),
                        //height: 50,
                        //width: 50,
                        child: const Text("18")),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Themes.guessGreen,
                        ),
                        //height: 50,
                        //width: 50,
                        child: const Text("17")),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Themes.guessYellow,
                        ),
                        //height: 50,
                        //width: 50,
                        child: const Text("Dominican Republic",
                            maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ),
                ),
              ]), */
            ],
          ),
        ),
      ),
    );
  }
}
