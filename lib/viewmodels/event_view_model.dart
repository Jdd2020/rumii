import 'package:rumii/models/event_model.dart';

class EventViewModel {
  final Event event;

  EventViewModel({required this.event});

  String get name {
    return event.name;
  }

  int get day {
    return event.day;
  }

  int get month {
    return event.month;
  }

  String get starttime {
    return event.starttime;
  }

  String get endtime {
    return event.endtime;
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
}
