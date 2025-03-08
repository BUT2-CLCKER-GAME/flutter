import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/leaderboard_view_model.dart';
import '../widgets/leaderboard/leaderboard_pagination.dart';
import '../widgets/leaderboard/leaderboard_status.dart';
import '../widgets/leaderboard/leaderboard_tile.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/game');
          },
        ),
      ),
      body: Column(
        children: [
          Consumer<LeaderboardViewModel>(
            builder: (context, viewModel, child) {
              return LeaderboardStatus(
                isLoading: viewModel.isLoading,
                errorMessage: viewModel.errorMessage,
              );
            },
          ),
          Expanded(
            child: Consumer<LeaderboardViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.leaderboard == null || viewModel.leaderboard!.players.isEmpty) {
                  return const Center(child: Text("Aucun joueur trouvé."));
                }

                return ListView.builder(
                  itemCount: viewModel.leaderboard!.players.length,
                  itemBuilder: (context, index) {
                    final player = viewModel.leaderboard!.players[index];
                    return LeaderboardPlayerTile(player: player);
                  },
                );
              },
            ),
          ),
          Consumer<LeaderboardViewModel>(
            builder: (context, viewModel, child) {
              return LeaderboardPagination(
                currentPage: viewModel.currentPage,
                totalPages: viewModel.leaderboard?.pages ?? 1,
                onPreviousPage: viewModel.previousPage,
                onNextPage: viewModel.nextPage,
              );
            },
          ),
        ],
      ),
    );
  }
}
