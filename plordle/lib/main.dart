import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plordle/config/platform_config.dart';
import 'package:plordle/ui/pages/appearance_difficulty_page.dart';
import 'package:plordle/ui/pages/filter_players_page.dart';

import 'package:plordle/ui/pages/home_page.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/ui/pages/landing_page.dart';
import 'package:plordle/ui/pages/welcome_page.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

Future main() async {
  setupServiceLocator();
  HttpOverrides.global = MyHttpOverrides();

  //TODO: Consider how this would work in production
  await dotenv.load(fileName: '.env');
  await PlatformConfig().initialize();
  runApp(const Plordle());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Plordle extends StatelessWidget {
  const Plordle({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PlayerViewModel>(
              create: (context) => PlayerViewModel()),
          ChangeNotifierProvider<ThemeViewModel>(
              create: (context) => ThemeViewModel()),
          //Set up a dependency relationship (UserModel depends on Player)
          //to support changing between game modes (random vs todays player)
          ChangeNotifierProxyProvider<PlayerViewModel, UserViewModel>(
              create: (_) => UserViewModel(),
              update: (_, playerModel, userModel) =>
                  userModel!.update(playerModel))
        ],
        builder: (context, child) {
          var themeModel = Provider.of<ThemeViewModel>(context);
          return MaterialApp(
              title: 'PLordle',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: themeModel.primarySelectedThemeColor),
              ),
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  colorSchemeSeed: themeModel.primarySelectedThemeColor),
              home: LandingPage(),
              routes: {
                'game': (context) => const HomePage(),
                'filter': (context) => const FilterPlayersPage(),
                'appearanceDifficulty': (context) =>
                    const AppearanceDifficultyPage(),
                'welcome': (context) => const WelcomePage()
              });
        });
  }
}
