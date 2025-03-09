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
    setState(() {
      _userId = prefs.getString('userId');
      if (_userId != null) {
        _userProfile = _userRepository.getUserProfile(_userId!);
      }
    });
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
        await prefs.clear(); // Clear stored user data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
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

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                ),
                SizedBox(height: 20),
                Text("Name: ${user.name}", style: TextStyle(fontSize: 18)),
                Text("Role: ${user.role}", style: TextStyle(fontSize: 18)),
                Text("Avenue: ${user.avenue}", style: TextStyle(fontSize: 18)),
                Text("DOB: ${user.dob}", style: TextStyle(fontSize: 18)),
                Text("Email: ${user.email}", style: TextStyle(fontSize: 18)),
                Text("Contact: ${user.contact}", style: TextStyle(fontSize: 18)),
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
}
