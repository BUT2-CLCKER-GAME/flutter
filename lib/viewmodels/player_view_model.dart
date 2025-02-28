import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/upgrades/upgrade.dart';
import '../services/player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  late PlayerService _playerService;
  late PlayerModel _player;

  Future<bool> initPlayer(int id) async {
    _playerService = PlayerService.getInstance(id);
    PlayerModel? player = await _playerService.fetchPlayer();

    if (player != null) {
      _player = player;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  String get name => _player.name;
  double get experience => _player.experience;
  int get gold => _player.gold;
  List<Upgrade> get upgrades => _player.upgrades;

  int get clicksPerSecond => _player.clicksPerSecond;
  double get damageMultiplier => _player.damageMultiplier;

  bool deductGold(int amount) {
    bool result = _player.deductGold(amount);
    notifyListeners();
    return result;
  }

  void addGold(int amount) {
    _player.addGold(amount);
    notifyListeners();
  }

  void addExperience(double amount) {
    _player.addExperience(amount);
    notifyListeners();
  }
}