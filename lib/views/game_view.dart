import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/enemy_manager_widget.dart';
import '../widgets/shop_widget.dart';
import '../viewmodels/player_view_model.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerViewModel player = context.watch<PlayerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${player.name} (${player.gold}g, ${player.experience}xp)'),
      ),
      body: Center(
        child: Column(
          children: [
            EnemyManagerWidget(),
            ShopWidget(),
          ],
        ),
      ),
    );
  }
}