class BookDateRequest {
  final String eventName;
  final String avenue;
  final String organizer;
  final String phone;
  final String date;

  BookDateRequest({
    required this.eventName,
    required this.avenue,
    required this.organizer,
    required this.phone,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "eventName": eventName,
      "avenue": avenue,
      "organizer": organizer,
      "phone": phone,
      "date": date,
    };
  }
}
