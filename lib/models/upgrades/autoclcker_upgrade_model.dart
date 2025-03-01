import 'upgrade_model.dart';

class AutoclckerUpgradeModel extends UpgradeModel {
  final int _clicksPerSecond;

  AutoclckerUpgradeModel(super.player, super.id, super.typeId, super.name, super.description, super.unlockLevel, super.level, super.price, this._clicksPerSecond);

  @override
  void applyUpgrade(int level) {
    player.increaseClicksPerSecond(_clicksPerSecond * level);
  }
}