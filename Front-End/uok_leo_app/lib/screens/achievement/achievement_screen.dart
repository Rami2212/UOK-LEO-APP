import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/achievement.dart';
import 'package:uok_leo_app/widgets/achievement_card.dart';  // You can create an AchievementCard widget similarly to the EventCard
import 'package:uok_leo_app/screens/achievement/add_achievement_screen.dart';

class AchievementScreen extends StatefulWidget {
  final Future<List<Achievement>> achievementsFuture;

  AchievementScreen({required this.achievementsFuture});

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
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
        title: Text("Achievements", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Achievement>>(
        future: widget.achievementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load achievements"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No achievements found"));
          }

          List<Achievement> achievements = snapshot.data!;

          final reversedAchievements = achievements.reversed.toList();

          return ListView.builder(
            itemCount: reversedAchievements.length,
            itemBuilder: (context, index) {
              final achievement = reversedAchievements[index];
              return AchievementCard(
                achievementId: achievement.id,
                name: achievement.name,
                description: achievement.description,
                imageUrl: achievement.featuredImage,
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
            MaterialPageRoute(builder: (context) => AddAchievementScreen()),
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
