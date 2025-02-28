import 'package:clcker/services/player_service.dart';

import 'upgrades/upgrade.dart';

class PlayerModel {
  final PlayerService _playerService;

  final String _name;
  double _experience;
  int _gold;
  final List<Upgrade> _upgrades;

  int _clicksPerSecond;
  double _damageMultiplier;
  double _goldMultiplier;
  double _experienceMultiplier;

  PlayerModel(this._playerService, this._name, this._experience, this._gold, this._upgrades) :
        _clicksPerSecond = 0, _damageMultiplier = 1.0, _goldMultiplier = 1.0, _experienceMultiplier = 1.0;

  String get name => _name;
  double get experience => _experience;
  int get gold => _gold;
  List<Upgrade> get upgrades => _upgrades;

  int get clicksPerSecond => _clicksPerSecond;
  double get damageMultiplier => _damageMultiplier;

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
      _playerService.updateGold(_gold);
      return true;
    }
    return false;
  }

  void addGold(int amount) {
    if (amount >= 0) {
      _gold += (amount * _goldMultiplier) as int;
      _playerService.updateGold(_gold);
    }
  }

  void addExperience(double amount) {
    if (amount >= 0.0) {
      _experience += amount * _experienceMultiplier;
    }
  }
}