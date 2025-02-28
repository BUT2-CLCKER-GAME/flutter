import '../models/player_model.dart';
import 'api_service.dart';

class PlayerService extends ApiService {
  static PlayerService? _instance;
  final int _playerId;
  late int _enemyId;

  PlayerService._internal(this._playerId);

  static PlayerService getInstance([int? playerId]) {
    if (_instance == null) {
      if (playerId == null) {
        throw Exception("PlayerService n'a pas encore été initialisé avec un playerId.");
      }
      _instance = PlayerService._internal(playerId);
    }
    return _instance!;
  }

  int get enemyId => _enemyId;

  Future<PlayerModel?> fetchPlayer() async {
    try {
      final dynamic data = await get('players/$_playerId');
      if (data != null) {
        _enemyId = data['actual_enemy'];
        return PlayerModel(this, data['name'], data['exp'].toDouble(), data['coins'], []);
      }
    }
    catch (e) {
      print("Erreur lors de la récupération du joueur: $e");
    }

    return null;
  }

  Future<void> updateGold(int gold) async {
    try {
      await patch('players/$_playerId?coins=$gold');
    }
    catch (e) {
      print("Erreur lors de la mise à jour de l'or: $e");
    }
  }
}
