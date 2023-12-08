import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_view_model.dart';
import 'package:rumii/models/login_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'dart:convert';

class LoginListViewModel extends ChangeNotifier {
  LoginListViewModel();
  List<LoginViewModel> users = <LoginViewModel>[];
  List<String> houseKeys = <String>[];

  bool loginCheck(String username, String password) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }

  //Only use after logincheck
  LoginViewModel fetchUser(String username) {
    for (var user in users) {
      if (user.username == username) {
        return user;
      }
    }
    return LoginViewModel(
        login: Login(
            username: "", password: "", email: "", houseKey: "", uniqueId: 0));
  }

  Future<void> fetchData() async {
    final String jsonString = await rootBundle.loadString('assets/userDB.json');
    var loginData = await jsonDecode(jsonString) as Map<String, dynamic>;
    var userList = loginData['Users'] as Map<String, dynamic>;
    var houseList = loginData['Houses'];

    for (var tempUser in userList.keys.toList()) {
      var user = Login.fromJson(userList[tempUser]);
      users.add(LoginViewModel(login: user));
      notifyListeners();
    }
    for (var houseKey in houseList) {
      houseKeys.add(houseKey);
    }
    notifyListeners();
  }

  Future<void> writeData() async {
    final String jsonString = await rootBundle.loadString('assets/userDB.json');
    var loginData = await jsonDecode(jsonString) as Map<String, dynamic>;
    var houses = [];
    var tempUsers = {};
    for (var user in users) {
      tempUsers[user.username] = user.login.toJson();
    }
    for (var key in houseKeys) {
      houses.add(key);
    }

    loginData['Users'] = tempUsers;
    loginData['Houses'] = houses;
    File('assets/userDB.json')
        .writeAsStringSync(json.encode(loginData), flush: true);
    print("date written");
    notifyListeners();
  }

  bool checkKey(String housekey) {
    for (var key in houseKeys) {
      if (housekey == key) return true;
    }
    return false;
  }

  Future<void> addUserNewKey(Login user) async {
    for (var key in houseKeys) {
      if (user.houseKey == key) {
        return;
      }
    }
    users.add(LoginViewModel(login: user));
    houseKeys.add(user.houseKey);

    final String jsonStringChore =
        await rootBundle.loadString('assets/choreDB.json');
    var choreData = await jsonDecode(jsonStringChore) as Map<String, dynamic>;
    choreData[user.houseKey] = {user.username: {}};
    choreData[user.houseKey][user.username] = {};
    File('assets/choreDB.json')
        .writeAsStringSync(json.encode(choreData), flush: true);

    final String jsonShopString =
        await rootBundle.loadString('assets/shopDB.json');
    var shopData = await jsonDecode(jsonShopString) as Map<String, dynamic>;
    shopData[user.houseKey] = {user.username: {}};
    File('assets/shopDB.json')
        .writeAsStringSync(json.encode(shopData), flush: true);

    final String jsonEventString =
        await rootBundle.loadString('assets/eventDB.json');
    var eventData = await jsonDecode(jsonEventString) as Map<String, dynamic>;
    shopData[user.houseKey] = {};
    shopData[user.houseKey][user.username] = {};
    File('assets/eventDB.json')
        .writeAsStringSync(json.encode(eventData), flush: true);
    notifyListeners();
  }

  Future<void> addUserWithKey(Login user) async {
    for (var key in houseKeys) {
      if (user.houseKey == key) {
        users.add(LoginViewModel(login: user));

        final String jsonStringChore =
            await rootBundle.loadString('assets/choreDB.json');
        var choreData =
            await jsonDecode(jsonStringChore) as Map<String, dynamic>;
        choreData[user.houseKey][user.username] = {};
        File('assets/choreDB.json')
            .writeAsStringSync(json.encode(choreData), flush: true);

        final String jsonShopString =
            await rootBundle.loadString('assets/shopDB.json');
        var shopData = await jsonDecode(jsonShopString) as Map<String, dynamic>;
        shopData[user.houseKey][user.username] = {};
        File('assets/shopDB.json')
            .writeAsStringSync(json.encode(shopData), flush: true);
      }
    }
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