import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:plordle/config/platform_config.dart';
import 'package:plordle/models/player.dart';

class PlayerService {
  final Logger logger = Logger(printer: PrettyPrinter());
  final PlatformConfig _platformConfig = PlatformConfig();

  //Method for geting players
  Future<List<Player>> getPlayers() async {
    Uri uri = Uri(
      scheme: "https",
      host: _platformConfig.baseUrl,
      path: "/api/players",
      port: 7160,
    );
    logger.i(uri);
    final response = await http.get(uri);

    List<Player> result = [];
    if (response.statusCode == 200) {
      result = _parsePlayerList(response.body);
    } else {
      logger.e("Unable to load players");
      throw Exception('Unable to load all players');
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
        host: _platformConfig.baseUrl,
        port: 7160,
        path: "/api/players/random",
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
        host: _platformConfig.baseUrl,
        port: 7160,
        path: "/api/players/today",
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
