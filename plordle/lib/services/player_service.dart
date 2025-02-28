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
    logger.d(uri);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return _parsePlayerList(response.body);
      } else {
        logger.d("API returned unexpected status code: ${response.statusCode}");
        throw Exception("Recieved unexpected status code");
      }
    } catch (exception) {
      logger.e(exception);
      throw Exception("Unable to connect to the API");
    }
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

    logger.d(uri);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return _parsePlayer(response.body);
      } else {
        logger.e(
            "Unable to retrieve mystery player. Response returned status code ${response.statusCode}");
        throw Exception('Failed to get a random player');
      }
    } catch (exception) {
      logger.e(exception);
      throw Exception("Unable to connect to the API");
    }
  }

  Future<Player> getTodaysPlayer(Set<String> excludedTeams) async {
    Uri uri = Uri(
        scheme: "https",
        host: _platformConfig.baseUrl,
        port: 7160,
        path: "/api/players/today",
        queryParameters: {'excludedTeams': excludedTeams});

    // TODO: Consider the log levels
    logger.d(uri);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return _parsePlayer(response.body);
      } else {
        logger.e(
            "Unable to retrieve daily player. Response returned status code ${response.statusCode}");
        throw Exception('Failed to get todays player');
      }
    } catch (exception) {
      logger.e(exception);
      throw Exception("Unable to connect to the API");
    }
  }

  Player _parsePlayer(String reponseBody) {
    final parsedResponseBody = json.decode(reponseBody);
    final parsedPlayer = Player.fromJson(parsedResponseBody);

    logger.d(parsedPlayer);
    return parsedPlayer;
  }
}
