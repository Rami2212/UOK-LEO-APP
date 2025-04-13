import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uok_leo_app/data/models/registration_request.dart';
import 'package:uok_leo_app/providers/auth_provider.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final List<String> _roles = ['Member', 'Director', 'Admin'];
  final List<String> _avenues = ['Education', 'Environment', 'Health', 'Peace'];
  final List<String> _faculties = ['Science', 'Arts', 'Commerce', 'Management'];

  String? _selectedRole;
  String? _selectedAvenue;
  String? _selectedFaculty;
  DateTime? _selectedDob;
  bool _isLoading = false;

  void _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDob = picked;
      });
    }
  }

  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final request = RegistrationRequest(
      name: _nameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      studentId: _studentIdController.text.trim(),
      faculty: _selectedFaculty ?? '',
      department: _departmentController.text.trim(),
      avenue: _selectedAvenue ?? '',
      mobileNumber: _mobileNumberController.text.trim(),
      password: _passwordController.text.trim(),
      role: _selectedRole ?? 'Member',
      dob: _selectedDob != null ? DateFormat('yyyy-MM-dd').format(_selectedDob!) : '',
    );

    setState(() => _isLoading = true);
    final success = await authProvider.register(request);
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            CustomTextField(hintText: 'First Name', controller: _nameController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Last Name', controller: _lastNameController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Email', controller: _emailController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Student ID', controller: _studentIdController),
            const SizedBox(height: 10),
            CustomDropdown(
              hintText: 'Select Faculty',
              items: _faculties,
              value: _selectedFaculty,
              onChanged: (val) => setState(() => _selectedFaculty = val),
            ),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Department', controller: _departmentController),
            const SizedBox(height: 10),
            CustomDropdown(
              hintText: 'Select Avenue',
              items: _avenues,
              value: _selectedAvenue,
              onChanged: (val) => setState(() => _selectedAvenue = val),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickDob,
              child: AbsorbPointer(
                child: CustomTextField(
                  hintText: 'Date of Birth',
                  controller: TextEditingController(
                    text: _selectedDob != null
                        ? DateFormat('dd MMM yyyy').format(_selectedDob!)
                        : '',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Mobile Number', controller: _mobileNumberController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Password', controller: _passwordController, isPassword: true),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Confirm Password', controller: _confirmPasswordController, isPassword: true),
            const SizedBox(height: 10),
            CustomDropdown(
              hintText: 'Select Role',
              items: _roles,
              value: _selectedRole,
              onChanged: (val) => setState(() => _selectedRole = val),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Ensures the button takes up full width
              child: CustomButton(
                text: _isLoading ? "Registering..." : "Register",
                onPressed: _isLoading ? null : _handleRegister,
              ),
            ),

            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
