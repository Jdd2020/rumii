import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/models/shop_model.dart';
import 'dart:io';

import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/views/Shopping/shopping_list_view.dart';

class EditHouseholdViewModel extends ChangeNotifier {
  List<String> householdMembers = [];
  late Map<String, dynamic> choreData;
  late String currentHouseKey = "";
  List<Chore> choreList = <Chore>[];
  List<Shop> shopList = <Shop>[];
  List<Event> eventList = <Event>[];

  EditHouseholdViewModel() {
    loadChoreData();
  }

  Future<void> loadData(String housekey, String username) async {
    String jsonStringChore = await rootBundle.loadString('assets/choreDB.json');
    var choreData = json.decode(jsonStringChore) as Map<String, dynamic>;

    var userChoreList = choreData[housekey][username] as Map<String, dynamic>;
    for (var key in userChoreList.keys) {
      choreList.add(Chore.fromJson(userChoreList[key]));
    }
    print(choreList);

    String jsonStringShop = await rootBundle.loadString('assets/shopDB.json');
    var shopData = json.decode(jsonStringShop) as Map<String, dynamic>;

    var userShopList = shopData[housekey][username];
    for (var key in userShopList.keys.toList()) {
      shopList.add(Shop.fromJson(userShopList[key]));
    }

    String jsonStringEvent = await rootBundle.loadString('assets/eventDB.json');
    var eventData = json.decode(jsonStringEvent) as Map<String, dynamic>;

    var userEventList = eventData[housekey][username];
    for (var key in userEventList.keys.toList()) {
      eventList.add(Event.fromJson(userEventList[key]));
    }
    notifyListeners();
  }

  Future<void> loadChoreData() async {
    try {
      // load data
      String jsonString = await rootBundle.loadString('assets/choreDB.json');
      choreData = json.decode(jsonString);

      currentHouseKey = choreData.keys.first;

      householdMembers = [];
      choreData[currentHouseKey]?.forEach((personName, _) {
        householdMembers.add(personName);
      });

      notifyListeners();
    } catch (error) {
      print('Error loading chore data: $error');
    }
  }

  void deleteUser(String userName) {
    householdMembers.remove(userName);

    choreData[currentHouseKey]?.remove(userName);

    notifyListeners();
  }

  void showAddNewDialog(BuildContext context) {
    String shareLink = 'https://example.com/join/$currentHouseKey';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Household Member'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('House Key: $currentHouseKey',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text('Share Link: $shareLink'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
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
