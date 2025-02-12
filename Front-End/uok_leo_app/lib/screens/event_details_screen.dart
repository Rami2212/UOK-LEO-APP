import 'package:flutter/material.dart';
import '../data/models/event.dart';
import '../data/repositories/event_repository.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  EventDetailsScreen({required this.eventId});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Future<Event> _eventFuture;
  final EventRepository _eventRepository = EventRepository();

  @override
  void initState() {
    super.initState();
    _eventFuture = _eventRepository.fetchEventDetails(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event Details")),
      body: FutureBuilder<Event>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load event"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No event found"));
          }

          Event event = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Image
                Image.network(event.featuredImage, fit: BoxFit.cover, width: double.infinity, height: 250),

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("📅 Date: ${event.date}", style: TextStyle(fontSize: 16)),
                      Text("🕒 Time: ${event.time}", style: TextStyle(fontSize: 16)),
                      Text("📍 Venue: ${event.venue}", style: TextStyle(fontSize: 16)),
                      Text("📞 Contact: ${event.contact}", style: TextStyle(fontSize: 16, color: Colors.blue)),
                      SizedBox(height: 20),

                      // Additional Images
                      Text("Event Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: event.images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(event.images[index], width: 150, height: 150, fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
