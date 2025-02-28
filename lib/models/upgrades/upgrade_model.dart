import 'dart:math';

import '../player_model.dart';

abstract class UpgradeModel {
  static const double _priceMultiplier = 2;

  final PlayerModel player;

  final String _name;
  final String _description;
  final int _unlockLevel;
  int _level = 0;
  int _price = 0;

  UpgradeModel(this.player, this._name, this._description, this._unlockLevel, int level, int price) {
    if (level > 0) {
      _level = level;
      _price = (price * pow(_priceMultiplier, level) as double) as int;
      applyUpgrade(_level);
    }
    else {
      _level = 0;
      _price = price;
    }
  }

  String get name => _name;
  String get description => _description;
  int get unlockLevel => _unlockLevel;
  int get price => _price;
  int get level => _level;

  void buy() {
    if (player.deductGold(_price)) {
      applyUpgrade(1);
      _level = 1;
    }
  }

  void upgrade() {
    _level++;
    _price = (_price * _priceMultiplier) as int;
    applyUpgrade(1);
  }

  void applyUpgrade(int level);
}