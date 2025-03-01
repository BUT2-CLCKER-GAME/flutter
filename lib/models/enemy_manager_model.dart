import 'enemy_model.dart';
import '../services/enemy_service.dart';
import '../services/player_service.dart';

class EnemyManagerModel {
  static const EnemyService _enemyService = EnemyService();

  late int _currentEnemyId = PlayerService.getInstance().enemyId;
  late Future<EnemyModel?> _currentEnemy;

  EnemyManagerModel() {
    _currentEnemy = _enemyService.fetchEnemy(_currentEnemyId);
  }

  Future<EnemyModel> get currentEnemy async => (await _currentEnemy)!;
  int get currentEnemyId => _currentEnemyId;

  Future<int> get maxHealth async => (await _currentEnemy)!.maxHealth;

  Future<void> takeDamage(int damage) async {
    EnemyModel currentEnemy = (await _currentEnemy)!;

    currentEnemy.takeDamage(damage);
    if (currentEnemy.isDead) {
      _currentEnemyId++;
      PlayerService.getInstance().updatePlayer(currentEnemyId: _currentEnemyId);
      _currentEnemy = _enemyService.fetchEnemy(_currentEnemyId);
    }
  }
}