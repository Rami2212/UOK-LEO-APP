import 'package:flutter/material.dart';
import '../data/models/user.dart';
import '../screens/member/single_user_screen.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleUserScreen(userId: user.id),
                  ),
                );
              },
              child: Text("View", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        subtitle: Text("Student Number: ${user.studentId}"),
      ),
    );
  }
}
