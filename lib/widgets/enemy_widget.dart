import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/enemy_manager_view_model.dart';
import '../viewmodels/enemy_view_model.dart';

class EnemyWidget extends StatefulWidget {
  const EnemyWidget({super.key});

  @override
  _EnemyWidgetState createState() => _EnemyWidgetState();
}

class _EnemyWidgetState extends State<EnemyWidget> {
  double _shakeOffset = 0.0;

  void _startShake() {
    int count = 0;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _shakeOffset = (count % 2 == 0) ? 5.0 : -5.0;
      });
      count++;

      if (count > 4) {
        timer.cancel();
        setState(() {
          _shakeOffset = 0.0;
        });
      }
    });
  }

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
          SizedBox(height: 32),

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
          SizedBox(height: 32),

          GestureDetector(
            onTap: () {
              _startShake();
              enemyManagerViewModel.onClick(1);
            },
            child: Transform.translate(
              offset: Offset(_shakeOffset, 0),
              child: Image.asset(
                enemyViewModel.imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}