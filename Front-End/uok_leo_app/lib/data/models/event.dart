class Event {
  String id;
  String name;
  String date;
  String time;
  String venue;
  String avenue;
  String description;
  String content;
  String contact;
  String featuredImage;
  List<String> images;

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
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      venue: json['venue']?.toString() ?? '',
      avenue: json['avenue']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      contact: json['contact']?.toString() ?? '',
      featuredImage: json['featuredImage']?.toString() ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date,
      'time': time,
      'venue': venue,
      'avenue': avenue,
      'description': description,
      'content': content,
      'contact': contact,
      'featuredImage': featuredImage,
      'images': images,
    };
  }
}
