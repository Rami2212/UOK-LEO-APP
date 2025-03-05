import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evaluation.dart';

class EvaluationRepository {
  final String baseUrl = "https://example.com/api";

  Future<List<Evaluation>> fetchAllEvaluations() async {
    final response = await http.get(Uri.parse("$baseUrl/evaluations"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Evaluation.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load evaluations");
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
