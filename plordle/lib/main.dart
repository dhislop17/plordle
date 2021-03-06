import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:plordle/ui/home_page.dart';
import 'package:plordle/services/service_locator.dart';
import 'package:plordle/view_models/player_view_model.dart';
import 'package:plordle/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

Future main() async {
  setupServiceLocator();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        child: MaterialApp(
          title: 'PLordle',
          theme: ThemeData(
              primarySwatch: Colors.purple, brightness: Brightness.light),
          darkTheme: ThemeData(
              primaryColor: Colors.purple, brightness: Brightness.dark),
          home: const HomePage(),
        ));
  }
}
