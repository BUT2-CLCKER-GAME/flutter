import 'package:flutter/material.dart';
import 'dart:async';

import '../models/enemy_manager_model.dart';
import 'enemy_view_model.dart';
import 'player_view_model.dart';

class EnemyManagerViewModel extends ChangeNotifier {
  final PlayerViewModel _player;
  final EnemyManagerModel _enemyManagerModel;
  EnemyViewModel? _currentEnemy;

  late Timer _autoClickerTimer;
  double clicksBuffer = 0.0;

  EnemyManagerViewModel(this._player) : _enemyManagerModel = EnemyManagerModel() {
    _initEnemy();
    _autoClickerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      clicksBuffer += _player.clicksPerSecond / 10;
      int clicksToPerform = clicksBuffer.floor();
      if (clicksToPerform > 0) {
        onClick(clicksToPerform);
        clicksBuffer -= clicksToPerform;
      }
    });
  }

  @override
  void dispose() {
    _autoClickerTimer.cancel();
    super.dispose();
  }

  void _initEnemy() async {
    _currentEnemy = EnemyViewModel(await _enemyManagerModel.currentEnemy);
    notifyListeners();
  }

  EnemyViewModel? get currentEnemy => _currentEnemy;

  void updateOnEnemyId() async {
    _enemyManagerModel.updateOnEnemyId();
    _currentEnemy = EnemyViewModel(await _enemyManagerModel.currentEnemy);
    notifyListeners();
  }

  void onClick(int clicks) {
    _takeDamage(clicks);
    notifyListeners();
  }

  void _takeDamage(int damage) async {
    int lastId = _enemyManagerModel.currentEnemyId;
    int maxHealth = await _enemyManagerModel.maxHealth;
    await _enemyManagerModel.takeDamage((damage * _player.damageMultiplier).round());
    _player.addExperience(damage * _player.damageMultiplier * _player.experienceMultiplier);

    if (lastId != _enemyManagerModel.currentEnemyId) {
      _player.addGold((maxHealth * _player.goldMultiplier).round());
      _initEnemy();
    }
  }
}
