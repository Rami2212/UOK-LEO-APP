import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uok_leo_app/providers/auth_provider.dart';
import 'package:uok_leo_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'UOK LEO APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: AppRoutes.routes, // Navigation routes
      ),
    );
  }
}
