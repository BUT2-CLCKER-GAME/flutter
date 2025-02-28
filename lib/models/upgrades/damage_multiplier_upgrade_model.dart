import 'package:clcker/models/upgrades/upgrade_model.dart';

class DamageMultiplierUpgradeModel extends UpgradeModel {
  final double _multiplier;

  DamageMultiplierUpgradeModel(super.player, super.name, super.description, super.unlockLevel, super.level, super.price, this._multiplier);

  @override
  void applyUpgrade(int level) {
    player.increaseDamageMultiplier(_multiplier * level);
  }
}