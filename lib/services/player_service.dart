import 'package:clcker/services/storage_service.dart';

import 'upgrade_service.dart';
import '../models/upgrades/upgrade_model.dart';
import '../models/player_model.dart';
import 'api_service.dart';

class PlayerService extends ApiService {
  static PlayerService? _instance;

  late final UpgradeService _upgradeService;

  final String _username;
  final String _password;
  String? _token;

  late int _enemyId;

  PlayerService._internal(this._token, this._username, this._password);

  static PlayerService getInstance([String? token, String? username, String? password]) {
    if (_instance == null) {
      if (token != null) {
        _instance = PlayerService._internal(token, '', '');
      }
      else {
        if (username == null || password == null) {
          throw Exception("PlayerService n'a pas encore été initialisé avec un playerId.");
        }
        _instance = PlayerService._internal(null, username, password);
      }
    }
    return _instance!;
  }

  UpgradeService get upgradeService => _upgradeService;

  String get token => _token!;
  int get enemyId => _enemyId;

  Future<String?> _getToken(String username, String password) async {
    try {
      final dynamic data = await post('auth/login', {
        "username": username,
        "password": password
      });
      if (data != null) {
        StorageService.saveToken(data['token']);
        return data['token'];
      }
    }
    catch (e) {
      print("Erreur lors de la récupération de l'ID du joueur : $e");
    }

    return null;
  }



  Future<bool> register(String username, String password) async {
    try {
      final dynamic data = await post('auth/register', {
        "username": username,
        "password": password
      });
      if (data != null) {
        return true;
      }
    }
    catch (e) {
      print("Erreur lors de la création du joueur: $e");
    }

    return false;
  }

  Future<PlayerModel?> fetchPlayer() async {
    try {
      if (_token == null) {
        String? token = await _getToken(_username, _password);
        if (token != null) {
          _token = token;
        }
        else {
          return null;
        }
      }

      final dynamic data = await get('players/me', token: _token);

      if (data != null) {
        _enemyId = data['current_enemy_id'];

        PlayerModel player = PlayerModel(this, data['username'], data['exp'].toDouble(), data['gold']);
        _upgradeService = UpgradeService(player);
        await _upgradeService.fetchUpgrades(_token!);

        return player;
      }
    }
    catch (e) {
      print("Erreur lors de la récupération du joueur: $e");
    }

    return null;
  }

  Future<void> updatePlayer({int? currentEnemyId, int? gold, double? experience, List<UpgradeModel>? upgrades}) async {
    try {
      await patch('players/me/', {
        if (currentEnemyId != null) "current_enemy_id": currentEnemyId,
        if (gold != null) "gold": gold,
        if (experience != null) "exp": experience
      }, token: _token);
    }
    catch (e) {
      print("Erreur lors de la mise à jour de l'or: $e");
    }
  }

  void disconnect() {
    StorageService.deleteToken();
    _instance = null;
  }
}
