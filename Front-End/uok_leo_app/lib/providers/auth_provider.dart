import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/login_request.dart';
import '../data/models/login_response.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _token;
  bool _isAuthenticated = false;
  final AuthRepository _authRepository = AuthRepository();

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  AuthProvider() {
    _loadAuthData();
  }

  // Load authentication data from SharedPreferences
  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _token = prefs.getString('token');
    _isAuthenticated = _userId != null;
    notifyListeners();
  }

  // Login Function
  Future<bool> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    LoginResponse? response = await _authRepository.login(request);

    if (response != null) {
      _userId = response.userId;
      _token = response.token;
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      await prefs.setString('token', _token!);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout Function
  Future<void> logout() async {
    _userId = null;
    _token = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('token');
    notifyListeners();
  }
}
