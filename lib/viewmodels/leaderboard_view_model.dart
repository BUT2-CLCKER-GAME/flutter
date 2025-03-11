import 'package:flutter/material.dart';

import '../models/leaderboard_model.dart';
import '../services/leaderboard_service.dart';

class LeaderboardViewModel extends ChangeNotifier {
  late final LeaderboardService _service;
  LeaderboardModel? leaderboard;
  bool isLoading = false;
  String? errorMessage;
  int currentPage = 1;
  final int perPage = 10;

  LeaderboardViewModel() {
    _service = LeaderboardService();
    loadLeaderboard();
  }

  Future<void> loadLeaderboard({int page = 1}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      leaderboard = await _service.fetchLeaderboard(page: page, perPage: perPage);
      currentPage = page;
      if (leaderboard == null) {
        errorMessage = "Aucun leaderboard trouvé.";
      }
    } catch (e) {
      errorMessage = "Erreur lors du chargement du leaderboard.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    if (leaderboard != null && currentPage < leaderboard!.pages) {
      loadLeaderboard(page: currentPage + 1);
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      loadLeaderboard(page: currentPage - 1);
    }
  }
}
