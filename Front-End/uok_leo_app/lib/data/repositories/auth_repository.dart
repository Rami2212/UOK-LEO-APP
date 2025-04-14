import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/registration_request.dart';

class AuthRepository {
  final String baseUrl = "http://10.0.2.2:3000/api/v1/users";

  // Login method
  Future<Map<String, dynamic>?> login(LoginRequest request) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        "userID": responseBody['data']['data']['userID'],
        "email": responseBody['data']['data']['email'],
        "role": responseBody['data']['data']['role'],
        "name": responseBody['data']['data']['name'],
        "token": responseBody['data']['data']['token'],
        "message": responseBody['data']['message'],
        "success": responseBody['data']['success']
      };
    } else {
      return null;
    }
  }

  // Register method
  Future<Map<String, dynamic>?> register(RegistrationRequest registrationRequest) async {
    final url = Uri.parse('$baseUrl/create'); // double-check your baseUrl

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(registrationRequest.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Access the nested data correctly
        final innerData = responseBody['data']?['data'];
        final success = responseBody['data']?['success'] ?? false;

        if (innerData != null) {
          return {
            "userID": innerData['userID'],
            "email": innerData['email'],
            "role": innerData['role'],
            "name": innerData['name'],
            "token": innerData['token'],
            "message": responseBody['message'],
            "success": success,
          };
        }
      } else {
        print("Registration failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error during registration: $e");
    }

    return null;
  }


}
