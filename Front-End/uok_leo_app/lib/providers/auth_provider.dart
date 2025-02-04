import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  AuthProvider() {
    _loadAuthData();
  }

  // Load authentication data from SharedPreferences
  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('userId');
    if (storedUserId != null) {
      _userId = storedUserId;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  // Simulate login
  Future<void> login(String userId) async {
    _userId = userId;
    _isAuthenticated = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);  // Save userId
    notifyListeners();
  }

  // Simulate logout
  Future<void> logout() async {
    _userId = null;
    _isAuthenticated = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');  // Remove userId from storage
    notifyListeners();
  }
}
