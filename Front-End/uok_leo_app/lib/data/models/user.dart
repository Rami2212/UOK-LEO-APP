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
  final String profileImage;

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
    this.profileImage = '',
  });

  User copyWith({
    String? id,
    String? name,
    String? lastName,
    String? studentId,
    String? faculty,
    String? department,
    String? role,
    String? avenue,
    String? dob,
    String? email,
    String? mobileNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      studentId: studentId ?? this.studentId,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
      role: role ?? this.role,
      avenue: avenue ?? this.avenue,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      password: password,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'].toString() ?? '',
      name: json['name'].toString() ?? '',
      role: json['role'].toString() ?? '',
      avenue: json['avenue'].toString() ?? '',
      dob: json['dob'].toString() ?? '',
      email: json['email'].toString() ?? '',
      password: json['password'].toString() ?? '',
      lastName: json['lastName'].toString() ?? '',
      studentId: json['studentId'].toString() ?? '',
      faculty: json['faculty'].toString() ?? '',
      department: json['department'].toString() ?? '',
      mobileNumber: json['mobileNumber'].toString() ?? '',
      profileImage: json['profileImage'] ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'profileImage': profileImage,
    };
  }
}
