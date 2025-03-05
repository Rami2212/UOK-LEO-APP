import 'package:flutter/material.dart';
import '../data/models/user.dart';
import '../data/repositories/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _avenueController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  late TextEditingController _profileImageController;

  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _roleController = TextEditingController(text: widget.user.role);
    _avenueController = TextEditingController(text: widget.user.avenue);
    _dobController = TextEditingController(text: widget.user.dob);
    _emailController = TextEditingController(text: widget.user.email);
    _contactController = TextEditingController(text: widget.user.contact);
    _profileImageController = TextEditingController(text: widget.user.profileImage);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _avenueController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _profileImageController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      User updatedUser = User(
        id: widget.user.id,
        name: _nameController.text,
        role: _roleController.text,
        avenue: _avenueController.text,
        dob: _dobController.text,
        email: _emailController.text,
        contact: _contactController.text,
        profileImage: _profileImageController.text,
      );

      bool success = await _userRepository.updateUserProfile(updatedUser);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile Updated Successfully!")),
        );
        Navigator.pop(context, true); // Return true to indicate successful update
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
              TextFormField(controller: _roleController, decoration: InputDecoration(labelText: "Role")),
              TextFormField(controller: _avenueController, decoration: InputDecoration(labelText: "Avenue")),
              TextFormField(controller: _dobController, decoration: InputDecoration(labelText: "DOB")),
              TextFormField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
              TextFormField(controller: _contactController, decoration: InputDecoration(labelText: "Contact")),
              TextFormField(controller: _profileImageController, decoration: InputDecoration(labelText: "Profile Image URL")),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
