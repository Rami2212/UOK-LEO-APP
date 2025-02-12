class LoginResponse {
  final String userId;
  final String token;
  final String name;
  final String email;
  final String role;

  LoginResponse({
    required this.userId,
    required this.token,
    required this.name,
    required this.email,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userId'],
      token: json['token'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
