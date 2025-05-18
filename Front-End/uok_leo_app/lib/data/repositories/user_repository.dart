import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/profile_edit_request.dart';
import '../models/user.dart';

class UserRepository {
  final String baseUrl = "https://leo-production-4c2e.up.railway.app/api/v1";

  // Private helper to get the token
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch user profile by ID
  Future<User> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      // Access the 'data' field inside 'user'
      return User.fromJson(decoded['user']['data']);
    } else {
      throw Exception('Failed to load user profile: ${response.statusCode}');
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(String userId, ProfileEditRequest profileEditRequest) async {
    final token = await _getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(profileEditRequest.toJson()),
    );

    if (response.statusCode != 200) {
      print("Update failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  // Delete user profile
  Future<bool> deleteUserProfile(String userId) async {
    final token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      print("Delete failed: ${response.body}");
    }

    return response.statusCode == 200;
  }

  // Fetch all users
  Future<List<User>> fetchAllUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      // Access the correct field for user data
      final List<dynamic> jsonList = decoded['user']['data'];  // Fix: changed 'users' to 'user'
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      print('Fetch users failed: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load users');
    }
  }

  // Add a new user
  Future<bool> addUser(User user) async {

    final response = await http.post(
      Uri.parse('$baseUrl/users/create'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200) {
      print("Add failed: ${response.body}");
    }

    return response.statusCode == 200;
  }
}
