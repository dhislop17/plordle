import 'package:plordle/models/player.dart';

abstract class DataService {
  Future<List<Player>> getPlayers();
  Future<Player> getTodaysPlayer();
  Future<Player> getRandomPlayer();
}
