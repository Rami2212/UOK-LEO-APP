import 'package:flutter/material.dart';
import '../screens/event_details_screen.dart';
import '../screens/event/update_event_screen.dart';
import '../data/repositories/event_repository.dart';

class EventCard extends StatelessWidget {
  final String eventId;
  final String imageUrl;
  final String title;
  final String date;
  final String description;
  final String userRole;
  final EventRepository eventRepository = EventRepository();

  EventCard({
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.description,
    required this.userRole,
  });

  void _deleteEvent(BuildContext context) async {
    bool success = await eventRepository.deleteEvent(eventId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event deleted successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete event")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(date, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                SizedBox(height: 5),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: eventId)),
                        );
                      },
                      child: Text("View Details", style: TextStyle(color: Colors.blue)),
                    ),
                    if (userRole == 'admin')
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateEventScreen(eventId: eventId),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEvent(context),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
