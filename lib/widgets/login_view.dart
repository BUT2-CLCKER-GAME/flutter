import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:provider/provider.dart';

import '../services/player_service.dart';
import '../viewmodels/player_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateInput(BuildContext context, PlayerViewModel playerViewModel) async {
    print('${_usernameController.text}:${_passwordController.text}');
    if (await playerViewModel.initPlayer(_usernameController.text, _passwordController.text)) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/game');
      }
    }
    else {
      if (context.mounted) {
        bool? confirmed = await showConfirmationDialog(context, "Le compte n'existe pas, voulez vous le créer ?");
        if (confirmed == true) {
          if (await PlayerService.getInstance().register(_usernameController.text, _passwordController.text)) {
            if (context.mounted) {
              _validateInput(context, playerViewModel);
            }
          }
          else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la création du compte')));
          }
        }
        else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Identifiants invalides')));
          }
        }
      }
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context, String message) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Non"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Oui"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PlayerViewModel playerViewModel = context.watch<PlayerViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom d\'utilisateur:'),
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text('Mot de passe:'),
            PasswordField(
              controller: _passwordController,
              passwordConstraint: r'.+',
              errorMessage: 'Le mot de passe ne peut pas être vide',
              border: PasswordBorder(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _validateInput(context, playerViewModel),
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
