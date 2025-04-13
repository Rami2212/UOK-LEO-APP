class User {
  final String id;
  final String name;
  final String role;
  final String avenue;
  final String dob;
  final String email;
  final String password;
  final String lastName;
  final String studentId;
  final String faculty;
  final String department;
  final String mobileNumber;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.avenue,
    required this.dob,
    required this.email,
    required this.password,
    required this.lastName,
    required this.studentId,
    required this.faculty,
    required this.department,
    required this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      avenue: json['avenue'],
      dob: json['dob'],
      email: json['email'],
      password: json['password'],
      lastName: json['lastName'],
      studentId: json['studentId'],
      faculty: json['faculty'],
      department: json['department'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'avenue': avenue,
      'dob': dob,
      'email': email,
      'password': password,
      'lastName': lastName,
      'studentId': studentId,
      'faculty': faculty,
      'department': department,
      'mobileNumber': mobileNumber,
    };
  }
}
