import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:rumii/models/user_model.dart';

class ChoreListViewModel extends ChangeNotifier {
  ChoreListViewModel();
  List<UserViewModel> users = <UserViewModel>[];
  List<String> usernames = <String>[];

  List<String> getUsernames() {
    List<String> names = [];
    for (var user in users) {
      names.add(user.name);
    }
    return names;
  }

  Future<void> getData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
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
        var user = UserViewModel(user: User(name: userList[i]));
        user.setChores(tempChores);
        users.add(user);
        usernames.add(user.name);
      }
      print("data updated");
      notifyListeners();
    }
  }

  Future<void> writeData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
    final String jsonString = File('assets/choreDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(houseKey)) {
      var house = houseList[houseKey];
      house = {};
      for (var user in users) {
        house[user.name] = {};
        for (var chore in user.chores) {
          house[user.name][chore.name] = chore.chore.toJson();
        }
      }
      houseList[houseKey] = house;
    }
    File('assets/choreDB.json')
        .writeAsStringSync(json.encode(houseList), flush: true);
    print("date written");
    notifyListeners();
  }

  Future<void> addChore(Chore chore, String username) async {
    for (var i = 0; i < users.length; i++) {
      if (username == users[i].name) {
        users[i].chores.add(ChoreViewModel(chore: chore));
        print("chore added");
      }
    }
  }

  Future<void> editChore(
      Chore chored, String username, String lastChore, String lastUser) async {
    print(username);
    var chore = ChoreViewModel(chore: chored);
    for (var i = 0; i < users.length; i++) {
      if (lastUser == users[i].name) {
        print("user found");
        for (var n = 0; n < users[i].chores.length; n++) {
          if (lastChore == users[i].chores[n].name) {
            users[i].chores.removeAt(n);
            print("chore removed");
          }
        }
      }
    }

    for (var i = 0; i < users.length; i++) {
      if (username == users[i].name) {
        users[i].chores.add(chore);
        print('chore added');
      }
    }
    notifyListeners();
  }

  Future<void> deleteChore(String username, String lastChore) async {
    for (var i = 0; i < users.length; i++) {
      if (username == users[i].name) {
        print("first loop");
        for (var n = 0; n < users[i].chores.length; n++) {
          print(users[i].chores[n].name);
          print("second loop");
          if (lastChore == users[i].chores[n].name) {
            print("if statement");
            users[i].chores.removeAt(n);
            print("Chore removed");
          }
        }
      }
    }
    notifyListeners();
  }

  ChoreViewModel findAndUpdateChorePriority(ChoreViewModel choreViewModel) {
    final Chore chore = choreViewModel.chore;
    // Update the chore's priority
    final updatedChore = Chore(
      priority: !chore.priority,
      name: chore.name,
      dueDate: chore.dueDate,
      isCompleted: chore.isCompleted,
      note: chore.note,
      isRecurring: chore.isRecurring,
      remind: chore.remind
    );
    // Update the chore in the choreViewModel
    choreViewModel.chore = updatedChore;
    notifyListeners();
    return choreViewModel;
  }

  bool toggleChorePriority(ChoreViewModel choreViewModel) {
    final ChoreViewModel updatedChore =
        findAndUpdateChorePriority(choreViewModel);
    final List<UserViewModel> updatedUsers = users;
    for (var user in updatedUsers) {
      int choreIndex =
          user.chores.indexWhere((c) => c.name == updatedChore.name);
      if (choreIndex != -1) {
        user.chores[choreIndex] = updatedChore;
      }
    }
    notifyListeners();
    return true;
  }

  ChoreViewModel findAndUpdateChoreComplete(ChoreViewModel choreViewModel) {
    final Chore chore = choreViewModel.chore;
    // Update the chore's priority
    final updatedChore = Chore(
      priority: chore.priority,
      name: chore.name,
      dueDate: chore.dueDate,
      isCompleted: !chore.isCompleted,
      note: chore.note,
      isRecurring: chore.isRecurring,
      remind: chore.remind
    );
    // Update the chore in the choreViewModel
    choreViewModel.chore = updatedChore;
    notifyListeners();
    print("chore updated");
    return choreViewModel;
  }

  bool toggleChoreComplete(ChoreViewModel choreViewModel) {
    final ChoreViewModel updatedChore =
        findAndUpdateChoreComplete(choreViewModel);
    final List<UserViewModel> updatedUsers = users;
    for (var user in updatedUsers) {
      int choreIndex =
          user.chores.indexWhere((c) => c.name == updatedChore.name);
      if (choreIndex != -1) {
        user.chores[choreIndex] = updatedChore;
      }
    }
    notifyListeners();
    print(choreViewModel.chore.isCompleted);
    return choreViewModel.chore.isCompleted;
  }

  Future<String?> getUserImage(String username) async {
    final String jsonString = File('assets/userDB.json').readAsStringSync();
    var userMap = jsonDecode(jsonString) as Map<String, dynamic>;

    if (userMap.containsKey("Users")) {
      var usersData = userMap["Users"] as Map<String, dynamic>;

      if (usersData.containsKey(username)) {
        var userData = usersData[username] as Map<String, dynamic>;

        return userData['image'];
      }
    }

    return null;
  }
}
