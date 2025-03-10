import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsViewModel = context.watch<SettingsViewModel>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/game');
                },
                child: Text('Retour'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  settingsViewModel.disconnect();
                  Navigator.pushReplacementNamed(context, '/');
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