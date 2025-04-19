import 'package:flutter/material.dart';
import '../../data/repositories/date_booking_repository.dart';
import '../../data/models/date_booking.dart';
import '../../widgets/date_booking_card.dart';

class DateBookingsScreen extends StatefulWidget {
  @override
  _DateBookingsScreenState createState() => _DateBookingsScreenState();
}

class _DateBookingsScreenState extends State<DateBookingsScreen> {
  final DateBookingRepository _repository = DateBookingRepository();
  late Future<List<DateBooking>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = _repository.getDateBookings();
  }

  void _refreshBookings() {
    setState(() {
      _bookingsFuture = _repository.getDateBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Date Bookings")),
      body: FutureBuilder<List<DateBooking>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load bookings"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No bookings found"));
          }

          List<DateBooking> bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final reversedBookings = bookings.reversed.toList();
              return DateBookingCard(
                booking: reversedBookings[index],
                onApprove: () async {
                  bool success = await _repository.approveDateBooking(reversedBookings[index].id);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Booking approved")));
                    _refreshBookings();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to approve")));
                  }
                },
                onReject: () async {
                  bool success = await _repository.rejectDateBooking(reversedBookings[index].id);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Booking rejected")));
                    _refreshBookings();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to reject")));
                  }
                },
              );
            },
          );

        },
      ),
    );
  }
}
