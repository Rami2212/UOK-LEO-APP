class DateBooking {
  final String id;
  final String userId;
  final String eventName;
  final String venue;
  final String date;
  final String time;
  final String avenue;
  final String status;

  DateBooking({
    required this.id,
    required this.userId,
    required this.eventName,
    required this.venue,
    required this.date,
    required this.time,
    required this.avenue,
    required this.status,
  });

  factory DateBooking.fromJson(Map<String, dynamic> json) {
    return DateBooking(
      id: json['id'],
      userId: json['userId'],
      eventName: json['eventName'],
      venue: json['venue'],
      date: json['date'],
      time: json['time'],
      avenue: json['avenue'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'eventName': eventName,
      'venue': venue,
      'date': date,
      'time': time,
      'avenue': avenue,
      'status': status,
    };
  }
}
