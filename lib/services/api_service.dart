import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String api = "http://91.121.253.242:20101/";

  const ApiService();

  Future<dynamic> get(String endpoint, {String? token}) async {
    try {
      final uri = Uri.parse('$api$endpoint');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(uri, headers: headers);

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

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$api$endpoint');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      else {
        throw Exception('Failed to post data: ${response.statusCode} - ${response.body}');
      }
    }
    catch (e) {
      print('Error in post request: $e');
      return null;
    }
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data, {String? token}) async {
    try {
      final uri = Uri.parse('$api$endpoint');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : '';
      }
      else {
        throw Exception('Failed to patch data: ${response.statusCode} - ${response.body}');
      }
    }
    catch (e) {
      print('Error in patch request: $e');
      return null;
    }
  }
}