import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  late TextEditingController _facultyController;
  late TextEditingController _departmentController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _dobController;

  String? _selectedRole;
  String? _selectedAvenue;

  final List<String> _roles = ['Member', 'Director'];
  final List<String> _avenues = ['Education', 'Environment', 'Health', 'Peace'];

  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _studentIdController = TextEditingController(text: widget.user.studentId);
    _facultyController = TextEditingController(text: widget.user.faculty);
    _departmentController = TextEditingController(text: widget.user.department);
    _mobileNumberController = TextEditingController(text: widget.user.mobileNumber);
    _dobController = TextEditingController(text: widget.user.dob);
    _selectedRole = widget.user.role;
    _selectedAvenue = widget.user.avenue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _facultyController.dispose();
    _departmentController.dispose();
    _mobileNumberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.user.dob) ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      User updatedUser = User(
        id: widget.user.id,
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        studentId: _studentIdController.text.trim(),
        faculty: _facultyController.text.trim(),
        department: _departmentController.text.trim(),
        mobileNumber: _mobileNumberController.text.trim(),
        dob: _dobController.text.trim(),
        avenue: _selectedAvenue ?? '',
        role: _selectedRole ?? '',
        password: widget.user.password, // Keep existing password
      );

      bool success = await _userRepository.updateUserProfile(widget.user.id, updatedUser);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile Updated Successfully!")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(labelText: "Student ID"),
              ),
              TextFormField(
                controller: _facultyController,
                decoration: const InputDecoration(labelText: "Faculty"),
              ),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: "Department"),
              ),
              TextFormField(
                controller: _mobileNumberController,
                decoration: const InputDecoration(labelText: "Mobile Number"),
              ),
              GestureDetector(
                onTap: _pickDob,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(labelText: "Date of Birth"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedAvenue,
                decoration: const InputDecoration(labelText: "Avenue"),
                items: _avenues.map((avenue) {
                  return DropdownMenuItem<String>(
                    value: avenue,
                    child: Text(avenue),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedAvenue = val),
              ),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: "Role"),
                items: _roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
