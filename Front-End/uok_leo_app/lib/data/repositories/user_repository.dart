import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final String baseUrl = "http://localhost:3000/api/v1"; // ✅ double check if "vi" was a typo

  Future<User> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile: ${response.statusCode}');
    }
  }

  Future<bool> updateUserProfile(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": user.name,
        "lastName": user.lastName,
        "role": user.role,
        "avenue": user.avenue,
        "dob": user.dob,
        "email": user.email,
        "mobileNumber": user.mobileNumber,
        "studentId": user.studentId,
        "faculty": user.faculty,
        "department": user.department,
      }),
    );

    if (response.statusCode != 200) {
      print("Update failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  Future<bool> deleteUserProfile(String userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode != 200) {
      print("Delete failed: ${response.body}");
    }

    return response.statusCode == 200;
  }
}
