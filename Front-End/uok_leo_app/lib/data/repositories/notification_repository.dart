import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notification.dart';

class NotificationRepository {
  final String baseUrl = "http://localhost:3000/api/notifications";

  Future<List<Notifications>> fetchNotifications(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl?userId=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Notifications.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load notifications");
    }
  }
}