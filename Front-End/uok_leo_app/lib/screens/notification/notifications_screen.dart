import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/repositories/notification_repository.dart';
import '../../data/models/notification.dart';
import '../../widgets/notification_card.dart';
import '../event/add_event_screen.dart';
import 'add_notification_screen.dart';

class NotificationScreen extends StatefulWidget {
  final Future<List<Notifications>> notificationsFuture;

  const NotificationScreen({Key? key, required this.notificationsFuture}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  final NotificationRepository _notificationRepository = NotificationRepository();

  Future<void> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role') ?? 'Member';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: FutureBuilder<List<Notifications>>(
        future: widget.notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("No notifications available"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No notifications available"));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(
                notification: notifications[index],
                userRole: userRole, // 'Admin' or 'Member'
                onDelete: (id) {
                  // Your delete function here
                  _notificationRepository.deleteNotification(id);
                },
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
            MaterialPageRoute(builder: (context) => AddNotificationScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
      )
          : null,
    );
  }
}
