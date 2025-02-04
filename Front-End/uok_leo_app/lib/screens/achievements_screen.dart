import 'package:flutter/material.dart';

class AchivementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achivements"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          "Achivements Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
