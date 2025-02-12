class BookDateResponse {
  final bool success;
  final String message;

  BookDateResponse({required this.success, required this.message});

  factory BookDateResponse.fromJson(Map<String, dynamic> json) {
    return BookDateResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
