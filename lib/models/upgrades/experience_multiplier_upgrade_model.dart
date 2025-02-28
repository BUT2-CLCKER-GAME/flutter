import 'package:clcker/models/upgrades/upgrade_model.dart';

class ExperienceMultiplierUpgradeModel extends UpgradeModel {
  final double _multiplier;

  ExperienceMultiplierUpgradeModel(super.player, super.name, super.description, super.unlockLevel, super.level, super.price, this._multiplier);

  @override
  void applyUpgrade(int level) {
    player.increaseExperienceMultiplier(_multiplier * level);
  }
}