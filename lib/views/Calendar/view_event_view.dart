import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rumii/views/Calendar/edit_event_view.dart';
import 'package:rumii/viewmodels/event_view_model.dart';

class ExpandEvent {
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? isRecurring;
  final String? remind;
  final String? note;

  ExpandEvent({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isRecurring,
    this.remind,
    this.note,
  });
}

class ViewEvent extends StatelessWidget {
  final ExpandEvent event;
  final EventViewModel? eventViewModel;
  final String? user;
  final String? lastItem;
  final String? housekey;
  final String? username;

  const ViewEvent({Key? key, required this.event, this.eventViewModel, this.user, this.lastItem, this.housekey, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEvent(event: event),
                        ),
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextBox(context, 'Event', event.title),
                buildTextBox(
                  context,
                  'Date',
                  DateFormat('EEEE, MMMM d, y').format(event.date),
                ),
                buildTextBox(
                  context,
                  'Time',
                  '${formatTimeOfDay(event.startTime)} - ${formatTimeOfDay(event.endTime)}',
                ),
                buildTextBox(
                  context,
                  'Repetition',
                  event.isRecurring.toString(),
                ),
                buildTextBox(
                  context,
                  'Reminder',
                  event.remind.toString(),
                ),
                buildTextBox(
                  context,
                  'Note',
                  event.note ?? ' ',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextBox(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

   String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

}
