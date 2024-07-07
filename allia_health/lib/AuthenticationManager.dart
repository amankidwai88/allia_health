import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthenticationManager with ChangeNotifier {
  static const String baseUrl = 'https://api-dev.allia.health';
  String? accessToken;
  String? refreshTokenValue; // Rename refreshToken to avoid conflict

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/client/auth/login');
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(Duration(seconds: 10)); // Example: 10 seconds total timeout

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        accessToken = responseData['accessToken'];
        refreshTokenValue =
            responseData['refreshToken']; // Update renamed variable
        notifyListeners();
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors (connection timeout, etc.)
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> refreshToken() async {
    final url = Uri.parse('$baseUrl/api/client/auth/refresh-token');
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshTokenValue}),
          )
          .timeout(Duration(seconds: 10)); // Example: 10 seconds total timeout

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        accessToken = responseData['accessToken'];
        notifyListeners();
      } else {
        throw Exception('Failed to refresh token: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors (connection timeout, etc.)
      throw Exception('Failed to refresh token: $e');
    }
  }

  bool get isAuthenticated => accessToken != null;
}
