import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  // Simulate login
  void login(String userId) {
    _userId = userId;
    _isAuthenticated = true;
    notifyListeners();
  }

  // Simulate logout
  void logout() {
    _userId = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
