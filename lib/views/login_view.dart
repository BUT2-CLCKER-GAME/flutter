import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:provider/provider.dart';

import '../services/player_service.dart';
import '../services/storage_service.dart';
import '../viewmodels/player_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    final String? token = await StorageService.getToken();
    if (token != null) {
      if (mounted) {
        PlayerViewModel playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
        if (await playerViewModel.initPlayerToken(token) && mounted) {
          Navigator.pushReplacementNamed(context, '/game');
          return;
        }
      }
    }
    setState(() {
      _isChecking = false;
    });
  }

  void _validateInput(PlayerViewModel playerViewModel) async {
    if (await playerViewModel.initPlayerUsername(_usernameController.text, _passwordController.text)) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/game');
      }
    }
    else {
      bool? confirmed = await showConfirmationDialog("Le compte n'existe pas, voulez vous le créer ?");
      if (confirmed == true) {
        if (await PlayerService.getInstance().register(_usernameController.text, _passwordController.text)) {
          if (context.mounted) {
            _validateInput(playerViewModel);
          }
        }
        else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la création du compte')));
        }
      }
      else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Identifiants invalides')));
        }
      }
    }
  }

  Future<bool?> showConfirmationDialog(String message) async {
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
    if (_isChecking) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
              onPressed: () => _validateInput(playerViewModel),
              child: Text('Valider'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text("Créer un compte", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}