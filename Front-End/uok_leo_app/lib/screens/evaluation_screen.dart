import 'package:flutter/material.dart';
import 'package:uok_leo_app/widgets/evaluation_card.dart';
import '../data/models/evaluation.dart';

class EvaluationScreen extends StatelessWidget {
  final Future<List<Evaluation>> evaluationFuture;

  EvaluationScreen({required this.evaluationFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluations", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Evaluation>>(
        future: evaluationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load evaluations"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No evaluations found"));
          }

          List<Evaluation> evaluations = snapshot.data!;

          return ListView.builder(
            itemCount: evaluations.length,
            itemBuilder: (context, index) {
              return EvaluationCard(
                id: evaluations[index].id,
                imageUrl: evaluations[index].featuredImage,
                name: evaluations[index].name,
                description: evaluations[index].description,
                month: evaluations[index].month,
              );
            },
          );
        },
      ),
    );
  }
}
