import 'package:clcker/services/player_service.dart';
import 'package:flutter/cupertino.dart';

class SettingsViewModel extends ChangeNotifier {
  late final PlayerService _service;

  SettingsViewModel() {
    _service = PlayerService.getInstance();
  }

  void disconnect() {
      _service.disconnect();
  }
}