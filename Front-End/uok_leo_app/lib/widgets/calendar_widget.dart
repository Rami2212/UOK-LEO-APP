import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final bool isDirector;

  CalendarWidget({required this.isDirector});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

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
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
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

          // Event Details
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
                  "${_selectedDay.day} ${_selectedDay.month} ${_selectedDay.year}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                //event
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text("Event placeholder", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    //nagivate to single event page(give me the dummy code - it should get event details from the selected date)
                    //implement what we need to get event from backend. response, request and repositories in separately
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Date Booked Successfully!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Center(child: Text("View Event", style: TextStyle(color: Colors.white))),
                ),
                SizedBox(height: 10),

                // Book Date Button (Only for Directors)
                if (widget.isDirector)
                  ElevatedButton(
                    onPressed: () {
                      //navigate to book date screen with selected date - give me the dummy code of that form with date pre-filled, event name, avenue, name, phone number
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Date Booked Successfully!")),
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
