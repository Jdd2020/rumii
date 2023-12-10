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
    var timeParts = event.starttime.split(':');
    return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  }

  TimeOfDay get endTime {
    var timeParts = event.endtime.split(':');
    return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  } 

  bool get isRecurring {
    return event.isRecurring;
  }

  String get user {
    return event.user;
  }

  int get remind {
    return event.remind;
  }

   String get note {
    return event.note;
  }
}
