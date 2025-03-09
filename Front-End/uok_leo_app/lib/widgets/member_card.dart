import 'package:flutter/material.dart';
import '../data/models/member.dart';
import '../screens/member/view_member_screen.dart';
import '../data/repositories/member_repository.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback onDelete;
  final MemberRepository memberRepository = MemberRepository();

  MemberCard({required this.member, required this.onDelete});

  void _deleteMember(BuildContext context) async {
    bool success = await memberRepository.deleteMember(member.id);
    if (success) {
      onDelete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Member deleted successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete member")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(member.profileImage)),
        title: Text(member.name),
        subtitle: Text("${member.role} - ${member.avenue}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.visibility, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewMemberScreen(member: member)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteMember(context),
            ),
          ],
        ),
      ),
    );
  }
}
