import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:rumii/models/user_model.dart';

class ChoreListViewModel extends ChangeNotifier {
  List<UserViewModel> users = <UserViewModel>[];

  Future<void> getUserList(String houseKey) async {
    final String jsonString = File('assets/choreDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(houseKey)) {
      var userData = houseList[houseKey] as Map<String, dynamic>;
      var userList = userData.keys.toList();
      //print(userList.toString());
      for (var i = 0; i < userList.length; i++) {
        var chores = userData[userList[i]] as Map<String, dynamic>;
        var choreList = chores.keys.toList();
        //print(choreList.toString());
        var tempChores = <ChoreViewModel>[];
        for (var n = 0; n < choreList.length; n++) {
          var chore = ChoreViewModel(
              chore:
                  Chore.fromJson(chores[choreList[n]] as Map<String, dynamic>));
          tempChores.add(chore);
        }
        var user =
            UserViewModel(user: User(name: userList[i], chores: tempChores));
        users.add(user);
      }
      print("data updated");
      notifyListeners();
    }
  }

  Future<void> writeUserChores(
      String houseKey, String username, Chore chore) async {
    final String jsonString = File('assets/choreDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;

    if (houseList.containsKey(houseKey)) {
      var userData = houseList[houseKey] as Map<String, dynamic>;
      if (userData.containsKey(username)) {
        var chores = userData[username] as Map<String, dynamic>;
        var data = chore.toJson();
        chores[chore.name] = data;
        File('assets/choreDB.json')
            .writeAsStringSync(json.encode(houseList), flush: true);
      }
      notifyListeners();
    }
  }
}
