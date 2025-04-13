import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventRepository {
  final String baseUrl = "http://10.0.2.2:3000/api/v1";

  // Fetch all events
  Future<List<Event>> fetchAllEvents() async {
    final response = await http.get(Uri.parse("$baseUrl/events"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['events']['data'];  // Adjust to handle nested data
      List<Event> events = List<Event>.from(data.map((item) => Event.fromJson(item)));
      return events;
    } else {
      throw Exception("Failed to load events");
    }
  }


  // Fetch details of a single event
  Future<Event> fetchEventDetails(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$eventId'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded['success'] == true &&
          decoded['event'] != null &&
          decoded['event']['data'] != null &&
          decoded['event']['data'] is List &&
          decoded['event']['data'].isNotEmpty) {
        return Event.fromJson(decoded['event']['data'][0]);
      } else {
        throw Exception('Event data is missing or empty');
      }
    } else {
      throw Exception('Failed to load event details: $eventId\n${response.body}');
    }
  }

  // Fetch events by date
  Future<List<Event>> fetchEventsByDate(String date) async {
    final response = await http.get(Uri.parse("$baseUrl/events/date/$date"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['events']['data'];
      return jsonList.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load events for the date $date");
    }
  }


  // Fetch events by user ID
  Future<bool> addEvent(Event event) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/events/save"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(event.toJson()),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error submitting event: $e");
      return false;
    }
  }

  // Update an existing event
  Future<bool> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse("$baseUrl/events/${event.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete an event
  Future<bool> deleteEvent(String eventId) async {
    final response = await http.delete(Uri.parse("$baseUrl/events/$eventId"));

    return response.statusCode == 200;
  }

}
