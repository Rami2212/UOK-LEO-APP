class RegistrationResponse {
  final String message; // Success or error message
  final String userId;  // User ID if needed
  final String token;  // Token if needed

  RegistrationResponse({
    required this.message,
    required this.userId,
    required this.token,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      message: json['message'],
      userId: json['userId'],
      token: json['token'],
    );
  }
}
