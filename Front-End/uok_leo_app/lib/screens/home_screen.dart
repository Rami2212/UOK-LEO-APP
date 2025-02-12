import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/repositories/event_repository.dart';
import '../data/models/event.dart';
import '../screens/calendar_screen.dart';
import '../screens/home_screen_content.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool? _isDirector;
  late Future<List<Event>> _eventsFuture;
  final EventRepository _eventRepository = EventRepository();

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _eventsFuture = _eventRepository.fetchAllEvents(); // Fetch all events
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDirector = prefs.getString('role') == 'director';
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isDirector == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Widget> _pages = [
      HomeScreenContent(eventsFuture: _eventsFuture),
      Center(child: Text("Achievements Page")),
      Center(child: Text("Evaluation Page")),
      CalendarPage(isDirector: true),
      Center(child: Text("Notifications Page")),
      Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
