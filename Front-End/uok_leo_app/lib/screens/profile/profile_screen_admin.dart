import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/screens/bookings/date_bookings_screen.dart';
import 'package:uok_leo_app/screens/profile/profile_screen.dart';
import 'package:uok_leo_app/screens/profile/edit_profile_screen.dart';
import 'package:uok_leo_app/screens/member/member_screen.dart';

import '../../widgets/widgets.dart';

class ProfileScreenAdmin extends StatefulWidget {
  @override
  State<ProfileScreenAdmin> createState() => _ProfileScreenAdminState();
}

class _ProfileScreenAdminState extends State<ProfileScreenAdmin> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
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
            SizedBox(height: 30),

            SizedBox(
              width: double.infinity, // Ensures the button takes up full width
              child: CustomButton(
                text: "View Profile",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
              ),
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity, // Ensures the button takes up full width
              child: CustomButton(
                text: "View Users",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MemberScreen())),
              ),
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "View Date Bookings",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DateBookingsScreen())),
              ),
            ),

            SizedBox(height: 10),

            // Uncomment if notification screen is ready
            // _buildButton(
            //   context,
            //   icon: Icons.notifications,
            //   label: "Send Notifications",
            //   color: Colors.purple,
            //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SendNotificationScreen())),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
