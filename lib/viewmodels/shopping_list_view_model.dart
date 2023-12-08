import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/models/user_model.dart';

class ShoppingListViewModel extends ChangeNotifier {
  ShoppingListViewModel();
  List<UserViewModel> users = <UserViewModel>[];
  List<String> usernames = <String>[];

  List<String> getUsernames() {
    List<String> usernames = [];
    for (var user in users) {
      usernames.add(user.name);
    }
    return usernames;
  }

  Future<void> getData(String houseKey) async {
    //final directory = await getApplicationDocumentsDirectory();
    //var path = directory.path;
    final String jsonString = File('assets/shopDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(houseKey)) {
      var userData = houseList[houseKey] as Map<String, dynamic>;
      var userList = userData.keys.toList();
      //print(userList.toString());
      for (var i = 0; i < userList.length; i++) {
        var items = userData[userList[i]] as Map<String, dynamic>;
        var shopList = items.keys.toList();
        //print(choreList.toString());
        var tempItems = <ShopViewModel>[];
        for (var n = 0; n < shopList.length; n++) {
          var shop = ShopViewModel(
              shop: Shop.fromJson(items[shopList[n]] as Map<String, dynamic>));
          tempItems.add(shop);
        }
        var user = UserViewModel(user: User(name: userList[i]));
        user.setShopItems(tempItems);
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
    final String jsonString = File('assets/shopDB.json').readAsStringSync();
    var houseList = await jsonDecode(jsonString) as Map<String, dynamic>;
    if (houseList.containsKey(houseKey)) {
      var house = houseList[houseKey];
      house = {};
      for (var user in users) {
        house[user.name] = {};
        for (var item in user.shopItems) {
          house[user.name][item.name] = item.shop.toJson();
        }
      }
      houseList[houseKey] = house;
    }
    File('assets/shopDB.json')
        .writeAsStringSync(json.encode(houseList), flush: true);
    print("data written");
    notifyListeners();
  }

  void addItem(Shop shop, String username) {
    for (var user in users) {
      if (user.name == username) {
        user.shopItems.add(ShopViewModel(shop: shop));
      }
    }
  }

  void removeItem(String username, String oldItem) {
    for (var user in users) {
      if (user.name == username) {
        for (var shop in user.shopItems) {
          if (oldItem == shop.name) {
            user.shopItems.remove(shop);
          }
        }
      }
    }
  }

  Future<void> deleteItem(String username, String lastItem) async {
    for (var i = 0; i < users.length; i++) {
      if (username == users[i].name) {
        print("first loop");
        for (var n = 0; n < users[i].shopItems.length; n++) {
          print(users[i].shopItems[n].name);
          print("second loop");
          if (lastItem == users[i].shopItems[n].name) {
            print("if statement");
            users[i].shopItems.removeAt(n);
            print("Item removed");
          }
        }
      }
    }
    notifyListeners();
  }
}
