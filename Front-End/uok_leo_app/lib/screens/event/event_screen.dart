import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/event.dart';
import 'package:uok_leo_app/widgets/event_card.dart';
import 'package:uok_leo_app/screens/event/add_event_screen.dart';

class EventScreen extends StatefulWidget {
  final Future<List<Event>> eventsFuture;

  EventScreen({required this.eventsFuture});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role') ?? 'Member';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'UOK LEO CLUB',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/logo.png', // make sure this path is correct
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: widget.eventsFuture,
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
              final event = events.reversed.toList()[index]; // Reverse the list
              return EventCard(
                eventId: event.id,
                imageUrl: event.featuredImage,
                title: event.name,
                date: event.date,
                description: event.description,
                userRole: userRole,
              );
            },
          );


        },
      ),
      floatingActionButton: userRole == 'Admin'
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      )
          : null,
    );
  }
}
