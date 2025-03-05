import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/leaderboard_view_model.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<LeaderboardViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.errorMessage != null) {
                  return Center(child: Text(viewModel.errorMessage!));
                }

                if (viewModel.leaderboard == null || viewModel.leaderboard!.players.isEmpty) {
                  return const Center(child: Text("Aucun joueur trouvé."));
                }

                return ListView.builder(
                  itemCount: viewModel.leaderboard!.players.length,
                  itemBuilder: (context, index) {
                    final player = viewModel.leaderboard!.players[index];
                    return ListTile(
                      title: Text(player.username),
                      subtitle: Text("EXP: ${player.exp}, Gold: ${player.gold}"),
                      trailing: player.currentEnemyId != null
                          ? Text("Enemy ID: ${player.currentEnemyId}")
                          : const Text("No enemy"),
                    );
                  },
                );
              },
            ),
          ),
          Consumer<LeaderboardViewModel>(
            builder: (context, viewModel, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: viewModel.currentPage > 1 ? viewModel.previousPage : null,
                  ),
                  Text("Page ${viewModel.currentPage} / ${viewModel.leaderboard?.pages ?? 1}"),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: viewModel.leaderboard != null && viewModel.currentPage < viewModel.leaderboard!.pages
                        ? viewModel.nextPage
                        : null,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

