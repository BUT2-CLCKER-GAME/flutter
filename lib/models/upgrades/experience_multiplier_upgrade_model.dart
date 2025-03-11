import 'upgrade_model.dart';

class ExperienceMultiplierUpgradeModel extends UpgradeModel {
  late final double _multiplier;

  ExperienceMultiplierUpgradeModel(super.player, super.id, super.typeId, super.name, super.description, super.unlockLevel, super.level, super.price, int multiplier)
      : _multiplier = multiplier.toDouble() / 100.0 + 1.0;

  @override
  void applyUpgrade(int level) {
    player.increaseExperienceMultiplier(_multiplier * level);
  }
}