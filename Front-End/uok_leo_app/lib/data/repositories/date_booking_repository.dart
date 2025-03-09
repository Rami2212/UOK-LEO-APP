import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/date_booking.dart';

class DateBookingRepository {
  final String baseUrl = "https://your-api-url.com";

  Future<bool> bookDate(DateBooking booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/datebookings'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(booking.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<List<DateBooking>> getDateBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/datebookings'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => DateBooking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load date bookings');
    }
  }

  Future<bool> approveDateBooking(String bookingId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/datebookings/$bookingId/approve'),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }

  Future<bool> rejectDateBooking(String bookingId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/datebookings/$bookingId/reject'),
      headers: {"Content-Type": "application/json"},
    );
    return response.statusCode == 200;
  }
}
