import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uok_leo_app/data/models/evaluation.dart';
import 'package:uok_leo_app/widgets/evaluation_card.dart';  // You can create an EvaluationCard widget similarly to the EventCard
import 'package:uok_leo_app/screens/evaluation/add_evaluation_screen.dart';

class EvaluationScreen extends StatefulWidget {
  final Future<List<Evaluation>> evaluationsFuture;

  EvaluationScreen({required this.evaluationsFuture});

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role') ?? 'Member';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluations", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Evaluation>>(
        future: widget.evaluationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load evaluations"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No evaluations found"));
          }

          List<Evaluation> evaluations = snapshot.data!;

          final reversedEvaluations = evaluations.reversed.toList();

          return ListView.builder(
            itemCount: reversedEvaluations.length,
            itemBuilder: (context, index) {
              final evaluation = reversedEvaluations[index];
              return EvaluationCard(
                evaluationId: evaluation.id,
                imageUrl: evaluation.featuredImage,
                name: evaluation.name,
                description: evaluation.description,
                month: evaluation.month,
                userRole: userRole,
              );
            },
          );

        },
      ),
      floatingActionButton: userRole == 'Admin'
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEvaluationScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      )
          : null,
    );
  }
}
