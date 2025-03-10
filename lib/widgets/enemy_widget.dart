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

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            enemyViewModel.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          Stack(
            children: [
              LinearProgressIndicator(
                value: enemyViewModel.health / enemyViewModel.maxHealth,
                minHeight: 20,
              ),
              Center(
                child: Text(
                  "${enemyViewModel.health}/${enemyViewModel.maxHealth}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          GestureDetector(
            onTap: () => enemyManagerViewModel.onClick(1),
            child: Image.asset(
              enemyViewModel.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}