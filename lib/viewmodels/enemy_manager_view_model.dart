import 'package:clcker/models/enemy_manager_model.dart';
import 'package:clcker/viewmodels/enemy_view_model.dart';
import 'package:flutter/material.dart';

class EnemyManagerViewModel extends ChangeNotifier {
  final EnemyManagerModel _enemyManagerModel;
  EnemyViewModel? _currentEnemy;

  EnemyManagerViewModel() :
      _enemyManagerModel = EnemyManagerModel()
  {
    _initEnemy();
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
    await _enemyManagerModel.takeDamage(damage);
    if (lastId != _enemyManagerModel.currentEnemyId) {
      _initEnemy();
    }
  }
}