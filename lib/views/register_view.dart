import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import '../services/player_service.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    bool success = await PlayerService.getInstance(username, password).register(username, password);

    Navigator.pop(context);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compte créé avec succès. Connectez-vous !')),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la création du compte')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nom d'utilisateur:"),
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            Text('Mot de passe:'),
            PasswordField(
              controller: _passwordController,
              passwordConstraint: r'.+',
              errorMessage: 'Le mot de passe ne peut pas être vide',
              border: PasswordBorder(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            Text('Confirmer le mot de passe:'),
            PasswordField(
              controller: _confirmPasswordController,
              passwordConstraint: r'.+',
              errorMessage: 'Le mot de passe ne peut pas être vide',
              border: PasswordBorder(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text("S'inscrire"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Retour à la connexion', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
