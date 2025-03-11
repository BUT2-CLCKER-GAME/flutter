import 'package:clcker/viewmodels/leaderboard_view_model.dart';
import 'package:clcker/viewmodels/settings_view_model.dart';
import 'package:clcker/views/congratulations.dart';
import 'package:clcker/views/leaderboard_view.dart';
import 'package:clcker/views/settings_view.dart';
import 'package:clcker/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/player_view_model.dart';
import 'views/game_view.dart';
import 'views/login_view.dart';

void main() {
  PlayerViewModel player = PlayerViewModel();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => player),
        ChangeNotifierProvider(create: (context) => LeaderboardViewModel()),
        ChangeNotifierProvider(create: (context) => SettingsViewModel())
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
        '/game': (context) => GameView(),
        '/leaderboard': (context) => LeaderboardView(),
        '/settings': (context) => SettingsView(),
        '/signup': (context) => RegisterView(),
        '/congratulations': (context) => CongratulationsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}