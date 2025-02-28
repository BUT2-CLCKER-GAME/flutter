import 'dart:async';

import 'package:clcker/models/enemy_manager_model.dart';
import 'package:clcker/viewmodels/enemy_view_model.dart';
import 'package:clcker/viewmodels/player_view_model.dart';
import 'package:flutter/material.dart';

class EnemyManagerViewModel extends ChangeNotifier {
  final PlayerViewModel _player;

  final EnemyManagerModel _enemyManagerModel;
  EnemyViewModel? _currentEnemy;

  late Timer autoClickerTimer;
  double clicksBuffer = 0.0;

  EnemyManagerViewModel(this._player) :
      _enemyManagerModel = EnemyManagerModel()
  {
    _initEnemy();
    autoClickerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      clicksBuffer += _player.clicksPerSecond / 10;

      int clicksToPerform = clicksBuffer.floor();
      if (clicksToPerform > 0) {
        onClick(clicksToPerform);
        clicksBuffer -= clicksToPerform;
      }
    });
  }

  void _initEnemy() async {
    _currentEnemy = EnemyViewModel(await _enemyManagerModel.currentEnemy);
    notifyListeners();
  }

  EnemyViewModel? get currentEnemy => _currentEnemy;

  void onClick(int clicks) {
    _takeDamage(clicks);
    notifyListeners();
  }

  void _takeDamage(int damage) async {
    int lastId = _enemyManagerModel.currentEnemyId;
    await _enemyManagerModel.takeDamage((damage * _player.damageMultiplier).round());
    if (lastId != _enemyManagerModel.currentEnemyId) {
      _initEnemy();
    }
  }
}