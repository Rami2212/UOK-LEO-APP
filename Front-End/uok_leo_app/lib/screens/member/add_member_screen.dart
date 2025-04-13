import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
import '../../widgets/widgets.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String _selectedRole = 'Member';
  String _selectedAvenue = 'Default';

  final List<String> roles = ['Member', 'Director', 'Admin'];
  final List<String> avenues = ['Default', 'Leadership', 'Service', 'Fundraising', 'Fellowship'];

  Future<void> _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _saveMember() async {
    if (_formKey.currentState!.validate()) {
      User newMember = User(
        id: "", // ID will be auto-generated usually
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        faculty: _facultyController.text.trim(),
        department: _departmentController.text.trim(),
        role: _selectedRole,
        avenue: _selectedAvenue,
        dob: _dobController.text,
        email: _emailController.text.trim(),
        password: _passwordController.text,
        mobileNumber: _contactController.text.trim(),
        profileImage: "", // Skipping image upload for now
      );

      bool success = await userRepository.addUser(newMember);
      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _studentIdController.dispose();
    _facultyController.dispose();
    _departmentController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Member")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                CustomTextField(hintText: "First Name", controller: _nameController),
                SizedBox(height: 12),

                CustomTextField(hintText: "Last Name", controller: _lastNameController),
                SizedBox(height: 12),

                CustomTextField(hintText: "Student ID", controller: _studentIdController),
                SizedBox(height: 12),

                CustomTextField(hintText: "Faculty", controller: _facultyController),
                SizedBox(height: 12),

                CustomTextField(hintText: "Department", controller: _departmentController),
                SizedBox(height: 12),

                CustomDropdown(
                  hintText: "Role",
                  value: _selectedRole,
                  items: roles,
                  onChanged: (val) => setState(() => _selectedRole = val!),
                ),
                SizedBox(height: 12),

                CustomDropdown(
                  hintText: "Avenue",
                  value: _selectedAvenue,
                  items: avenues,
                  onChanged: (val) => setState(() => _selectedAvenue = val!),
                ),
                SizedBox(height: 12),

                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () => _selectDOB(context),
                  validator: (value) =>
                  value!.isEmpty ? "Please select date of birth" : null,
                ),
                SizedBox(height: 12),

                CustomTextField(
                  hintText: "Email",
                  controller: _emailController,
                ),
                SizedBox(height: 12),

                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 12),

                CustomTextField(
                  hintText: "Mobile Number",
                  controller: _contactController,
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Submit",
                    onPressed: _saveMember,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
