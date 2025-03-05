class Evaluation {
  final String id;
  final String name;
  final String description;
  final String content;
  final String featuredImage;
  final String month;

  Evaluation({
    required this.id,
    required this.name,
    required this.description,
    required this.content,
    required this.featuredImage,
    required this.month,
  });

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      content: json['content'],
      featuredImage: json['featuredImage'],
      month: json['month'],
    );
  }
}
