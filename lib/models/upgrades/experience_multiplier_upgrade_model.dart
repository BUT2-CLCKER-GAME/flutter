import 'upgrade_model.dart';

class ExperienceMultiplierUpgradeModel extends UpgradeModel {
  final double _multiplier;

  ExperienceMultiplierUpgradeModel(super.player, super.id, super.typeId, super.name, super.description, super.unlockLevel, super.level, super.price, this._multiplier);

  @override
  void applyUpgrade(int level) {
    player.increaseExperienceMultiplier(_multiplier * level);
  }
}