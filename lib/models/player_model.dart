import 'dart:math';

import '../services/player_service.dart';
import 'upgrades/upgrade_model.dart';

class PlayerModel {
  final PlayerService _playerService;

  final String _name;
  double _experience;
  int _gold;
  final List<UpgradeModel> _upgrades;

  int _clicksPerSecond;
  double _damageMultiplier;
  double _goldMultiplier;
  double _experienceMultiplier;

  PlayerModel(this._playerService, this._name, this._experience, this._gold) :
        _clicksPerSecond = 0, _damageMultiplier = 1.0, _goldMultiplier = 1.0, _experienceMultiplier = 1.0, _upgrades = [];

  String get token => _playerService.token;

  String get name => _name;
  double get experience => _experience;
  int get level => pow(2, _experience).floor();
  int get gold => _gold;
  List<UpgradeModel> get upgrades => _upgrades;

  int get clicksPerSecond => _clicksPerSecond;
  double get damageMultiplier => _damageMultiplier;
  double get goldMultiplier => _goldMultiplier;
  double get experienceMultiplier => _experienceMultiplier;

  void increaseClicksPerSecond(int clicks) {
    if (clicks >= 0) {
      _clicksPerSecond += clicks;
    }
  }

  void increaseDamageMultiplier(double multiplier) {
    if (multiplier >= 0.0) {
      _damageMultiplier += multiplier;
    }
  }

  void increaseGoldMultiplier(double multiplier) {
    if (multiplier >= 0.0) {
      _goldMultiplier += multiplier;
    }
  }

  void increaseExperienceMultiplier(double multiplier) {
    if (multiplier >= 0.0) {
      _experienceMultiplier += multiplier;
    }
  }

  bool deductGold(int amount) {
    if (_gold - amount >= 0) {
      _gold -= amount;
      _playerService.updatePlayer(gold: _gold, experience: experience);
      return true;
    }
    return false;
  }

  void addGold(int amount) {
    if (amount >= 0) {
      _gold += (amount * _goldMultiplier).round();
      _playerService.updatePlayer(gold: _gold, experience: experience);
    }
  }

  void addExperience(double amount) {
    if (amount >= 0.0) {
      _experience += amount * _experienceMultiplier;
    }
  }
}