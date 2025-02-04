import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Login Illustration (Replace with an actual image if needed)
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
            const SizedBox(height: 20),

            // Login Details Text
            const Text(
              'Login',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Username/Email Input
            const CustomTextField(hintText: 'Username, email & phone number'),
            const SizedBox(height: 10),

            // Password Input
            const CustomTextField(hintText: 'Password', isPassword: true),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 10),

            // Login Button
            CustomButton(
              text: 'Login',
              onPressed: () {
                // Add login functionality
              },
            ),
            const SizedBox(height: 10),

            // Sign Up Button
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                // Navigate to the RegisterScreen using the route defined in AppRoutes
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
