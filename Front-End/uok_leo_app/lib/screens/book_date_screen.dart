import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _eventNameController.text = "Sample Event";
    _venueController.text = "University Hall";
    _organizerController.text = "John Doe";
    _phoneController.text = "+94 712345678";
  }

  void _bookDate() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Date Booked Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Date")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Booking for: ${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: "Event Name"),
            ),
            TextField(
              controller: _venueController,
              decoration: InputDecoration(labelText: "Venue"),
            ),
            TextField(
              controller: _organizerController,
              decoration: InputDecoration(labelText: "Organizer Name"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookDate,
              child: Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
