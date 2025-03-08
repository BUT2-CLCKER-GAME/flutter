import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String _tokenKey = 'token';
  static const _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    final value = await _storage.read(key: _tokenKey);
    return value;
  }

  static Future<void> saveToken(String value) async {
    await _storage.write(key: _tokenKey, value: value);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}