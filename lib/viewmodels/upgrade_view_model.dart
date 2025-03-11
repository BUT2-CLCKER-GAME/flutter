import 'package:flutter/material.dart';

import '../models/upgrades/upgrade_model.dart';
import 'player_view_model.dart';

class UpgradeViewModel extends ChangeNotifier {
  final UpgradeModel _upgrade;

  UpgradeViewModel(this._upgrade);

  String get name => _upgrade.name;
  String get description => _upgrade.description;
  int get unlockExp => _upgrade.unlockExp;
  int get price => _upgrade.price;
  int get level => _upgrade.level;

  void click(PlayerViewModel player) {
    if (player.gold > _upgrade.price) {
      if (_upgrade.level == 0) {
        _upgrade.buy();
      }
      else {
        _upgrade.upgrade();
      }
      player.deductGold(_upgrade.price);
    }
    notifyListeners();
  }
}