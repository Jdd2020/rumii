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
      }
      print("data updated");
      notifyListeners();
    }
  }
}
