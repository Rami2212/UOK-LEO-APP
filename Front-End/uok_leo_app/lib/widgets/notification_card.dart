import 'package:flutter/material.dart';
import '../data/models/notification.dart';
import '../screens/event/event_details_screen.dart';

class NotificationCard extends StatelessWidget {
  final Notifications notification;
  final String userRole; // Pass 'Admin' or 'Member'
  final void Function(String id)? onDelete; // Call delete by ID

  NotificationCard({
    required this.notification,
    required this.userRole,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row: Title + Time + Delete Icon (for Admin)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      notification.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        notification.time,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      if (userRole == 'Admin' && onDelete != null)
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => onDelete!(notification.id),
                          tooltip: "Delete Notification",
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 6),

              /// Date
              Text(
                notification.date,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 6),

              /// Description
              Text(
                notification.description,
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
