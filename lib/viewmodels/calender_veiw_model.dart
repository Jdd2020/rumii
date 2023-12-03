import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/models/event_model.dart';

class CalenderViewModel extends ChangeNotifier {
  CalenderViewModel();
  List<EventViewModel> calender = <EventViewModel>[];

  Future<void> getData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
    calender = <EventViewModel>[];
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
        calender.add(event);
      }
    }
    print("data updated");
    notifyListeners();
  }
}
