import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/login_request.dart';
import 'package:uok_leo_app/data/models/registration_request.dart';
import 'package:uok_leo_app/data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _token;
  String? _role;
  String? _otp;
  bool _isAuthenticated = false;
  final AuthRepository _authRepository = AuthRepository();

  bool get isAuthenticated => _isAuthenticated;

  String? get userId => _userId;

  String? get role => _role;

  String? get otp => _otp;

  AuthProvider() {
    _loadAuthData();
  }

  // Load authentication data from SharedPreferences
  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _token = prefs.getString('token');
    _role = prefs.getString('role');
    _otp = prefs.getString('otp');
    _isAuthenticated = _userId != null;
    notifyListeners();
  }

  // Login Function
  Future<bool> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    final response = await _authRepository.login(request);

    if (response != null && response['success'] == true) {
      _userId = response['userID'];
      _token = response['token'];
      _role = response['role'];
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      await prefs.setString('token', _token!);
      await prefs.setString('role', _role!);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout Function
  Future<void> logout() async {
    _userId = null;
    _token = null;
    _role = null;
    _otp = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('token');
    await prefs.remove('role');
    notifyListeners();
  }

  // Register Function
  Future<Map<String, dynamic>?> register(
      RegistrationRequest registrationRequest, String email) async {
    final response = await _authRepository.register(registrationRequest, email);

    if (response != null && response['success'] == true) {
      _userId = response['userID'];
      _token = response['token'];
      _role = response['role'];
      _otp = response['otp'];
      _isAuthenticated = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      await prefs.setString('token', _token!);
      await prefs.setString('role', _role!);
      await prefs.setString('otp', _otp!);
      notifyListeners();

      return response; // Contains userID, otp, etc.
    }

    return null;
  }

}
