import 'package:flutter/material.dart';

import '../models/enemy_model.dart';

class EnemyViewModel extends ChangeNotifier {
  final EnemyModel _enemy;

  EnemyViewModel(this._enemy);

  String get name => _enemy.name;
  int get maxHealth => _enemy.maxHealth;
  int get health => _enemy.health;

  void takeDamage(int damage) {
    _enemy.takeDamage(damage);
    notifyListeners();
  }
}