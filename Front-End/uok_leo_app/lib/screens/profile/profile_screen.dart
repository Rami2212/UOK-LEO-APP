import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import 'edit_profile_screen.dart';
import '../login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _userProfile;
  final UserRepository _userRepository = UserRepository();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    if (_userId != null) {
      setState(() {
        _userProfile = _userRepository.getUserProfile(_userId!);
      });
    }
  }

  void _refreshProfile() {
    if (_userId != null) {
      setState(() {
        _userProfile = _userRepository.getUserProfile(_userId!);
      });
    }
  }

  void _deleteProfile() async {
    bool confirmDelete = await _showDeleteConfirmationDialog();
    if (!confirmDelete) return;

    if (_userId != null) {
      bool success = await _userRepository.deleteUserProfile(_userId!);
      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile deleted successfully")));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete profile")));
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Profile"),
        content: Text("Are you sure you want to delete your profile? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ??
        false;
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _userId == null
          ? Center(child: Text("No user ID found. Please log in again."))
          : FutureBuilder<User>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load profile"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("User not found"));
          }

          User user = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://ui-avatars.com/api/?name=${user.name}+${user.lastName}",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildInfo("Name", "${user.name} ${user.lastName}"),
                _buildInfo("Role", user.role),
                _buildInfo("Avenue", user.avenue),
                _buildInfo("DOB", user.dob),
                _buildInfo("Email", user.email),
                _buildInfo("Contact", user.mobileNumber),
                _buildInfo("Student ID", user.studentId),
                _buildInfo("Faculty", user.faculty),
                _buildInfo("Department", user.department),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(user: user),
                          ),
                        );
                        if (updated) _refreshProfile();
                      },
                      child: Text("Edit Profile"),
                    ),
                    ElevatedButton(
                      onPressed: _deleteProfile,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text("Delete Profile"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        "$title: $value",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
