import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/registration_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = "https://leo-production-4c2e.up.railway.app/api/v1/users";

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
  Future<Map<String, dynamic>?> register(RegistrationRequest registrationRequest, String email) async {
    final url = Uri.parse('$baseUrl/create');

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

        final otpResponse = await http.post(
          Uri.parse('$baseUrl/otp/${innerData['userID']}'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"email": email}),
        );

        if (otpResponse.statusCode == 200) {
          final otpBody = json.decode(otpResponse.body);
          final otp = otpBody['data']?['otp']; // Extract the OTP

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userID', innerData['userID']);
          await prefs.setString('email', innerData['email']);
          await prefs.setString('otp', otp.toString());
          print(innerData['userID'] + innerData['email'] + otp.toString());
          return {
            "userID": innerData['userID'],
            "email": innerData['email'],
            "role": innerData['role'],
            "name": innerData['name'],
            "token": innerData['token'],
            "message": responseBody['message'],
            "success": success,
            "otp": otp.toString(), // Return the OTP
          };
        } else {
          print("Failed to send OTP: ${otpResponse.statusCode}");
        }
      } else {
        print("Registration failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error during registration: $e");
    }

    return null;
  }

  // Reset Password
  Future<Map<String, dynamic>> changeUserPassword({
    required String userId,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/changePw/$userId');

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"password": newPassword}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {"success": true, "data": data};
      } else {
        return {"success": false, "message": data['message'] ?? 'Unknown error'};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }


}
