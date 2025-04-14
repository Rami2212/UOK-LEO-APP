import 'package:flutter/material.dart';
import '../data/models/date_booking.dart';

class DateBookingCard extends StatelessWidget {
  final DateBooking booking;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const DateBookingCard({
    required this.booking,
    required this.onApprove,
    required this.onReject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPending = booking.status.toLowerCase() == 'pending';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.eventName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(children: [Icon(Icons.place, size: 18), SizedBox(width: 6), Text("Venue: ${booking.venue}")]),
            Row(children: [Icon(Icons.calendar_today, size: 18), SizedBox(width: 6), Text("Date: ${booking.date.split("T")[0]}")]),
            Row(children: [Icon(Icons.access_time, size: 18), SizedBox(width: 6), Text("Time: ${booking.time}")]),
            Row(children: [Icon(Icons.location_city, size: 18), SizedBox(width: 6), Text("Avenue: ${booking.avenue}")]),
            Row(
              children: [
                Icon(Icons.info_outline, size: 18),
                SizedBox(width: 6),
                Text(
                  "Status: ${booking.status}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: booking.status.toLowerCase() == 'pending'
                        ? Colors.orange
                        : booking.status.toLowerCase() == 'confirmed'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            if (isPending) ...[
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onApprove,
                      icon: Icon(Icons.check),
                      label: Text("Approve"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onReject,
                      icon: Icon(Icons.close),
                      label: Text("Reject"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
