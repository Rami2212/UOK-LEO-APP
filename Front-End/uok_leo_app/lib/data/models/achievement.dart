class Achievement {
  final String id;
  final String name;
  final String description;
  final String content;
  final String featuredImage;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.content,
    required this.featuredImage,
  });

// Factory method to create an Achievements from JSON
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      content: json['content'],
      featuredImage: json['featuredImage'],
    );
  }

// toJson method to convert the Achievements object back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'content': content,
      'featuredImage': featuredImage,
    };
  }
}
