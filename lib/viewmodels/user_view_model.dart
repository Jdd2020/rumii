import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/event_view_model.dart';

class UserViewModel {
  final User user;

  UserViewModel({required this.user});

  List<ChoreViewModel> get chores {
    return user.chores;
  }

  List<ShopViewModel> get shopItems {
    return user.shopItems;
  }

  List<EventViewModel> get events {
    return user.events;
  }

  String get name {
    return user.name;
  }

  String? get image {
    return user.image;
  }

  void setChores(List<ChoreViewModel> choreList) {
    user.chores = choreList;
  }

  void setShopItems(List<ShopViewModel> shopItems) {
    user.shopItems = shopItems;
  }

  void setEvents(List<EventViewModel> events) {
    user.events = events;
  }

  void setImage(String imageString) {
    user.image = imageString;
  }
}
