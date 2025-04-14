import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/notification.dart';
import '../../data/repositories/notification_repository.dart';
import '../../widgets/widgets.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({super.key});

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final NotificationRepository _notificationRepository = NotificationRepository();

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final time = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      _timeController.text = DateFormat('hh:mm a').format(time);
    }
  }

  Future<void> _submitNotification() async {
    if (_formKey.currentState!.validate()) {
      final notification = Notifications(
        id: '',
        title: _titleController.text,
        date: _dateController.text,
        time: _timeController.text,
        description: _descriptionController.text,
      );

      final success = await _notificationRepository.addNotification(notification);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? "Notification added successfully" : "Failed to add notification"),
      ));
      if (success) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        int maxLines = 1,
        VoidCallback? onTap,
        bool readOnly = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        validator: (val) => val!.isEmpty ? 'Enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notification")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_titleController, "Title"),
              _buildTextField(_dateController, "Date", onTap: _pickDate, readOnly: true),
              _buildTextField(_timeController, "Time", onTap: _pickTime, readOnly: true),
              _buildTextField(_descriptionController, "Description", maxLines: 2),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Submit",
                  onPressed: _submitNotification,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
