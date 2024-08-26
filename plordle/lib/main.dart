import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plordle/ui/pages/filter_players_page.dart';

import 'package:plordle/ui/pages/home_page.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/ui/pages/landing_page.dart';
import 'package:plordle/ui/pages/settings_page.dart';
import 'package:plordle/ui/pages/theme_selection_page.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/theme_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

Future main() async {
  setupServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: '.env');
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
          ChangeNotifierProxyProvider<PlayerViewModel, UserViewModel>(
              create: (_) => UserViewModel(),
              update: (_, player, user) => user!.update(player))
        ],
        child: MaterialApp(
            title: 'PLordle',
            theme: ThemeData(
                primarySwatch: Colors.purple, brightness: Brightness.light),
            darkTheme: ThemeData(
                primaryColor: Colors.purple, brightness: Brightness.dark),
            home: LandingPage(),
            routes: {
              'game': (context) => const HomePage(),
              'themeSelect': (context) => const ThemeSelectionPage(),
              'filter': (context) => const FilterPlayersPage(),
              'settings': (context) => const SettingsPage()
            }));
  }
}
