import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_date_request.dart';
import '../models/book_date_response.dart';
import '../models/event.dart';

class EventRepository {
  final String baseUrl = "https://example.com/api";

  Future<List<Event>> fetchAllEvents() async {
    final response = await http.get(Uri.parse("$baseUrl/events"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  Future<Event> fetchEventDetails(String eventId) async {
    final response = await http.get(Uri.parse("$baseUrl/events/$eventId"));

    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load event details");
    }
  }

  Future<BookDateResponse> bookEvent(BookDateRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/bookEvent"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return BookDateResponse.fromJson(jsonDecode(response.body));
    } else {
      return BookDateResponse(success: false, message: "Failed to book event");
    }
  }
}
