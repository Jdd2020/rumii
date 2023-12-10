import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class ExpandView extends StatelessWidget {
  final DateTime selectedDay;

  const ExpandView({Key? key, required this.selectedDay}) : super(key: key);

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
                          '${formatTimeOfDay(event.startTime)} - ${formatTimeOfDay(event.endTime)}',
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

   String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

List<ExpandEvent> fetchFakeEventsForDay(DateTime day) {
  // Fake data for demonstration
  return [
    ExpandEvent(
      title: 'Meeting with Team',
      date: DateTime(1,1,1,1),
      startTime: TimeOfDay(hour: 1,minute: 1),
      endTime: TimeOfDay(hour: 2,minute: 1),
      isRecurring: 'Daily',
      remind: '1 Hour Before',
      note: 'Discuss project updates',
    ),
    ExpandEvent(
      title: 'Lunch Break',
      date:DateTime(2,1,1,1),
      startTime: TimeOfDay(hour: 2,minute: 1),
      endTime: TimeOfDay(hour: 5,minute: 5),
      isRecurring: 'Biweekly',
      remind: '1 Hour Before',
      note: 'Grab lunch at the cafeteria',
    ),
    ExpandEvent(
      title: 'Project Discussion',
      date: DateTime(2,8,1,1),
      startTime: TimeOfDay(hour: 5,minute: 5),
      endTime: TimeOfDay(hour: 15,minute: 0),
      isRecurring: 'Monthly',
      remind: '1 Day Before',
      note: 'Review project milestones',
    ),
  ];
}

/*
List<ExpandEvent> fetchFakeEventsForDay(DateTime day) {
  // Fake data for demonstration
  return [
    ExpandEvent(
      title: 'Meeting with Team',
      date: DateTime(0,0,0,0),
      startTime: DateTime(day.year, day.month, day.day, 10, 0),
      endTime: DateTime(day.year, day.month, day.day, 11, 30),
      isRecurring: 'Weekly',
      remind: '1 Day Before',
      note: 'Discuss project updates',
    ),
    ExpandEvent(
      title: 'Lunch Break',
      date:
      startTime: DateTime(day.year, day.month, day.day, 12, 0),
      endTime: DateTime(day.year, day.month, day.day, 13, 0),
      isRecurring: 'None',
      remind: 'Custom',
      note: 'Grab lunch at the cafeteria',
    ),
    ExpandEvent(
      title: 'Project Discussion',
      date:
      startTime: DateTime(day.year, day.month, day.day, 14, 0),
      endTime: DateTime(day.year, day.month, day.day, 15, 30),
      isRecurring: 'Bi-weekly',
      remind: '1 Hour Before',
      note: 'Review project milestones',
    ),
  ];
}*/