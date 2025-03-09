import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/date_booking.dart';
import '../../data/repositories/date_booking_repository.dart';

class DateBookingFormScreen extends StatefulWidget {
  final DateTime selectedDate;

  DateBookingFormScreen({required this.selectedDate});

  @override
  _DateBookingFormScreenState createState() => _DateBookingFormScreenState();
}

class _DateBookingFormScreenState extends State<DateBookingFormScreen> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _avenueController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final DateBookingRepository _dateBookingRepository = DateBookingRepository();
  String? _userId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
    });
  }

  Future<void> _bookDate() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User ID not found. Please log in again.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final booking = DateBooking(
      id: '', // Will be assigned by the backend
      userId: _userId!,
      eventName: _eventNameController.text,
      venue: _venueController.text,
      date: widget.selectedDate.toIso8601String(),
      time: _timeController.text,
      avenue: _avenueController.text,
      status: 'pending',
    );

    try {
      bool success = await _dateBookingRepository.bookDate(booking);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking request submitted successfully!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to book date. Please try again!")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Date"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking for: ${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: "Event Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _venueController,
              decoration: InputDecoration(labelText: "Venue", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _avenueController,
              decoration: InputDecoration(labelText: "Avenue", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: "Time", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _bookDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Confirm Booking", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
