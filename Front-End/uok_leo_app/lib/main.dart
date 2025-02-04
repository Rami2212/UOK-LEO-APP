import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uok_leo_app/screens/home_screen.dart';
import 'package:uok_leo_app/screens/login_screen.dart';
import 'package:uok_leo_app/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'UOK LEO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            // Check if user is authenticated, if yes, navigate to HomeScreen
            return auth.isAuthenticated ? const HomeScreen() : const LoginScreen();
          },
        ),
        routes: AppRoutes.routes,
      ),
    );
  }
}
