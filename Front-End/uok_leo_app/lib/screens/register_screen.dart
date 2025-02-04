import 'package:flutter/material.dart';
import 'package:uok_leo_app/data/models/registration_request.dart';
import 'package:provider/provider.dart';
import 'package:uok_leo_app/providers/auth_provider.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _avenueController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  void _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final registrationRequest = RegistrationRequest(
      name: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      studentId: _studentIdController.text.trim(),
      faculty: _facultyController.text.trim(),
      department: _departmentController.text.trim(),
      avenue: _avenueController.text.trim(),
      mobileNumber: _mobileController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = true;
    });

    final success = await authProvider.register(registrationRequest);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Register',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomTextField(hintText: 'First Name', controller: _firstNameController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Last Name', controller: _lastNameController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Email', controller: _emailController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Student ID', controller: _studentIdController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Faculty', controller: _facultyController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Department', controller: _departmentController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Avenue', controller: _avenueController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Mobile Number', controller: _mobileController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Password', controller: _passwordController, isPassword: true),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Confirm Password', controller: _confirmPasswordController, isPassword: true),
            const SizedBox(height: 20),
            CustomButton(
              text: _isLoading ? "Registering..." : 'Register',
              onPressed: _isLoading ? null : _handleRegister,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to login
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
