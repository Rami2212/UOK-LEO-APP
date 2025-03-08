import 'package:flutter/material.dart';
import '../../data/models/member.dart';
import '../../data/repositories/member_repository.dart';

class ViewMemberScreen extends StatefulWidget {
  final Member member;

  ViewMemberScreen({required this.member});

  @override
  _ViewMemberScreenState createState() => _ViewMemberScreenState();
}

class _ViewMemberScreenState extends State<ViewMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _avenueController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _contactController;
  final MemberRepository memberRepository = MemberRepository();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member.name);
    _roleController = TextEditingController(text: widget.member.role);
    _avenueController = TextEditingController(text: widget.member.avenue);
    _dobController = TextEditingController(text: widget.member.dob);
    _emailController = TextEditingController(text: widget.member.email);
    _contactController = TextEditingController(text: widget.member.contact);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _avenueController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _updateMember() async {
    if (_formKey.currentState!.validate()) {
      Member updatedMember = Member(
        id: widget.member.id,
        name: _nameController.text,
        role: _roleController.text,
        avenue: _avenueController.text,
        dob: _dobController.text,
        email: _emailController.text,
        contact: _contactController.text,
        profileImage: widget.member.profileImage, // Keep existing profile image
      );

      bool success = await memberRepository.updateMember(updatedMember);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Member updated successfully")));
        Navigator.pop(context, true); // Returning `true` to refresh the member list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update member")));
      }
    }
  }

  void _deleteMember() async {
    bool success = await memberRepository.deleteMember(widget.member.id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Member deleted successfully")));
      Navigator.pop(context, true); // Returning `true` to refresh the member list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete member")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Member")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.member.profileImage),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(labelText: "Role"),
              ),
              TextFormField(
                controller: _avenueController,
                decoration: InputDecoration(labelText: "Avenue"),
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: "Date of Birth"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Enter email" : null,
              ),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: "Contact"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _updateMember,
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    onPressed: _deleteMember,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
