import 'package:flutter/material.dart';
import '../../data/models/achievement.dart';
import '../../data/repositories/achievement_repository.dart';
import '../../widgets/widgets.dart';

class AddAchievementScreen extends StatefulWidget {
  const AddAchievementScreen({super.key});

  @override
  State<AddAchievementScreen> createState() => _AddAchievementScreenState();
}

class _AddAchievementScreenState extends State<AddAchievementScreen> {
  final _formKey = GlobalKey<FormState>();
  final AchievementRepository _achievementRepository = AchievementRepository();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _featuredImageController = TextEditingController();

  Future<void> _submitAchievement() async {
    if (_formKey.currentState!.validate()) {
      Achievement achievement = Achievement(
        id: '',
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        content: _contentController.text.trim(),
        featuredImage: _featuredImageController.text.trim(),
      );

      bool success = await _achievementRepository.addAchievement(achievement);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? 'Achievement added successfully' : 'Failed to add achievement'),
      ));

      if (success) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    _featuredImageController.dispose();
    super.dispose();
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        int maxLines = 1,
        bool isImageField = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (val) => val!.isEmpty ? 'Enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: isImageField
              ? GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('How to get Google Drive image link'),
                  content: const Text(
                    '1. Open your image in Google Drive.\n'
                        '2. Right-click > Get link.\n'
                        '3. Set to "Anyone with the link".\n'
                        '4. Click "Copy link".\n'
                        '5. Paste the link here.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            child: const Tooltip(
              message: "Tap for Google Drive image link instructions",
              child: Icon(Icons.info_outline),
            ),
          )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Achievement")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, "Name"),
              _buildTextField(_descriptionController, "Description", maxLines: 2),
              _buildTextField(_contentController, "Content", maxLines: 5),
              _buildTextField(_featuredImageController, "Featured Image URL", isImageField: true),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Submit",
                  onPressed: _submitAchievement,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
