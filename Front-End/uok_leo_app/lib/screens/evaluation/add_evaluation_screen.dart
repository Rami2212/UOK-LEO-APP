import 'package:flutter/material.dart';
import '../../data/models/evaluation.dart';
import '../../data/repositories/evaluation_repository.dart';
import '../../widgets/widgets.dart';

class AddEvaluationScreen extends StatefulWidget {
  const AddEvaluationScreen({Key? key}) : super(key: key);

  @override
  State<AddEvaluationScreen> createState() => _AddEvaluationScreenState();
}

class _AddEvaluationScreenState extends State<AddEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageController = TextEditingController();
  final _monthController = TextEditingController();

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String? _selectedMonth;

  Future<void> _submitEvaluation() async {
    if (_formKey.currentState!.validate()) {
      final newEvaluation = Evaluation(
        id: '',
        name: _nameController.text,
        description: _descriptionController.text,
        content: _contentController.text,
        featuredImage: _imageController.text,
        month: _selectedMonth ?? '',
      );

      final success = await EvaluationRepository().addEvaluation(newEvaluation);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? "Evaluation added successfully" : "Failed to add evaluation"),
      ));

      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Evaluation")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Evaluation Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter evaluation name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter content' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Featured Image URL",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
              ),
              const SizedBox(height: 16),

              // Month Selection using CustomDropdown
              CustomDropdown(
                hintText: "Select Month",
                items: _months,
                value: _selectedMonth,
                onChanged: (String? newMonth) {
                  setState(() {
                    _selectedMonth = newMonth;
                  });
                },
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Submit",
                  onPressed: _submitEvaluation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
