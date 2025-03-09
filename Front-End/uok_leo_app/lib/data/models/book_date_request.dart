class BookDateRequest {
  final String eventName;
  final String venue;
  final String avenue;
  final String phone;
  final String date;

  BookDateRequest({
    required this.eventName,
    required this.venue,
    required this.avenue,
    required this.phone,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "eventName": eventName,
      "avenue": venue,
      "organizer": avenue,
      "phone": phone,
      "date": date,
    };
  }
}
