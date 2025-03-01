import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/enemy_manager_view_model.dart';
import '../viewmodels/enemy_view_model.dart';

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EnemyManagerViewModel enemyManagerViewModel = context.watch<EnemyManagerViewModel>();
    EnemyViewModel enemyViewModel = context.watch<EnemyViewModel>();

    return GestureDetector(
      onTap: () => enemyManagerViewModel.onClick(1),
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                enemyViewModel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${enemyViewModel.health}/${enemyViewModel.maxHealth}"
              ),
            ],
          ),
        ),
      ),
    );
  }
}