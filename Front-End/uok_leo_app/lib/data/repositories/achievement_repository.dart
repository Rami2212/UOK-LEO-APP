import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/achievement.dart';

class AchievementRepository {
  final String baseUrl = "https://example.com/api";

  Future<List<Achievement>> fetchAllAchievements() async {
    final response = await http.get(Uri.parse("$baseUrl/achievements"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Achievement.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load achievements");
    }
  }

  // Future<Event> fetchEventDetails(String eventId) async {
  //   final response = await http.get(Uri.parse("$baseUrl/events/$eventId"));
  //
  //   if (response.statusCode == 200) {
  //     return Event.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Failed to load event details");
  //   }
  // }
}
