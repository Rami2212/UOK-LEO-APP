import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/member.dart';

class MemberRepository {
  final String baseUrl = "http://localhost:3000/api";

  Future<List<Member>> fetchAllMembers() async {
    final response = await http.get(Uri.parse("$baseUrl/members"));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load members");
    }
  }

  Future<bool> addMember(Member member) async {
    final response = await http.post(
      Uri.parse("$baseUrl/members"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(member.toJson()),
    );

    return response.statusCode == 201;
  }

  Future<bool> updateMember(Member member) async {
    final response = await http.put(
      Uri.parse("$baseUrl/members/${member.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(member.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteMember(String memberId) async {
    final response = await http.delete(Uri.parse("$baseUrl/members/$memberId"));

    return response.statusCode == 200;
  }
}
