import 'package:flutter/material.dart';
import '../screens/evaluation/update_evaluation_screen.dart';
import '../data/repositories/evaluation_repository.dart';

class EvaluationCard extends StatelessWidget {
  final String evaluationId;
  final String imageUrl;
  final String name;
  final String description;
  final String month;
  final String userRole;
  final EvaluationRepository evaluationRepository = EvaluationRepository();

  EvaluationCard({
    required this.evaluationId,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.month,
    required this.userRole,
  });

  void _deleteEvaluation(BuildContext context) async {
    bool success = await evaluationRepository.deleteEvaluation(evaluationId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Evaluation deleted successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to delete evaluation")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(month, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                SizedBox(height: 5),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (userRole == 'admin')
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateEvaluationScreen(evaluationId: evaluationId),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEvaluation(context),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
