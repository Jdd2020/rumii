import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class ExpandView extends StatelessWidget {
  final DateTime selectedDay;

  ExpandView({Key? key, required this.selectedDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ExpandEvent> events = fetchFakeEventsForDay(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Events for ${DateFormat('MMMM d, y').format(selectedDay)}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMMM d, y').format(selectedDay),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Events:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  ExpandEvent event = events[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(event.title),
                        subtitle: Text(
                          '${DateFormat('h:mm a').format(event.startTime)} - ${DateFormat('h:mm a').format(event.endTime)}',
                        ),
                        onTap: () {
                          // Navigate to ViewEvent with the selected event details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewEvent(
                                event: event,
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<ExpandEvent> fetchFakeEventsForDay(DateTime day) {
  // Fake data for demonstration
  return [
    ExpandEvent(
      title: 'Meeting with Team',
      startTime: DateTime(day.year, day.month, day.day, 10, 0),
      endTime: DateTime(day.year, day.month, day.day, 11, 30),
      repetition: 'Weekly',
      reminder: '1 Day Before',
      note: 'Discuss project updates',
    ),
    ExpandEvent(
      title: 'Lunch Break',
      startTime: DateTime(day.year, day.month, day.day, 12, 0),
      endTime: DateTime(day.year, day.month, day.day, 13, 0),
      repetition: 'None',
      reminder: 'Custom',
      note: 'Grab lunch at the cafeteria',
    ),
    ExpandEvent(
      title: 'Project Discussion',
      startTime: DateTime(day.year, day.month, day.day, 14, 0),
      endTime: DateTime(day.year, day.month, day.day, 15, 30),
      repetition: 'Bi-weekly',
      reminder: '1 Hour Before',
      note: 'Review project milestones',
    ),
  ];
}
