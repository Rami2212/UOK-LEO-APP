import 'package:flutter/material.dart';
import 'package:uok_leo_app/screens/bookings/date_bookings_screen.dart';
import 'package:uok_leo_app/screens/profile/profile_screen.dart';
import 'package:uok_leo_app/screens/member/member_screen.dart';

class ProfileScreenAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),
            SizedBox(height: 10),
            Text("Admin Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("admin@example.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),

            // Manage Own Profile Button
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text("Manage My Profile"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),

            // Manage Other Users Button
            ElevatedButton.icon(
              icon: Icon(Icons.group),
              label: Text("Manage Users"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemberScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 10),

            // Manage Date Bookings Button
            ElevatedButton.icon(
              icon: Icon(Icons.calendar_month),
              label: Text("Manage Date Bookings"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DateBookingsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
