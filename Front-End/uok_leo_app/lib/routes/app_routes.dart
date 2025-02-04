import 'package:flutter/material.dart';
import 'package:uok_leo_app/screens/login_screen.dart';
import 'package:uok_leo_app/screens/register_screen.dart';
import 'package:uok_leo_app/screens/home_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => HomeScreen(),
  };
}
