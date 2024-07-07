import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static const String baseUrl = 'https://api-dev.allia.health';

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> post(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(url,
        headers: {...?headers, 'Content-Type': 'application/json'},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
