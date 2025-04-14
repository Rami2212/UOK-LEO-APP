import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

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
    final Color primaryColor = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<Event>(
        future: _eventFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load event\n${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No event found"));
          }

          Event event = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    event.featuredImage,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.network('https://drive.google.com/uc?export=view&id=${event.featuredImage}', width: double.infinity, height: 250, fit: BoxFit.cover),
                    loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        event.name,
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Info Rows with Icons
                      infoRow(FontAwesomeIcons.calendar, "Date", event.date, primaryColor),
                      infoRow(FontAwesomeIcons.clock, "Time", event.time, primaryColor),
                      infoRow(FontAwesomeIcons.locationDot, "Venue", event.venue, primaryColor),
                      infoRow(FontAwesomeIcons.road, "Avenue", event.avenue, primaryColor),
                      infoRow(FontAwesomeIcons.phone, "Contact", event.contact, primaryColor),
                      const SizedBox(height: 20),

                      // Description
                      const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(event.description, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),

                      // Content
                      const Text("Content", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(event.content, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),

                      // Event Images
                      const Text("Event Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: event.images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  event.images[index],
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network('https://drive.google.com/uc?export=view&id=${event.images[index]}', width: 150, height: 150, fit: BoxFit.cover),
                                  loadingBuilder: (context, child, loadingProgress) =>
                                  loadingProgress == null
                                      ? child
                                      : const Center(child: CircularProgressIndicator()),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
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

  Widget infoRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
