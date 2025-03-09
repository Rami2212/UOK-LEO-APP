import 'package:flutter/material.dart';
import '../../data/models/date_booking.dart';

class DateBookingCard extends StatelessWidget {
  final DateBooking booking;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  DateBookingCard({
    required this.booking,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.eventName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Date: ${booking.date}"),
            Text("Status: ${booking.status}", style: TextStyle(color: _getStatusColor(booking.status))),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (booking.status == "Pending") ...[
                  TextButton.icon(
                    onPressed: onApprove,
                    icon: Icon(Icons.check, color: Colors.green),
                    label: Text("Approve", style: TextStyle(color: Colors.green)),
                  ),
                  TextButton.icon(
                    onPressed: onReject,
                    icon: Icon(Icons.close, color: Colors.red),
                    label: Text("Reject", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
