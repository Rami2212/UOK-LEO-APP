import 'package:flutter/material.dart';
import 'package:uok_leo_app/data/models/event.dart';
import 'package:uok_leo_app/widgets/event_card.dart';

class EventScreen extends StatelessWidget {
  final Future<List<Event>> eventsFuture;

  EventScreen({required this.eventsFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Event>>(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load events"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No events found"));
          }

          List<Event> events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(
                eventId: events[index].id,
                imageUrl: events[index].featuredImage,
                title: events[index].name,
                date: events[index].date,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", // Placeholder
              );
            },
          );
        },
      ),
    );
  }
}
