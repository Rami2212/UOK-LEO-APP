import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Registration Details Text
            const Text(
              'Register',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // First Name Input
            const CustomTextField(hintText: 'First Name'),
            const SizedBox(height: 10),

            // Last Name Input
            const CustomTextField(hintText: 'Last Name'),
            const SizedBox(height: 10),

            // Email Input
            const CustomTextField(hintText: 'Email'),
            const SizedBox(height: 10),

            // Student ID Input
            const CustomTextField(hintText: 'Student ID'),
            const SizedBox(height: 10),

            // Faculty Input
            const CustomTextField(hintText: 'Faculty'),
            const SizedBox(height: 10),

            // Department Input
            const CustomTextField(hintText: 'Department'),
            const SizedBox(height: 10),

            // Avenue Input
            const CustomTextField(hintText: 'Avenue'),
            const SizedBox(height: 10),

            // Mobile Number Input
            const CustomTextField(hintText: 'Mobile Number'),
            const SizedBox(height: 10),

            // Password Input
            const CustomTextField(hintText: 'Password', isPassword: true),
            const SizedBox(height: 10),

            // Confirm Password Input
            const CustomTextField(hintText: 'Confirm Password', isPassword: true),
            const SizedBox(height: 20),

            // Register Button
            CustomButton(
              text: 'Register',
              onPressed: () {
                // Add registration functionality
              },
            ),
            const SizedBox(height: 10),

            // Already Have an Account? Login Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
