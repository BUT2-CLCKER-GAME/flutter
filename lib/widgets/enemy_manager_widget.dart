import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/enemy_manager_view_model.dart';
import 'enemy_widget.dart';

class EnemyManagerWidget extends StatelessWidget {
  const EnemyManagerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EnemyManagerViewModel enemyManagerViewModel = context.watch<EnemyManagerViewModel>();

    if (enemyManagerViewModel.end) {
      Navigator.pushReplacementNamed(context, '/congratulations');
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Transform.translate(
              offset: Offset(0, 40),
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Center(
          child: ChangeNotifierProvider.value(
            value: enemyManagerViewModel.currentEnemy,
            child: enemyManagerViewModel.currentEnemy != null
                ? EnemyWidget()
                : CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
