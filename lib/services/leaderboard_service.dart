import '../models/leaderboard_model.dart';
import '../models/leaderboard_player_model.dart';
import '../services/api_service.dart';

class LeaderboardService extends ApiService {
  const LeaderboardService();

  Future<LeaderboardModel?> fetchLeaderboard({int page = 1, int perPage = 10}) async {
    try {
      final dynamic data = await get('players/leaderboard?page=$page&per_page=$perPage');
      if (data != null) {
        List<LeaderboardPlayerModel> players = (data['players'] as List).map((p) => LeaderboardPlayerModel(
          p['id'],
          p['username'],
          p['exp'],
          p['gold'],
          p['current_enemy_id'],
        )).toList();
        return LeaderboardModel(
          data['total'],
          data['pages'],
          data['current_page'],
          data['per_page'],
          players,
        );
      }
    } catch (e) {
      print("Erreur lors de la récupération du leaderboard: $e");
    }
    return null;
  }
}
