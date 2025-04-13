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

  // Factory method with null safety and default fallbacks
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      featuredImage: json['featuredImage']?.toString() ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'content': content,
      'featuredImage': featuredImage,
    };
  }
}
