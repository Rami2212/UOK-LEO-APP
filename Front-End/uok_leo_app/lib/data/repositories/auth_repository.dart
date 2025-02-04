import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/registration_request.dart';
import '../models/registration_response.dart';

class AuthRepository {
  final String baseUrl = "http://your-backend-url.com/api/auth";

  // Login method
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return null; // Handle error properly
    }
  }

  // Register method
  Future<RegistrationResponse?> register(RegistrationRequest registrationRequest) async {
    final url = Uri.parse('$baseUrl/register'); // Your Spring Boot register endpoint

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(registrationRequest.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return RegistrationResponse.fromJson(data);
      } else {
        return null; // Registration failed, handle errors appropriately
      }
    } catch (e) {
      print("Error during registration: $e");
      return null; // Handle error cases
    }
  }
}
