import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/models/event.dart';
import '../data/repositories/event_repository.dart';
import '../screens/event_details_screen.dart';
import '../screens/book_date_screen.dart';

class CalendarWidget extends StatefulWidget {
  final bool isDirector;

  CalendarWidget({required this.isDirector});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  EventRepository eventRepository = EventRepository();
  Event? _event;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvent();
  }

  void _fetchEvent() async {
    setState(() => _isLoading = true);
    try {
      List<Event> events = await eventRepository.fetchEventsByDate(
          "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}");

      setState(() {
        _event = events.isNotEmpty ? events.first : null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Calendar UI
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _fetchEvent(); // Fetch event on date selection
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),

          SizedBox(height: 20),

          // Event Details Container
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_selectedDay.day}-${_selectedDay.month}-${_selectedDay.year}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                ),

                SizedBox(height: 8),

                // Event Details
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : (_event != null
                    ? Row(
                  children: [
                    Expanded(
                      child: Text(_event!.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
                    : Text("No events on this date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey))),

                SizedBox(height: 10),

                // View Event Button
                if (_event != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: _event!.id)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Center(child: Text("View Event", style: TextStyle(color: Colors.white))),
                  ),

                // Book Date Button
                if (widget.isDirector)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookDateScreen(selectedDate: _selectedDay)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Center(child: Text("Book Date", style: TextStyle(color: Colors.white))),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
