class LeaderboardPlayerModel {
  final String id;
  final String username;
  final int exp;
  final int gold;
  final int? currentEnemyId;

  LeaderboardPlayerModel(this.id, this.username, this.exp, this.gold, this.currentEnemyId);
}