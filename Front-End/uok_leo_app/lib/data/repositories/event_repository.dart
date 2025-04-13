import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_date_request.dart';
import '../models/book_date_response.dart';
import '../models/event.dart';

class EventRepository {
  final String baseUrl = "http://localhost:3000/api";

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

  Future<List<Event>> fetchEventsByDate(String date) async {
    final response = await http.get(Uri.parse("$baseUrl/events?date=$date"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load events for the date $date");
    }
  }

  Future<bool> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse("$baseUrl/events"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );

    return response.statusCode == 201;
  }

  Future<bool> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse("$baseUrl/events/${event.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteEvent(String eventId) async {
    final response = await http.delete(Uri.parse("$baseUrl/events/$eventId"));

    return response.statusCode == 200;
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
