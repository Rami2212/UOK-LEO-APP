import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evaluation.dart';

class EvaluationRepository {
  final String baseUrl = "http://10.0.2.2:3000/api/v1";

  // Fetch all evaluations
  Future<List<Evaluation>> fetchAllEvaluations() async {
    final response = await http.get(Uri.parse("$baseUrl/evaluations"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Evaluation.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load evaluations");
    }
  }

  // Fetch details of a single evaluation
  Future<Evaluation> fetchEvaluationDetails(String evaluationId) async {
    final response = await http.get(Uri.parse("$baseUrl/evaluations/$evaluationId"));

    if (response.statusCode == 200) {
      return Evaluation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load evaluation details");
    }
  }

  // Add a new evaluation
  Future<bool> addEvaluation(Evaluation evaluation) async {
    final response = await http.post(
      Uri.parse("$baseUrl/evaluations"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(evaluation.toJson()),
    );

    return response.statusCode == 201;
  }

  // Update an existing evaluation
  Future<bool> updateEvaluation(Evaluation evaluation) async {
    final response = await http.put(
      Uri.parse("$baseUrl/evaluations/${evaluation.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(evaluation.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete an evaluation
  Future<bool> deleteEvaluation(String evaluationId) async {
    final response = await http.delete(Uri.parse("$baseUrl/evaluations/$evaluationId"));

    return response.statusCode == 200;
  }
}
