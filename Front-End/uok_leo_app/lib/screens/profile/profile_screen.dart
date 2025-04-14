import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../widgets/widgets.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;
  final UserRepository userRepository = UserRepository();
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
      print(userId);
      if (userId != null) {
        _userFuture = userRepository.getUserProfile(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // clear all saved data (or just remove userId if needed)

              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),

      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData)
            return Center(child: Text("User not found"));

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: user.profileImage.isNotEmpty
                //       ? NetworkImage(user.profileImage)
                //       : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                // ),
                // SizedBox(height: 20),

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
                    text: "Edit Profile",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>
                            EditProfileScreen(user: user)),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
}
