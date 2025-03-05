import 'package:flutter/material.dart';

import '../../models/leaderboard_player_model.dart';

class LeaderboardPlayerTile extends StatelessWidget {
  final LeaderboardPlayerModel player;

  const LeaderboardPlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${player.rank}. ${player.username}"), // Affichage du rang avant le nom
      subtitle: Text("EXP: ${player.exp}, Gold: ${player.gold}"),
      trailing: player.enemy != null
          ? Text("Enemy: ${player.enemy!.name} (ID: ${player.enemy!.id})")
          : const Text("No enemy"),
    );
  }
}
