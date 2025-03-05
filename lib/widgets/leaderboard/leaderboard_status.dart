import 'package:flutter/material.dart';

class LeaderboardStatus extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;

  const LeaderboardStatus({super.key, required this.isLoading, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return const SizedBox.shrink(); // Rien à afficher si tout va bien
  }
}
