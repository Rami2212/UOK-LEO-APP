class Event {
  final String id;
  final String name;
  final String date;
  final String time;
  final String venue;
  final String avenue;
  final String description;
  final String content;
  final String contact;
  final String featuredImage;
  final List<String> images;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.venue,
    required this.avenue,
    required this.description,
    required this.content,
    required this.contact,
    required this.featuredImage,
    required this.images,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      time: json['time'],
      venue: json['venue'],
      avenue: json['avenue'],
      description: json['description'],
      content: json['content'],
      contact: json['contact'],
      featuredImage: json['featuredImage'],
      images: List<String>.from(json['images']),
    );
  }
}
