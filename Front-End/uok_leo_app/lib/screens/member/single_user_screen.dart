import 'package:flutter/material.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user.dart';
import '../../widgets/widgets.dart';
import '../profile/edit_profile_screen.dart';

class SingleUserScreen extends StatefulWidget {
  final String userId;

  const SingleUserScreen({required this.userId});

  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  final UserRepository userRepository = UserRepository();
  late Future<User> _userFuture;

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
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete user")));
      }
    }
  }

  Widget _buildUserTile(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData) return Center(child: Text("User not found"));

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profileImage.isNotEmpty
                      ? NetworkImage(user.profileImage)
                      : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                ),
                SizedBox(height: 20),

                _buildUserTile(Icons.person, "Name", "${user.name} ${user.lastName}"),
                _buildUserTile(Icons.badge, "Student ID", user.studentId),
                _buildUserTile(Icons.school, "Faculty", user.faculty),
                _buildUserTile(Icons.computer, "Department", user.department),
                _buildUserTile(Icons.work, "Role", user.role),
                _buildUserTile(Icons.home, "Avenue", user.avenue),
                _buildUserTile(Icons.cake, "Date of Birth", user.dob),
                _buildUserTile(Icons.email, "Email", user.email),
                _buildUserTile(Icons.phone, "Mobile", user.mobileNumber),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity, // Ensures the button takes up full width
                  child: CustomButton(
                    text: "Update",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(user: user),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity, // Ensures the button takes up full width
                  child: CustomButton(
                    text: "Delete",
                    onPressed: () => _deleteUser(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
