import 'upgrade_model.dart';

class DamageMultiplierUpgradeModel extends UpgradeModel {
  late final double _multiplier;

  DamageMultiplierUpgradeModel(super.player, super.id, super.typeId, super.name, super.description, super.unlockLevel, super.level, super.price, int multiplier)
      : _multiplier = multiplier.toDouble() / 100.0 + 1.0;

  @override
  void applyUpgrade(int level) {
    player.increaseDamageMultiplier(_multiplier * level);
  }
}