import 'package:flutter/material.dart';
import '../../data/repositories/member_repository.dart';
import '../../data/models/member.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final MemberRepository memberRepository = MemberRepository();
  final TextEditingController _nameController = TextEditingController();

  void _saveMember() async {
    if (_formKey.currentState!.validate()) {
      Member newMember = Member(
        id: "0",
        name: _nameController.text,
        role: "Member",
        avenue: "Default",
        dob: "2000-01-01",
        email: "example@example.com",
        contact: "123456789",
        profileImage: "https://example.com/default.png",
      );

      bool success = await memberRepository.addMember(newMember);
      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Member")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveMember, child: Text("Add Member")),
            ],
          ),
        ),
      ),
    );
  }
}
