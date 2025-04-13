import 'package:flutter/material.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user.dart';

class SingleUserScreen extends StatefulWidget {
  final String userId;

  const SingleUserScreen({required this.userId});

  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  final UserRepository userRepository = UserRepository();
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = userRepository.getUserProfile(widget.userId);
  }

  void _deleteUser(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      bool success = await userRepository.deleteUserProfile(widget.userId);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User deleted")));
        Navigator.pop(context); // Back to previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete user")));
      }
    }
  }

  Widget _buildUserDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data == null) return Center(child: Text("User not found"));

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.profileImage.isNotEmpty
                        ? NetworkImage(user.profileImage)
                        : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  ),
                  SizedBox(height: 16),

                  _buildUserDetail("Name", user.name),
                  _buildUserDetail("Last Name", user.lastName),
                  _buildUserDetail("Student ID", user.studentId),
                  _buildUserDetail("Faculty", user.faculty),
                  _buildUserDetail("Department", user.department),
                  _buildUserDetail("Role", user.role),
                  _buildUserDetail("Avenue", user.avenue),
                  _buildUserDetail("Date of Birth", user.dob),
                  _buildUserDetail("Email", user.email),
                  _buildUserDetail("Mobile", user.mobileNumber),

                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _deleteUser(context),
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text("Delete User"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
