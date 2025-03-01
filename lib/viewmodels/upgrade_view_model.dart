import 'package:flutter/material.dart';

import '../models/upgrades/upgrade_model.dart';
import 'player_view_model.dart';

class UpgradeViewModel extends ChangeNotifier {
  final UpgradeModel _upgrade;

  UpgradeViewModel(this._upgrade);

  String get name => _upgrade.name;
  String get description => _upgrade.description;
  int get unlockLevel => _upgrade.unlockLevel;
  int get price => _upgrade.price;
  int get level => _upgrade.level;

  void click(PlayerViewModel player) {
    if (player.deductGold(_upgrade.price)) {
      if (_upgrade.level == 0) {
        _upgrade.buy();
      }
      else {
        _upgrade.upgrade();
      }
    }
    notifyListeners();
  }
}