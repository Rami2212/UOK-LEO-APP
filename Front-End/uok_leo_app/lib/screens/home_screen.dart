import 'package:flutter/material.dart';
import '../widgets/project_card.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of screens
  final List<Widget> _pages = [
    HomeScreenContent(),
    Center(child: Text("Achievements Page")),
    Center(child: Text("Evaluation Page")),
    Center(child: Text("Calendar Page")),
    Center(child: Text("Notifications Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {"image": "https://source.unsplash.com/300x200/?interior", "title": "Event", "date": "Date"},
    {"image": "https://source.unsplash.com/300x200/?architecture", "title": "Event", "date": "Date"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(
              imageUrl: projects[index]["image"]!,
              title: projects[index]["title"]!,
              date: projects[index]["date"]!,
            );
          },
        ),
      ),
    );
  }
}
