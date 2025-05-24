import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widgets.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;
  String? _actualOtp;
  String? _userId;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadOtpAndUserId();
  }

  Future<void> _loadOtpAndUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _actualOtp = prefs.getString('otp');
      _userId = prefs.getString('userId');
      _email = prefs.getString('email');
    });
  }

  void _verifyOtp() {
    final enteredOtp = _otpController.text.trim();

    if (enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the OTP")),
      );
      return;
    }

    if (_actualOtp == null || _userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing OTP or User ID")),
      );
      return;
    }

    setState(() => _isVerifying = true);

    if (enteredOtp == _actualOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email verified successfully!")),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect OTP")),
      );
    }

    setState(() => _isVerifying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter the 6-digit code sent to your email: $_email',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _otpController,
              hintText: 'Enter the 6-digit code',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                  text: _isVerifying ? "Verifying..." : 'Verify',
                  onPressed: _isVerifying ? null : _verifyOtp,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
