import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel();
  List<EventViewModel> calendar = <EventViewModel>[];
  List<UserViewModel> users = <UserViewModel>[];
  List<String> usernames = <String>[];

  List<EventViewModel> getDayEvents(DateTime date) {
    var eventList = <EventViewModel>[];
    for (var event in calendar) {
      if (date == event.date) {
        eventList.add(event);
      }
    }
    return eventList;
  }

  Future<void> getUsers(String housekey) async {
    final String jsonString = File('assets/choreDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(housekey)) {
      usernames = houseList[housekey].keys.toList();
    }
    notifyListeners();
  }

  Future<void> getData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
    calendar = <EventViewModel>[];
    final String jsonString = File('assets/eventDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(houseKey)) {
      var eventData = houseList[houseKey] as Map<String, dynamic>;
      //print(userList.toString());
      var eventList = eventData.keys.toList();
      //print(choreList.toString());
      for (var n = 0; n < eventList.length; n++) {
        var event = EventViewModel(
            event: Event.fromJson(
                eventData[eventList[n]] as Map<String, dynamic>));
        calendar.add(event);
      }
    }
    print("data updated");
    notifyListeners();
  }

  Future<void> writeData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
    final String jsonString = File('assets/eventDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;

    var eventList = {};
    for (var event in calendar) {
      eventList[event.name] = event.event.toJson();
    }
    houseList[houseKey] = eventList;

    File('assets/eventDB.json').writeAsStringSync(json.encode(houseList));
    print("data written");
    notifyListeners();
  }

  void addEvent(Event event) {
    calendar.add(EventViewModel(event: event));
    notifyListeners();
  }

  void deleteEvent(String eventName) {
    for (var event in calendar) {
      if (event.name == eventName) {
        calendar.remove(event);
      }
    }
    notifyListeners();
  }

  List<EventViewModel> getEventsForDate(DateTime date) {
    return calendar
        .where((event) =>
            event.date.year == date.year &&
            event.date.month == date.month &&
            event.date.day == date.day)
        .toList();
  }
}
