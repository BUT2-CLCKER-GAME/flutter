import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/player_view_model.dart';
import '../viewmodels/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsViewModel settings = context.watch<SettingsViewModel>();
    PlayerViewModel player = context.watch<PlayerViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Connecté en tant que ${player.name}.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await settings.disconnect();
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: Text('Deconnexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}