import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/date_booking.dart';

class DateBookingRepository {
  final String baseUrl = "http://10.0.2.2:3000/api/v1";

  // Private method to get token
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Add a new date booking
  Future<bool> bookDate(DateBooking booking) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/dateBooking/save'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(booking.toJson()),
    );
    return response.statusCode == 200;
  }

  // Get all date bookings
  Future<List<DateBooking>> getDateBookings() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/dateBooking'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded['success'] == true &&
          decoded['bookings'] != null &&
          decoded['bookings']['data'] != null) {
        List<dynamic> jsonList = decoded['bookings']['data'];
        return jsonList.map((json) => DateBooking.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load date bookings');
    }
  }

  // Get a single date booking
  Future<DateBooking> getSingleDateBooking(String bookingId) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/dateBooking/$bookingId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == true && decoded['booking'] != null) {
        return DateBooking.fromJson(decoded['booking']);
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load date booking');
    }
  }

  // Approve a date booking
  Future<bool> approveDateBooking(String bookingId) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/dateBooking/$bookingId/confirmed'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return response.statusCode == 200;
  }

  // Reject a date booking
  Future<bool> rejectDateBooking(String bookingId) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/dateBooking/$bookingId/rejected'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    return response.statusCode == 200;
  }
}
