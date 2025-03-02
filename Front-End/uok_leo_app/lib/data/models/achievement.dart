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

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      content: json['content'],
      featuredImage: json['featuredImage'],
    );
  }
}
