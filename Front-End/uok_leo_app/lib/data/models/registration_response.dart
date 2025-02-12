class RegistrationResponse {
  final String userId;
  final String token;
  final String role;

  RegistrationResponse({
    required this.userId,
    required this.token,
    required this.role,
  });

  // Convert JSON response to RegistrationResponse model
  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      userId: json['userId'],
      token: json['token'],
      role: json['role'],
    );
  }
}
