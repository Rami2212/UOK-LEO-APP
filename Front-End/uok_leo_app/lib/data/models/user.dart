class User {
  final String id;
  final String name;
  final String role;
  final String avenue;
  final String dob;
  final String email;
  final String contact;
  final String profileImage;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.avenue,
    required this.dob,
    required this.email,
    required this.contact,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      avenue: json['avenue'],
      dob: json['dob'],
      email: json['email'],
      contact: json['contact'],
      profileImage: json['profileImage'],
    );
  }
}
