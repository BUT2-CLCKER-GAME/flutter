import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String api = "http://91.121.253.242:20101/";

  const ApiService();

  Future<dynamic> get(String endpoint) async {
    try {
      final uri = Uri.parse('$api$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      else {
        throw Exception('Failed to load data: ${response.statusCode} - ${response.body}');
      }
    }
    catch (e) {
      print('Error in get request: $e');
      return null;
    }
  }

  Future<void> patch(String endpoint) async {
    try {
      final uri = Uri.parse('$api$endpoint');
      final response = await http.patch(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      else {
        throw Exception('Failed to patch data: ${response.statusCode} - ${response.body}');
      }
    }
    catch (e) {
      print('Error in patch request: $e');
    }
  }
}