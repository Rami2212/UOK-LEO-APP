import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/evaluation.dart';

class EvaluationRepository {
  final String baseUrl = "https://leo-production-4c2e.up.railway.app/api/v1";

  // Private method to get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch all evaluations
  Future<List<Evaluation>> fetchAllEvaluations() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/evaluations"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded['success'] == true &&
          decoded['evaluations'] != null &&
          decoded['evaluations']['data'] is List) {
        List<dynamic> dataList = decoded['evaluations']['data'];
        return dataList.map((e) => Evaluation.fromJson(e)).toList();
      } else {
        throw Exception("Evaluation data is missing or invalid");
      }
    } else {
      throw Exception("Failed to load evaluations");
    }
  }

  // Fetch details of a single evaluation
  Future<Evaluation> fetchEvaluationDetails(String evaluationId) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/evaluations/$evaluationId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded['success'] == true &&
          decoded['evaluation'] != null &&
          decoded['evaluation']['data'] != null) {
        return Evaluation.fromJson(decoded['evaluation']['data']);
      } else {
        throw Exception('Evaluation data is missing or empty');
      }
    } else {
      throw Exception('Failed to load evaluation details: $evaluationId\n${response.body}');
    }
  }

  // Add a new evaluation
  Future<bool> addEvaluation(Evaluation evaluation) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/evaluations/save"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(evaluation.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // Update an existing evaluation
  Future<bool> updateEvaluation(Evaluation evaluation) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse("$baseUrl/evaluations/${evaluation.id}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(evaluation.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete an evaluation
  Future<bool> deleteEvaluation(String evaluationId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/evaluations/$evaluationId"),
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }
}
