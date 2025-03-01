import 'package:clcker/services/upgrade_service.dart';

import '../player_model.dart';

abstract class UpgradeModel {
  final PlayerModel player;
  late final UpgradeService _upgradeService = UpgradeService(player);

  final int _id;
  final int _typeId;

  final String _name;
  final String _description;
  final int _unlockLevel;
  int _level = 0;
  int _price = 0;

  UpgradeModel(this.player, this._id, this._typeId, this._name, this._description, this._unlockLevel, this._level, this._price) {
    if (_level > 0) {
      applyUpgrade(_level);
    }
  }

  String get name => _name;
  String get description => _description;
  int get unlockLevel => _unlockLevel;
  int get price => _price;
  int get level => _level;

  bool isType(int typeId) {
    return _typeId == typeId;
  }

  Future<void> buy() async {
    applyUpgrade(1);

    _level = 1;
    _price = await _upgradeService.saveUpgrade(player.token, _id) ?? 0;
  }

  Future<void> upgrade() async {
    applyUpgrade(1);

    _level++;
    _price = await _upgradeService.saveUpgrade(player.token, _id) ?? 0;
  }

  void applyUpgrade(int level);
}