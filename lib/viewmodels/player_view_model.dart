import 'package:clcker/services/upgrade_service.dart';
import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/upgrades/upgrade_model.dart';
import '../services/player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  late PlayerService _playerService;
  late PlayerModel _player;

  Future<bool> initPlayerUsername(String username, String password) async {
    _playerService = PlayerService.getInstance(null, username, password);
    PlayerModel? player = await _playerService.fetchPlayer();

    if (player != null) {
      _player = player;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<bool> initPlayerToken(String token) async {
    _playerService = PlayerService.getInstance(token);
    PlayerModel? player = await _playerService.fetchPlayer();

    if (player != null) {
      _player = player;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  UpgradeService get upgradeService => _playerService.upgradeService;

  String get name => _player.name;
  double get experience => _player.experience;
  int get gold => _player.gold;
  List<UpgradeModel> get upgrades => _player.upgrades;

  int get clicksPerSecond => _player.clicksPerSecond;
  double get damageMultiplier => _player.damageMultiplier;
  double get goldMultiplier => _player.goldMultiplier;
  double get experienceMultiplier => _player.experienceMultiplier;

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