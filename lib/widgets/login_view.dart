import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/player_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _controller = TextEditingController();

  void _validateInput(BuildContext context, PlayerViewModel playerViewModel) async {
    int? value = int.tryParse(_controller.text);
    if (value != null) {
      if (await playerViewModel.initPlayer(value)) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/game');
        }
      }
      else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Indice invalide')));
      }
    }
    else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez entrer un nombre valide.')));
      }
    }
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
            Text('Entrez l\'id du joueur:'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
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
