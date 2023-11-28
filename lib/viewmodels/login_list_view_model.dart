import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_view_model.dart';
import 'package:rumii/models/login_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'dart:convert';

class LoginListViewModel extends ChangeNotifier {
  LoginListViewModel();
  List<LoginViewModel> users = <LoginViewModel>[];

  Future<void> fetchUser(String key) async {
    final String jsonString = await rootBundle.loadString('assets/userDB.json');
    var userList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (userList.containsKey(key)) {
      var tempUser = userList[key] as Map<String, dynamic>;
      var user = Login.fromJson(tempUser);
      users = <LoginViewModel>[LoginViewModel(login: user)];
      notifyListeners();
    }
  }

  Future<void> writeUser(Login user) async {
    final String jsonString = await rootBundle.loadString('assets/userDB.json');
    var userList = await jsonDecode(jsonString) as Map<String, dynamic>;
    var data = user.toJson();
    userList[user.username] = data;
    File('assets/userDB.json').writeAsStringSync(json.encode(userList));
  }

  Future<void> clear() async {
    users = <LoginViewModel>[];
    notifyListeners();
  }
}

/*
Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/userDB.json');
    var data = jsonDecode(jsonString);
    setState(() {
      jsonData = data;
    });
  }
*/