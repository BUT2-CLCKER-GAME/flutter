import 'package:clcker/models/upgrades/upgrade.dart';

class GoldMultiplierUpgrade extends Upgrade {
  final double _multiplier;

  GoldMultiplierUpgrade(super.player, super.name, super.description, super.unlockLevel, super.level, super.price, this._multiplier);

  @override
  void applyUpgrade(int level) {
    player.increaseGoldMultiplier(_multiplier * level);
  }
}