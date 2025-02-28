import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/player_view_model.dart';
import '../widgets/enemy_manager_widget.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerViewModel playerViewModel = context.watch<PlayerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${playerViewModel.name} (${playerViewModel.gold}g, ${playerViewModel.experience}xp)'),
      ),
      body: Center(
        child: Column(
          children: [
            EnemyManagerWidget()
          ],
        ),
      ),
    );
  }
}