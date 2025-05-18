import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification.dart';

class NotificationRepository {
  final String baseUrl = "https://leo-production-4c2e.up.railway.app/api/v1/notifications";

  // Private helper to get stored token and userId
  Future<Map<String, String?>> _getAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token'),
      'userId': prefs.getString('userId'),
    };
  }

// Fetch notification by user id
  Future<List<Notifications>> fetchNotifications() async {
    final authData = await _getAuthData();
    final userId = authData['userId'];

    print("User ID: $userId");  // Log userId for debugging

    if (userId == null) {
      throw Exception("User ID is not available");
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId'));

      print("Response status: ${response.statusCode}");  // Log the status code
      print("Response body: ${response.body}");  // Log the response body for debugging

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['notifications']['data'];

        print("Fetched data: $data");  // Log the fetched data

        return data.map((json) => Notifications.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load notifications. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching notifications: $e");  // Log any error during the request
      throw Exception("Error fetching notifications: $e");
    }
  }



  // Add a new notification
  Future<bool> addNotification(Notifications notification) async {
    try {
      final authData = await _getAuthData();
      final token = authData['token'];

      final url = Uri.parse("$baseUrl/save");
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };
      final body = json.encode(notification.toJson());

      print("🔼 Sending POST request to: $url");
      print("🔐 Headers: $headers");
      print("📦 Body: $body");

      final response = await http.post(url, headers: headers, body: body);

      print("📥 Response Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error adding notification: $e");
      return false;
    }
  }


  // Delete a notification
  Future<bool> deleteNotification(String notificationId) async {
    final authData = await _getAuthData();
    final token = authData['token'];

    final response = await http.delete(
      Uri.parse('$baseUrl/$notificationId'),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }
}
