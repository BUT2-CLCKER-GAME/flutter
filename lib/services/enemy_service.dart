import '../models/enemy_model.dart';
import '../services/api_service.dart';

class EnemyService extends ApiService {
  const EnemyService();

  Future<EnemyModel?> fetchEnemy(int id) async {
    try {
      final dynamic data = await get('enemies/$id');
      if (data != null) {
        return EnemyModel(data['name'], data['health'], data['image_url']);
      }
    }
    catch (e) {
      print("Erreur lors de la récupération de l'ennemis: $e");
    }
    return null;
  }
}
