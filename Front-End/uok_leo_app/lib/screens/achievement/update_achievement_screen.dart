import 'package:flutter/material.dart';
import '../../data/models/achievement.dart';
import '../../data/repositories/achievement_repository.dart';
import '../../widgets/widgets.dart';

class UpdateAchievementScreen extends StatefulWidget {
  final String achievementId;

  const UpdateAchievementScreen({required this.achievementId, super.key});

  @override
  State<UpdateAchievementScreen> createState() => _UpdateAchievementScreenState();
}

class _UpdateAchievementScreenState extends State<UpdateAchievementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final AchievementRepository _achievementRepository = AchievementRepository();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAchievementData();
  }

  void _loadAchievementData() async {
    try {
      Achievement achievement = await _achievementRepository.fetchAchievementDetails(widget.achievementId);
      setState(() {
        _nameController.text = achievement.name;
        _descriptionController.text = achievement.description;
        _contentController.text = achievement.content;
        _imageUrlController.text = achievement.featuredImage;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load achievement details")),
      );
      setState(() => _isLoading = false);
    }
  }

  void _updateAchievement() async {
    if (_formKey.currentState!.validate()) {
      Achievement updatedAchievement = Achievement(
        id: widget.achievementId,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        content: _contentController.text.trim(),
        featuredImage: _imageUrlController.text.trim(),
      );

      bool success = await _achievementRepository.updateAchievement(updatedAchievement);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Achievement updated successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update achievement")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Achievement")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Achievement Name"),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: "Image ID"),
                  validator: (value) => value!.isEmpty ? "Content is required" : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Update Achievement",
                    onPressed: _updateAchievement,
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
