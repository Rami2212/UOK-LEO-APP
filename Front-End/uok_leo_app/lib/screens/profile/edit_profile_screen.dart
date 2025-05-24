import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/profile_edit_request.dart';

import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();

  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _studentIdController;
  late TextEditingController _facultyController;
  late TextEditingController _departmentController;
  late TextEditingController _avenueController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _mobileNumberController;

  final List<String> _avenues = ['Education & Literacy',
    'Environment Conservation',
    'Healthcare',
    'Clean Water & Energy Conservation'

  ];

  final List<String> _faculties = ['Science',
    'Commerce & Management Studies',
    'Computing & Technology',
    'Social Sciences',
    'Humanities',
    'Medicine'
  ];

  DateTime? _selectedDob;
  String? _selectedAvenue;
  String? _selectedFaculty;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Initialize the controllers with existing user data
    _nameController = TextEditingController(text: widget.user.name);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _studentIdController = TextEditingController(text: widget.user.studentId);
    _facultyController = TextEditingController(text: widget.user.faculty);
    _departmentController = TextEditingController(text: widget.user.department);
    _avenueController = TextEditingController(text: widget.user.avenue);
    _emailController = TextEditingController(text: widget.user.email);
    _mobileNumberController = TextEditingController(text: widget.user.mobileNumber);

    // Initialize dob controller and selectedDob with null checks
    if (widget.user.dob != null && widget.user.dob.isNotEmpty) {
      try {
        _dobController = TextEditingController(text: widget.user.dob);
        _selectedDob = DateFormat('dd MMM yyyy').parse(widget.user.dob);
      } catch (e) {
        // Handle any exception related to incorrect date format
        print("Error parsing date: $e");
        _dobController = TextEditingController(text: ""); // Default to empty if invalid date format
        _selectedDob = null;
      }
    } else {
      _dobController = TextEditingController(text: ""); // Default empty value if dob is empty
      _selectedDob = null; // Set selectedDob to null if no dob available
    }

    setState(() {
      _isLoading = false;
    });
  }



  void _pickDob() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDob = picked;
        _dobController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      ProfileEditRequest updatedUser = ProfileEditRequest(
        name: _nameController.text,
        lastName: _lastNameController.text,
        studentId: _studentIdController.text,
        faculty: _facultyController.text,
        department: _departmentController.text,
        avenue: _avenueController.text,
        dob: _dobController.text,
        email: _emailController.text,
        mobileNumber: _mobileNumberController.text,
      );

      bool success = await userRepository.updateUserProfile(widget.user.id, updatedUser);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
        Navigator.pop(context, updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update profile")));
      }
    }
  }

  void _deleteProfile() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this profile?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      bool success = await userRepository.deleteUserProfile(widget.user.id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile deleted")));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete profile")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("First Name",),
              CustomTextField(controller: _nameController, hintText: "First Name"),
              SizedBox(height: 10,),
              Text("First Name",),
              CustomTextField(controller: _lastNameController, hintText: "Last Name"),
              SizedBox(height: 10,),
              Text("Student ID",),
              CustomTextField(
                controller: _studentIdController,
                hintText: "Student ID",
              ),
              SizedBox(height: 10,),
              Text("Faculty",),
              CustomDropdown(
                hintText: 'Select Faculty',
                items: _faculties,
                value: _selectedFaculty,
                onChanged: (val) => setState(() => _selectedFaculty = val),
              ),
              SizedBox(height: 10,),
              Text("Department",),
              CustomTextField(controller: _departmentController, hintText: "Department"),
              SizedBox(height: 10,),
              Text("Avenue",),
              CustomDropdown(
                hintText: 'Select Avenue',
                items: _avenues,
                value: _selectedAvenue,
                onChanged: (val) => setState(() => _selectedAvenue = val),
              ),
              SizedBox(height: 10,),
              Text("Date of Birth",),
              GestureDetector(
                onTap: _pickDob,
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _dobController,
                    hintText: "Date of Birth",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Email",),
              CustomTextField(controller: _emailController, hintText: "Email"),
              SizedBox(height: 10,),
              Text("Mobile Number",),
              CustomTextField(controller: _mobileNumberController, hintText: "Mobile Number"),
              SizedBox(height: 10,),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Save",
                  onPressed: _saveProfile,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Delete",
                  onPressed: _deleteProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
