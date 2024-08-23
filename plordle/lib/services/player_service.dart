import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:plordle/models/player.dart';

class PlayerService {
  final Logger logger = Logger(printer: PrettyPrinter());

  String _baseHost() {
    String route;
    //Running on the emulator
    if (Platform.isAndroid) {
      route = dotenv.env["API_CONNECTION_STRING"] ?? '10.0.2.2';
    }
    // Running on a real device
    else {
      route = dotenv.env["API_CONNECTION_STRING"] ?? 'localhost';
    }

    return route;
  }

  //Method for geting players
  Future<List<Player>> getPlayers() async {
    Uri uri = Uri(
        scheme: "https", host: _baseHost(), path: "/api/Players", port: 7160);
    logger.i(uri);
    final response = await http.get(uri);

    List<Player> result = [];
    if (response.statusCode == 200) {
      return _parsePlayerList(response.body);
    }
    return result;
  }

  List<Player> _parsePlayerList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Player>((json) => Player.fromJson(json)).toList();
  }

  Future<Player> getRandomPlayer(Set<String> excludedTeams) async {
    Uri uri = Uri(
        scheme: "https",
        host: _baseHost(),
        port: 7160,
        path: "/api/Players/random",
        queryParameters: {'excludedTeams': excludedTeams});

    logger.i(uri);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return _parsePlayer(response.body);
    } else {
      throw Exception('Failed to get a random player');
    }
  }

  Future<Player> getTodaysPlayer(Set<String> excludedTeams) async {
    Uri uri = Uri(
        scheme: "https",
        host: _baseHost(),
        port: 7160,
        path: "/api/Players/today",
        queryParameters: {'excludedTeams': excludedTeams});

    logger.i(uri);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return _parsePlayer(response.body);
    } else {
      throw Exception('Failed to get todays player');
    }
  }

  Player _parsePlayer(String reponseBody) {
    final parsed = json.decode(reponseBody);
    final result = Player.fromJson(parsed);
    logger.i(result);
    return result;
  }
}
