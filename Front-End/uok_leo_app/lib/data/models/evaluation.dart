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

  // Factory method with null-safety and type casting
  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      featuredImage: json['featuredImage']?.toString() ?? '',
      month: json['month']?.toString() ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'content': content,
      'featuredImage': featuredImage,
      'month': month,
    };
  }
}
