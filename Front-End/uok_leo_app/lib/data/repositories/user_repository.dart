import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final String baseUrl = "https://your-api-url.com";

  Future<User> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<bool> updateUserProfile(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": user.name,
        "role": user.role,
        "avenue": user.avenue,
        "dob": user.dob,
        "email": user.email,
        "contact": user.contact,
        "profileImage": user.profileImage,
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteUserProfile(String userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$userId'));

    return response.statusCode == 200;
  }
}
