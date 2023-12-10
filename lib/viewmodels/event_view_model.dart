import 'package:flutter/material.dart';
import 'package:rumii/models/event_model.dart';

class EventViewModel {
  final Event event;

  EventViewModel({required this.event});

  String get name {
    return event.name;
  }

  DateTime get date {
    return DateTime(event.year, event.month, event.day);
  }

  TimeOfDay get startTime {
    return _parseTimeStringToTimeOfDay(event.starttime);
  }

  TimeOfDay get endTime {
     return _parseTimeStringToTimeOfDay(event.endtime);
  } 

  String get isRecurring {
    return event.isRecurring;
  }

  String get user {
    return event.user;
  }

  String get remind {
    return event.remind;
  }

   String get note {
    return event.note;
  }

  TimeOfDay _parseTimeStringToTimeOfDay(String timeString) {
    List<String> timeParts = timeString.split(RegExp(r'[:\s]'));

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    if (timeParts.length == 3 && timeParts[2].toLowerCase() == 'pm') {
      hours = (hours + 12) % 24;
    }

    return TimeOfDay(hour: hours, minute: minutes);
  }
}
