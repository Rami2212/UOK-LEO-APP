import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          "Calendar Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
