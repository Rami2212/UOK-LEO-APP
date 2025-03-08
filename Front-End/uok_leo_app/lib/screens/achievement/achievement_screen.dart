import 'package:flutter/material.dart';
import 'package:uok_leo_app/widgets/achievement_card.dart';
import '../../data/models/achievement.dart';

class AchievementScreen extends StatelessWidget {
  final Future<List<Achievement>> achievementsFuture;

  AchievementScreen({required this.achievementsFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Achievement>>(
        future: achievementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load achievements"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No achievements found"));
          }

          List<Achievement> achievements = snapshot.data!;

          return ListView.builder(
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return AchievementCard(
                id: achievements[index].id,
                imageUrl: achievements[index].featuredImage,
                name: achievements[index].name,
                description: achievements[index].description,
              );
            },
          );
        },
      ),
    );
  }
}
