import 'package:clcker/models/leaderboard_enemy_model.dart';

class LeaderboardPlayerModel {
  final String id;
  final String username;
  final int exp;
  final int gold;
  final LeaderboardEnemyModel? enemy;
  final int rank;

  LeaderboardPlayerModel(this.id, this.username, this.exp, this.gold, this.enemy, this.rank);
}