import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:rumii/models/user_model.dart';

class ChoreListViewModel extends ChangeNotifier {
  List<UserViewModel> users = <UserViewModel>[];

  Future<void> getUserList(String houseKey) async {
    final String jsonString =
        await rootBundle.loadString('assets/choreDB.json');
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
      notifyListeners();
    }
  }
}
