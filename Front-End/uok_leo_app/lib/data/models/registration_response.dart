class RegistrationResponse {
  final String userId;
  final String token;

  RegistrationResponse({
    required this.userId,
    required this.token,
  });

  // Convert JSON response to RegistrationResponse model
  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      userId: json['userId'],
      token: json['token'],
    );
  }
}
