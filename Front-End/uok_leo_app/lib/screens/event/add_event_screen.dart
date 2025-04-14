import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';
import '../../widgets/widgets.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final EventRepository _eventRepository = EventRepository();

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _venueController = TextEditingController();
  final _avenueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _contactController = TextEditingController();
  final _featuredImageController = TextEditingController();
  final List<TextEditingController> _imageControllers = [TextEditingController()];

  final List<String> _avenues = ['Education & Literacy',
    'Environment Conservation',
    'Healthcare',
    'Clean Water & Energy Conservation'

  ];

  String? _selectedAvenue;

  void _addImageField() {
    setState(() {
      _imageControllers.add(TextEditingController());
    });
  }

  void _removeImageField(int index) {
    setState(() {
      _imageControllers.removeAt(index);
    });
  }

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

  Future<void> _submitEvent() async {
    if (_formKey.currentState!.validate()) {
      final event = Event(
        id: '',
        name: _nameController.text,
        date: _dateController.text,
        time: _timeController.text,
        venue: _venueController.text,
        avenue: _selectedAvenue ?? '',
        description: _descriptionController.text,
        content: _contentController.text,
        contact: _contactController.text,
        featuredImage: _featuredImageController.text.trim(),
        images: _imageControllers.map((c) => c.text.trim()).where((url) => url.isNotEmpty).toList(),
      );

      final success = await _eventRepository.addEvent(event);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? "Event added successfully" : "Failed to add event"),
      ));
      if (success) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    _avenueController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    _contactController.dispose();
    _featuredImageController.dispose();
    for (final c in _imageControllers) {
      c.dispose();
    }
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

  Widget _buildImageUrlField({
    required TextEditingController controller,
    required String label,
    bool isFeatured = false,
    VoidCallback? onRemove,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: (val) => val!.isEmpty ? 'Enter $label' : null,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Google Drive Image ID Help'),
                      content: const Text(
                              '1. Open your image in Google Drive.\n'
                              '2. Set privacy to "Anyone with the link".\n'
                              '3. Copy image URL from URL.\n'
                              '4. Get Image ID from URL.\n'
                              '5. Paste it here.'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Tooltip(
                  message: "Help: Google Drive image link",
                  child: Icon(Icons.info_outline),
                ),
              ),
            ),
          ),
        ),
        if (onRemove != null)
          IconButton(onPressed: onRemove, icon: const Icon(Icons.remove_circle_outline)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, "Name"),
              _buildTextField(_dateController, "Date", onTap: _pickDate, readOnly: true),
              _buildTextField(_timeController, "Time", onTap: _pickTime, readOnly: true),
              _buildTextField(_venueController, "Venue"),
              CustomDropdown(
                hintText: '',
                items: _avenues,
                value: _selectedAvenue,
                onChanged: (val) => setState(() => _selectedAvenue = val),
              ),

              SizedBox(height: 10,),

              _buildTextField(_descriptionController, "Description", maxLines: 2),
              _buildTextField(_contentController, "Content", maxLines: 3),
              _buildTextField(_contactController, "Contact"),

              const SizedBox(height: 12),
              _buildImageUrlField(
                controller: _featuredImageController,
                label: "Featured Image ID",
                isFeatured: true,
              ),

              const SizedBox(height: 16),
              const Text("Slider Image IDs", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ..._imageControllers.asMap().entries.map((entry) {
                int index = entry.key;
                var controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildImageUrlField(
                    controller: controller,
                    label: "Image ID ${index + 1}",
                    onRemove: _imageControllers.length > 1
                        ? () => _removeImageField(index)
                        : null,
                  ),
                );
              }),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addImageField,
                  icon: const Icon(Icons.add),
                  label: const Text("Add another image"),
                ),
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Submit",
                  onPressed: _submitEvent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
