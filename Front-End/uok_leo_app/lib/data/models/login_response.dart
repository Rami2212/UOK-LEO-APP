class LoginResponse {
  final String userID;
  final String email;
  final String role;
  final String name;
  final String token;

  LoginResponse({
    required this.userID,
    required this.email,
    required this.role,
    required this.name,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userID: json['userID'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      token: json['token'],
    );
  }
}
