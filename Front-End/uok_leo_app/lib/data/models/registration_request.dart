class RegistrationRequest {
  final String name;
  final String lastName;
  final String email;
  final String studentId;
  final String faculty;
  final String department;
  final String avenue;
  final String mobileNumber;
  final String password;
  final String role;
  final String dob;

  RegistrationRequest({
    required this.name,
    required this.lastName,
    required this.email,
    required this.studentId,
    required this.faculty,
    required this.department,
    required this.avenue,
    required this.mobileNumber,
    required this.password,
    required this.role,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'studentId': studentId,
      'faculty': faculty,
      'department': department,
      'avenue': avenue,
      'mobileNumber': mobileNumber,
      'password': password,
      'role': role,
      'dob': dob,
    };
  }
}
