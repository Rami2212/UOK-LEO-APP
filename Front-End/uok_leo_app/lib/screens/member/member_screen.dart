import 'package:flutter/material.dart';
import '../../data/repositories/member_repository.dart';
import '../../data/models/member.dart';
import '../../widgets/member_card.dart';
import 'add_member_screen.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final MemberRepository memberRepository = MemberRepository();
  late Future<List<Member>> _membersFuture;

  @override
  void initState() {
    super.initState();
    _membersFuture = memberRepository.fetchAllMembers();
  }

  void _refreshMembers() {
    setState(() {
      _membersFuture = memberRepository.fetchAllMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Members")),
      body: FutureBuilder<List<Member>>(
        future: _membersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load members"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No members found"));
          }

          List<Member> members = snapshot.data!;

          return ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              return MemberCard(
                member: members[index],
                onDelete: _refreshMembers,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMemberScreen()),
          ).then((_) => _refreshMembers());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
