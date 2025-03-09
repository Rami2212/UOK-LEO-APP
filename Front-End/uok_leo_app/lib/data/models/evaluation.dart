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

// Factory method to create an Evaluation from JSON
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

// toJson method to convert the Evaluation object back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'content': content,
      'featuredImage': featuredImage,
      'month': month,
    };
  }
}
