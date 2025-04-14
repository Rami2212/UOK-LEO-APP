import 'package:flutter/material.dart';
import '../../data/models/evaluation.dart';
import '../../data/repositories/evaluation_repository.dart';
import '../../widgets/widgets.dart';

class UpdateEvaluationScreen extends StatefulWidget {
  final String evaluationId;

  UpdateEvaluationScreen({required this.evaluationId});

  @override
  _UpdateEvaluationScreenState createState() => _UpdateEvaluationScreenState();
}

class _UpdateEvaluationScreenState extends State<UpdateEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _monthController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final EvaluationRepository _evaluationRepository = EvaluationRepository();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEvaluationData();
  }

  // Fetch evaluation details and prefill form
  void _loadEvaluationData() async {
    try {
      Evaluation evaluation = await _evaluationRepository.fetchEvaluationDetails(widget.evaluationId);
      setState(() {
        _nameController.text = evaluation.name;
        _descriptionController.text = evaluation.description;
        _contentController.text = evaluation.content;
        _monthController.text = evaluation.month;
        _imageUrlController.text = evaluation.featuredImage;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load evaluation details")));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateEvaluation() async {
    if (_formKey.currentState!.validate()) {
      Evaluation updatedEvaluation = Evaluation(
        id: widget.evaluationId,
        name: _nameController.text,
        description: _descriptionController.text,
        content: _contentController.text,
        featuredImage: _imageUrlController.text,
        month: _monthController.text,
      );

      bool success = await _evaluationRepository.updateEvaluation(updatedEvaluation);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Evaluation updated successfully")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update evaluation")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Evaluation")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Evaluation Name"),
                  validator: (value) => value!.isEmpty ? "Name is required" : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) => value!.isEmpty ? "Description is required" : null,
                ),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(labelText: "Content"),
                  validator: (value) => value!.isEmpty ? "Content is required" : null,
                ),
                TextFormField(
                  controller: _monthController,
                  decoration: InputDecoration(labelText: "Month"),
                  validator: (value) => value!.isEmpty ? "Month is required" : null,
                ),
                SizedBox(height: 10),

                // Image URL Input
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: "Image ID"),
                  validator: (value) => value!.isEmpty ? "Month is required" : null,
                ),

                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Update Evaluation',
                    onPressed: _updateEvaluation,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
