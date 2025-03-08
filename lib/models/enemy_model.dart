class EnemyModel {
  final String _name;
  final int _maxHealth;
  int _health;
  final String _imageUrl;

  EnemyModel(this._name, this._maxHealth, this._imageUrl) :
      _health = _maxHealth;

  String get name => _name;
  int get maxHealth => _maxHealth;
  int get health => _health;
  String get imageUrl => _imageUrl;

  bool get isDead => _health == 0;

  void takeDamage(int damage) {
    if (damage >= 0) {
      _health -= damage;
      if (_health < 0) {
        _health = 0;
      }
    }
  }
}