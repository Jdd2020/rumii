import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rumii/views/Calendar/edit_event_view.dart';
import 'package:rumii/views/Calendar/expand_event_view.dart';

class ExpandEvent {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String? repetition;
  final String? reminder;
  final String? note;

  ExpandEvent({
    required this.title,
    required this.startTime,
    required this.endTime,
    this.repetition,
    this.reminder,
    this.note,
  });
}

class ViewEvent extends StatelessWidget {
  final ExpandEvent event;

  ViewEvent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
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
                  DateFormat('EEEE, MMMM d, y').format(event.startTime),
                ),
                buildTextBox(
                  context,
                  'Time',
                  '${DateFormat('h:mm a').format(event.startTime)} - ${DateFormat('h:mm a').format(event.endTime)}',
                ),
                buildTextBox(
                  context,
                  'Repetition',
                  event.repetition ?? ' ',
                ),
                buildTextBox(
                  context,
                  'Reminder',
                  event.reminder ?? ' ',
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
                style: TextStyle(
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
}
