import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  final bool isDirector;
  final bool isAdmin;

  CalendarPage({required this.isDirector, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: CalendarWidget(isDirector: isDirector, isAdmin: isAdmin,),
    );
  }
}
