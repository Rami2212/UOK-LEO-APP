import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/achievement.dart';

class AchievementRepository {
  final String baseUrl = "http://localhost:3000/api";

  // Fetch all achievements
  Future<List<Achievement>> fetchAllAchievements() async {
    final response = await http.get(Uri.parse("$baseUrl/achievements"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Achievement.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load achievements");
    }
  }

  // Fetch details of a single achievement
  Future<Achievement> fetchAchievementDetails(String achievementId) async {
    final response = await http.get(Uri.parse("$baseUrl/achievements/$achievementId"));

    if (response.statusCode == 200) {
      return Achievement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load achievement details");
    }
  }

  // Add a new achievement
  Future<bool> addAchievement(Achievement achievement) async {
    final response = await http.post(
      Uri.parse("$baseUrl/achievements"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(achievement.toJson()),
    );

    return response.statusCode == 201;
  }

  // Update an existing achievement
  Future<bool> updateAchievement(Achievement achievement) async {
    final response = await http.put(
      Uri.parse("$baseUrl/achievements/${achievement.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(achievement.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete an achievement
  Future<bool> deleteAchievement(String achievementId) async {
    final response = await http.delete(Uri.parse("$baseUrl/achievements/$achievementId"));

    return response.statusCode == 200;
  }
}
