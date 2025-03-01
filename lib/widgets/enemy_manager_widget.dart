import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/enemy_manager_view_model.dart';
import 'enemy_widget.dart';

class EnemyManagerWidget extends StatelessWidget {
  const EnemyManagerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EnemyManagerViewModel enemyManagerViewModel = context.watch<EnemyManagerViewModel>();

    Widget widget;
    if (enemyManagerViewModel.currentEnemy != null) {
      widget = EnemyWidget();
    }
    else {
      widget = CircularProgressIndicator();
    }

    return ChangeNotifierProvider.value(
      value: enemyManagerViewModel.currentEnemy,
      child: widget,
    );
  }
}