import 'package:clcker/services/upgrade_service.dart';

import '../player_model.dart';

abstract class UpgradeModel {
  final PlayerModel player;
  late final UpgradeService _upgradeService = UpgradeService(player);

  final int _id;
  final int _typeId;

  final String _name;
  final String _description;
  final int _unlockExp;
  int _level = 0;
  int _price = 0;

  UpgradeModel(this.player, this._id, this._typeId, this._name, this._description, this._unlockExp, this._level, this._price) {
    if (_level > 0) {
      applyUpgrade(_level);
    }
  }

  String get name => _name;
  String get description => _description;
  int get unlockExp => _unlockExp;
  int get price => _price;
  int get level => _level;

  bool isType(int typeId) {
    return _typeId == typeId;
  }

  Future<void> buy() async {
    int? cost = await _upgradeService.saveUpgrade(player.token, _id);
    if (cost != null) {
      applyUpgrade(1);

      _level = 1;
      _price = cost;
    }
  }

  Future<void> upgrade() async {
    int? cost = await _upgradeService.saveUpgrade(player.token, _id);
    if (cost != null) {
      applyUpgrade(1);

      _level++;
      _price = cost;
    }
  }

  void applyUpgrade(int level);
}