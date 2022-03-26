import 'package:flutter/material.dart';
import 'package:plordle/ui/app_theme.dart';
import 'package:plordle/ui/widgets/search_box.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.premPurple,
        title: const Text(
          "PLORDLE",
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
        child: ChangeNotifierProvider<PlayerViewModel>(
          create: (context) => PlayerViewModel(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .1,
                    bottom: MediaQuery.of(context).size.width * .1),
                child: const Text(
                  'EPL Player Guessing Game',
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
                  child: const Text('Blocks will go from here to bottom',
                      style: TextStyle(
                          fontSize: 24, backgroundColor: Themes.premGreen))),
            ],
          ),
        ),
      ),
    );
  }
}
