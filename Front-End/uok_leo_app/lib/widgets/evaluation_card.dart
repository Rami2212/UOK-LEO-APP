import 'package:flutter/material.dart';

class EvaluationCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final String month;

  EvaluationCard({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.month,
  });

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
