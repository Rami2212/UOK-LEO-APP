import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/profile_screen.dart';
import 'package:uok_leo_app/data/repositories/evaluation_repository.dart';
import 'package:uok_leo_app/data/repositories/event_repository.dart';
import 'package:uok_leo_app/screens/achievement_screen.dart';
import 'package:uok_leo_app/screens/evaluation_screen.dart';
import 'package:uok_leo_app/screens/notifications_screen.dart';
import '../data/models/achievement.dart';
import '../data/models/evaluation.dart';
import '../data/models/event.dart';
import '../data/repositories/achievement_repository.dart';
import '../screens/calendar_screen.dart';
import '../screens/event_screen.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool? _isDirector;
  late Future<List<Event>> _eventsFuture;
  late Future<List<Achievement>> _achievementsFuture;
  late Future<List<Evaluation>> _evaluationsFuture;
  final EventRepository _eventRepository = EventRepository();
  final AchievementRepository _achievementsRepository = AchievementRepository();
  final EvaluationRepository _evaluationRepository = EvaluationRepository();


  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _eventsFuture = _eventRepository.fetchAllEvents();
    _achievementsFuture = _achievementsRepository.fetchAllAchievements();
    _evaluationsFuture = _evaluationRepository.fetchAllEvaluations();
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
      EventScreen(eventsFuture: _eventsFuture),
      AchievementScreen(achievementsFuture: _achievementsFuture),
      EvaluationScreen(evaluationFuture: _evaluationsFuture),
      CalendarPage(isDirector: true),
      NotificationScreen(),
      ProfileScreen(),
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
