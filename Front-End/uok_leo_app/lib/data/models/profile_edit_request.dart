class ProfileEditRequest {
  final String name;
  final String lastName;
  final String email;
  final String studentId;
  final String faculty;
  final String department;
  final String avenue;
  final String mobileNumber;
  final String dob;

  ProfileEditRequest({
    required this.name,
    required this.lastName,
    required this.email,
    required this.studentId,
    required this.faculty,
    required this.department,
    required this.avenue,
    required this.mobileNumber,
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
      'dob': dob,
    };
  }
}
