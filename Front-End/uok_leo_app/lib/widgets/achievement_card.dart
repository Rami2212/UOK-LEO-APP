import 'package:flutter/material.dart';
import '../screens/achievement/update_achievement_screen.dart';
import '../data/repositories/achievement_repository.dart';

class AchievementCard extends StatelessWidget {
  final String achievementId;
  final String imageUrl;
  final String name;
  final String description;
  final String userRole;
  final AchievementRepository achievementRepository = AchievementRepository();

  AchievementCard({
    required this.achievementId,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.userRole,
  });

  void _deleteAchievement(BuildContext context) async {
    bool success = await achievementRepository.deleteAchievement(achievementId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Achievement deleted successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete achievement")));
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
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (userRole == 'admin')
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateAchievementScreen(achievementId: achievementId),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteAchievement(context),
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
