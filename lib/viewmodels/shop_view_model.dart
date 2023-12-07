import 'package:rumii/models/shop_model.dart';
import 'package:flutter/foundation.dart';

class ShopViewModel extends ChangeNotifier {
  Shop shop;
  // update to logic for fetching saved state

  ShopViewModel({required this.shop});

  String get name {
    return shop.name;
  }

  String get notes {
    return shop.notes;
  }

  int get quantity {
    return shop.quantity;
  }

  String get type {
    return shop.type;
  }

  bool get isCompleted {
    return shop.isCompleted;
  }

  Shop toShop() {
    return Shop(
      name: name,
      notes: notes,
      quantity: quantity,
      type: type,
      isCompleted: isCompleted,
    );
  }
}
