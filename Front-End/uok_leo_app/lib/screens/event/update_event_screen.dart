import 'package:flutter/material.dart';
import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

class UpdateEventScreen extends StatefulWidget {
  final String eventId;

  UpdateEventScreen({required this.eventId});

  @override
  _UpdateEventScreenState createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _venueController = TextEditingController();
  final _avenueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _contactController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final EventRepository _eventRepository = EventRepository();
  List<String> _imageUrls = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEventData();
  }

  // Fetch event details and prefill form
  void _loadEventData() async {
    try {
      Event event = await _eventRepository.fetchEventDetails(widget.eventId);
      setState(() {
        _titleController.text = event.name;
        _dateController.text = event.date;
        _timeController.text = event.time ?? '';
        _venueController.text = event.venue ?? '';
        _avenueController.text = event.avenue ?? '';
        _descriptionController.text = event.description;
        _contentController.text = event.content ?? '';
        _contactController.text = event.contact ?? '';
        _imageUrls = event.images ?? [];
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load event details")));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addImageUrl() {
    if (_imageUrlController.text.isNotEmpty) {
      setState(() {
        _imageUrls.add(_imageUrlController.text);
        _imageUrlController.clear();
      });
    }
  }

  void _updateEvent() async {
    if (_formKey.currentState!.validate()) {
      Event updatedEvent = Event(
        id: widget.eventId,
        name: _titleController.text,
        date: _dateController.text,
        time: _timeController.text,
        venue: _venueController.text,
        avenue: _avenueController.text,
        description: _descriptionController.text,
        content: _contentController.text,
        contact: _contactController.text,
        featuredImage: _imageUrls.isNotEmpty ? _imageUrls[0] : '',
        images: _imageUrls,
      );

      bool success = await _eventRepository.updateEvent(updatedEvent);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event updated successfully")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update event")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Event")),
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
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Event Title"),
                  validator: (value) => value!.isEmpty ? "Title is required" : null,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: "Event Date"),
                  validator: (value) => value!.isEmpty ? "Date is required" : null,
                ),
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: "Event Time"),
                  validator: (value) => value!.isEmpty ? "Time is required" : null,
                ),
                TextFormField(
                  controller: _venueController,
                  decoration: InputDecoration(labelText: "Event Venue"),
                  validator: (value) => value!.isEmpty ? "Venue is required" : null,
                ),
                TextFormField(
                  controller: _avenueController,
                  decoration: InputDecoration(labelText: "Avenue"),
                  validator: (value) => value!.isEmpty ? "Avenue is required" : null,
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
                  controller: _contactController,
                  decoration: InputDecoration(labelText: "Contact"),
                  validator: (value) => value!.isEmpty ? "Contact is required" : null,
                ),
                SizedBox(height: 10),

                // Image URL Input
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: "Image URL"),
                ),
                ElevatedButton(
                  onPressed: _addImageUrl,
                  child: Text("Add Image"),
                ),

                // Display added image URLs
                _imageUrls.isNotEmpty
                    ? Column(
                  children: _imageUrls
                      .map((url) => ListTile(
                    title: Text(url),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _imageUrls.remove(url);
                        });
                      },
                    ),
                  ))
                      .toList(),
                )
                    : Container(),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateEvent,
                  child: Text("Update Event"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
