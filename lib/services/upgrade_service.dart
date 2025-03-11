import 'package:clcker/models/upgrades/autoclcker_upgrade_model.dart';
import 'package:clcker/models/upgrades/experience_multiplier_upgrade_model.dart';
import 'package:clcker/models/upgrades/gold_multiplier_upgrade_model.dart';

import '../services/api_service.dart';
import '../models/player_model.dart';
import '../models/upgrades/upgrade_model.dart';
import '../models/upgrades/damage_multiplier_upgrade_model.dart';

class UpgradeService extends ApiService {
  final PlayerModel _player;

  UpgradeService(this._player);

  UpgradeModel? _dataToUpgrade(dynamic data) {
    switch (data['type']['id']) {
      case 1:
        return DamageMultiplierUpgradeModel(_player, data['id'], data['type']['id'], data['name'], data['description'], data['exp_required'], data['level'], data['cost'].round(), data['increase']);
      case 2:
        return ExperienceMultiplierUpgradeModel(_player, data['id'], data['type']['id'], data['name'], data['description'], data['exp_required'], data['level'], data['cost'].round(), data['increase']);
      case 3:
        return AutoclckerUpgradeModel(_player, data['id'], data['type']['id'], data['name'], data['description'], data['exp_required'], data['level'], data['cost'].round(), data['increase']);
      case 4:
        return GoldMultiplierUpgradeModel(_player, data['id'], data['type']['id'], data['name'], data['description'], data['exp_required'], data['level'], data['cost'].round(), data['increase']);
    }
    return null;
  }

  Future<void> fetchUpgrades(String token) async {
    try {
      final dynamic data = await get('players/me/upgrades', token: token);

      if (data != null) {
        for (dynamic upgrade in data['upgrades']) {
          _player.upgrades.add(_dataToUpgrade(upgrade)!);
        }
      }
    }
    catch (e) {
      print("Erreur lors de la récupération des améliorations: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> fetchUpgradeTypes() async {
    try {
      final dynamic data = await get('upgrades/types');

      if (data != null) {
        List<Map<String, dynamic>> upgradeTypes = [];
        for (dynamic upgradeType in data) {
          upgradeTypes.add({'name': upgradeType['name'], 'id': upgradeType['id']});
        }
        return upgradeTypes;
      }
    }
    catch (e) {
      print("Erreur lors de la récupération des types améliorations: $e");
    }

    return null;
  }

  Future<int?> saveUpgrade(String token, int upgradeId) async {
    try {
      final dynamic data = await post('players/me/upgrades/$upgradeId', null, token: token);

      if (data != null) {
        return data['cost'] as int?;
      }
    }
    catch (e) {
      print("Erreur lors de la sauvegarde des améliorations: $e");
    }

    return null;
  }
}