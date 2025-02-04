import 'package:flutter/material.dart';

class EvaluationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evaluation"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          "Evaluation Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
