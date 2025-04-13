import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/achievement.dart';

class AchievementRepository {
  final String baseUrl = "http://10.0.2.2:3000/api/v1";

  // Fetch all achievements
  Future<List<Achievement>> fetchAllAchievements() async {
    final response = await http.get(Uri.parse("$baseUrl/achivements"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['achivements']['data'];
      return List<Achievement>.from(data.map((item) => Achievement.fromJson(item)));
    } else {
      throw Exception("Failed to load achievements");
    }
  }

  // Fetch details of a single achievement
  Future<Achievement> fetchAchievementDetails(String achievementId) async {
    final response = await http.get(Uri.parse('$baseUrl/achivements/$achievementId'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded['success'] == true &&
          decoded['achivement'] != null &&
          decoded['achivement']['data'] != null &&
          decoded['achivement']['data'] is List &&
          decoded['achivement']['data'].isNotEmpty) {
        return Achievement.fromJson(decoded['achivement']['data'][0]);
      } else {
        throw Exception('Achievement data is missing or empty');
      }
    } else {
      throw Exception('Failed to load achievement details: $achievementId\n${response.body}');
    }
  }

  // Add a new achievement
  Future<bool> addAchievement(Achievement achievement) async {
    final response = await http.post(
      Uri.parse("$baseUrl/achivements/save"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(achievement.toJson()),
    );

    print(jsonEncode(achievement.toJson()));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success'] == true &&
          json['achivement'] != null &&
          json['achivement']['success'] == true) {
        return true;
      }
    }

    return false;
  }


  // Update an existing achievement
  Future<bool> updateAchievement(Achievement achievement) async {
    final response = await http.put(
      Uri.parse("$baseUrl/achivements/${achievement.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(achievement.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete an achievement
  Future<bool> deleteAchievement(String achievementId) async {
    final response = await http.delete(Uri.parse("$baseUrl/achivements/$achievementId"));

    return response.statusCode == 200;
  }
}
