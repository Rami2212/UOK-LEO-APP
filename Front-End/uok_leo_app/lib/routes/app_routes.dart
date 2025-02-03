import 'package:flutter/material.dart';
import 'package:uok_leo_app/screens/home_screen.dart';
import 'package:uok_leo_app/screens/login_screen.dart';
import 'package:uok_leo_app/screens/profile_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const HomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/profile': (context) => const ProfileScreen(),
  };
}
