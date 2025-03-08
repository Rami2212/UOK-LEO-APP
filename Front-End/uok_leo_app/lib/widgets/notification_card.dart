import 'package:flutter/material.dart';
import '../data/models/notification.dart';
import '../screens/event/event_details_screen.dart';

class NotificationCard extends StatelessWidget {
  final Notifications notification;

  NotificationCard({required this.notification});

  void _handleTap(BuildContext context) {
    if (notification.relatedEventId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsScreen(eventId: notification.relatedEventId!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(notification.date, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            SizedBox(height: 5),
            Text(notification.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _handleTap(context),
                child: Text(
                  notification.relatedEventId != null ? "View Details" : "",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
