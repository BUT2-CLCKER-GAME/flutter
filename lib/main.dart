import 'package:clcker/viewmodels/leaderboard_view_model.dart';
import 'package:clcker/views/leaderboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/enemy_manager_view_model.dart';
import 'viewmodels/player_view_model.dart';
import 'views/game_view.dart';
import 'views/login_view.dart';

void main() {
  PlayerViewModel player = PlayerViewModel();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => player),
          ChangeNotifierProvider(create: (context) => EnemyManagerViewModel(player)),
          ChangeNotifierProvider(create: (context) => LeaderboardViewModel()),
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clcker Game',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/game': (context) => GameView(),
        '/leaderboard': (context) => LeaderboardView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}