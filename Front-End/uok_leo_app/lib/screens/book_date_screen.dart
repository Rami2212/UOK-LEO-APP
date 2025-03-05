import 'package:flutter/material.dart';
import '../data/models/book_date_request.dart';
import '../data/repositories/event_repository.dart';

class BookDateScreen extends StatefulWidget {
  final DateTime selectedDate;

  BookDateScreen({required this.selectedDate});

  @override
  _BookDateScreenState createState() => _BookDateScreenState();
}

class _BookDateScreenState extends State<BookDateScreen> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _organizerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final EventRepository _eventRepository = EventRepository();
  bool _isLoading = false;

  Future<void> _bookDate() async {
    setState(() {
      _isLoading = true;
    });

    final request = BookDateRequest(
      eventName: _eventNameController.text,
      avenue: _venueController.text,
      organizer: _organizerController.text,
      phone: _phoneController.text,
      date: "${widget.selectedDate.toLocal()}".split(' ')[0],
    );

    try {
      final response = await _eventRepository.bookEvent(request);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message)),
      );
      if (response.success) {
        Navigator.pop(context);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to book date. Please try again!")),
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
              controller: _organizerController,
              decoration: InputDecoration(labelText: "Organizer Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
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