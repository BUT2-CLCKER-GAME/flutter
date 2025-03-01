import 'upgrade_model.dart';

class GoldMultiplierUpgradeModel extends UpgradeModel {
  final double _multiplier;

  GoldMultiplierUpgradeModel(super.player, super.id, super.typeId, super.name, super.description, super.unlockLevel, super.level, super.price, this._multiplier);

  @override
  void applyUpgrade(int level) {
    player.increaseGoldMultiplier(_multiplier * level);
  }
}