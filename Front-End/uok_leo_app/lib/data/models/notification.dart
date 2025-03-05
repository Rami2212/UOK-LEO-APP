class Notifications {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;
  final String? relatedEventId;

  Notifications({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    this.relatedEventId,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      relatedEventId: json['relatedEventId'],
    );
  }
}
