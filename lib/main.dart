import 'package:clcker/viewmodels/enemy_manager_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/player_view_model.dart';
import 'views/game_view.dart';
import 'widgets/login_view.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlayerViewModel()),
          ChangeNotifierProvider(create: (context) => EnemyManagerViewModel())
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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}