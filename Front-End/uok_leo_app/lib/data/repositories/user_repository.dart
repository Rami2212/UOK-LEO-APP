import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserRepository {
  final String baseUrl = "http://localhost:3000/api/v1"; // ✅ double check if "vi" was a typo

  // Get user by ID
  Future<User> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile: ${response.statusCode}');
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String userId, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200) {
      print("Update failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  // Delete user profile
  Future<bool> deleteUserProfile(String userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode != 200) {
      print("Delete failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  // Fetch all users
  Future<List<User>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['users']['data'];
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  // Add new user
  Future<bool> addUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201) {
      print("Add failed: ${response.body}");
    }

    return response.statusCode == 201;
  }
}
