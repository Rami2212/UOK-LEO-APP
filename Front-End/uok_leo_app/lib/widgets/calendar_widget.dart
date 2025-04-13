import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/models/event.dart';
import '../data/repositories/event_repository.dart';
import '../screens/event/event_details_screen.dart';
import '../screens/bookings/date_booking_form_screen.dart';

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
  List<Event> _events = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    setState(() => _isLoading = true);
    try {
      String date = "${_selectedDay.year.toString().padLeft(4, '0')}-${_selectedDay.month.toString().padLeft(2, '0')}-${_selectedDay.day.toString().padLeft(2, '0')}";
      List<Event> events = await eventRepository.fetchEventsByDate(date);
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _events = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
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
              _fetchEvents();
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

          Text(
            "${_selectedDay.day}-${_selectedDay.month}-${_selectedDay.year}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
          ),

          SizedBox(height: 12),

          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _events.isEmpty
              ? Text("No events on this date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey))
              : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
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
                    Text(event.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventDetailsScreen(eventId: event.id)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Center(child: Text("View Event", style: TextStyle(color: Colors.white))),
                    ),
                  ],
                ),
              );
            },
          ),

          // Book Date Button (shown only if director)
          if (widget.isDirector)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DateBookingFormScreen(selectedDate: _selectedDay)),
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
    );
  }
}
