class Notifications {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String? relatedEventId;

  Notifications({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.relatedEventId,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      relatedEventId: json['relatedEventId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'relatedEventId': relatedEventId,
    };
  }
}
