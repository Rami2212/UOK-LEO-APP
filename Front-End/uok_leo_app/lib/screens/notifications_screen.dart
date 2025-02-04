import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          "Notifications Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
