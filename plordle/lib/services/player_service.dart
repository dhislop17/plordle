import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:plordle/models/player.dart';
import 'package:plordle/services/data_service.dart';

class PlayerService implements DataService {
  final String _baseRoute = (Platform.isAndroid)
      ? 'https://10.0.2.2:7160/api/'
      : 'https://localhost:7160/api/';

  @override
  Future<Player> getRandomPlayer() async {
    final response = await http.get(Uri.parse(_baseRoute + 'Players/random'));

    if (response.statusCode == 200) {
      return _parsePlayer(response.body);
    } else {
      throw Exception('Failed to get a random player');
    }
  }

  @override
  Future<Player> getTodaysPlayer() async {
    final response = await http.get(Uri.parse(_baseRoute + 'Players/today'));

    if (response.statusCode == 200) {
      return _parsePlayer(response.body);
    } else {
      throw Exception('Failed to get todays player');
    }
  }

  Player _parsePlayer(String reponseBody) {
    final parsed = json.decode(reponseBody);
    final result = Player.fromJson(parsed);
    return result;
  }

  //Method for geting players
  @override
  Future<List<Player>> getPlayers() async {
    final response = await http.get(Uri.parse(_baseRoute + 'Players'));

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
}
