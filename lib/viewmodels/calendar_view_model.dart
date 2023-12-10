import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel();
  List<EventViewModel> calendar = <EventViewModel>[];
  List<UserViewModel> users = <UserViewModel>[];

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

      var house = houseList[houseKey] ?? {};
      for (var user in users) {
        house[user.name] = {};
        for (var event in user.events) {
          house[user.name][event.name] = event.event.toJson();
        }
      }
      houseList[houseKey] = house;
    
    File('assets/eventDB.json')
        .writeAsStringSync(json.encode(houseList));
    print("data written");
    notifyListeners();
  }

 Future<void> addEvent(Event event, String username) async {
    for (var i = 0; i < users.length; i++) {
      if (username == users[i].name) {
        users[i].events.add(EventViewModel(event: event));
        print("event added");
      }
    }
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
