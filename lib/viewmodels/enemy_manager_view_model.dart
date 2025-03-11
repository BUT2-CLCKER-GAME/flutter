import 'package:flutter/material.dart';
import 'dart:async';

import '../models/enemy_manager_model.dart';
import 'enemy_view_model.dart';
import 'player_view_model.dart';

class EnemyManagerViewModel extends ChangeNotifier {
  final PlayerViewModel _player;
  final EnemyManagerModel _enemyManagerModel;
  EnemyViewModel? _currentEnemy;

  bool _end = false;

  late Timer _autoClickerTimer;
  double _clicksBuffer = 0.0;

  EnemyManagerViewModel(this._player) : _enemyManagerModel = EnemyManagerModel() {
    _initEnemy();
    _autoClickerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _clicksBuffer += _player.clicksPerSecond / 10;
      int clicksToPerform = _clicksBuffer.floor();
      if (clicksToPerform > 0) {
        onClick(clicksToPerform);
        _clicksBuffer -= clicksToPerform;
      }
    });
  }

  @override
  void dispose() {
    _autoClickerTimer.cancel();
    super.dispose();
  }

  bool get end => _end;
  EnemyViewModel? get currentEnemy => _currentEnemy;

  void _initEnemy() async {
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
      if (_enemyManagerModel.currentEnemyId <= 30) {
        _initEnemy();
      }
      else {
        _end = true;
      }
    }
  }
}