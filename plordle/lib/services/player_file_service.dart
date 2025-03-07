import 'dart:convert' show json;

import 'package:logger/logger.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:plordle/models/player.dart';

class PlayerFileService {
  final Logger logger = Logger(printer: PrettyPrinter());

  Future<List<Player>> loadSeasonList() async {
    String jsonString = await rootBundle
        .loadString('assets/season_lists/2024_2025_players.json');

    return _parsePlayerList(jsonString);
  }

  List<Player> _parsePlayerList(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();

    return parsed.map<Player>((json) => Player.fromJson(json)).toList();
  }
}
