import 'leaderboard_player_model.dart';

class LeaderboardModel {
  final int total;
  final int pages;
  final int currentPage;
  final int perPage;
  final List<LeaderboardPlayerModel> players;

  LeaderboardModel(this.total, this.pages, this.currentPage, this.perPage, this.players);
}