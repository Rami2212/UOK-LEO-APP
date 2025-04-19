import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widgets.dart';
import '../data/repositories/auth_repository.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository(); // <-- Create instance
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar("Please fill in all fields");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      _showSnackBar("User not found");
      setState(() => _isLoading = false);
      return;
    }

    final result = await _authRepository.changeUserPassword(
      userId: userId,
      newPassword: password,
    );

    if (result['success'] == true) {
      _showSnackBar("Password changed successfully!");
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showSnackBar(result['message']);
    }

    setState(() => _isLoading = false);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _passwordController,
              hintText: 'New Password',
              isPassword: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              isPassword: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Ensures the button takes up full width
              child: CustomButton(
                text: _isLoading ? "Updating..." : "Reset Password",
                onPressed: _isLoading ? null : _resetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
