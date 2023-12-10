import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/event_view_model.dart';

class User {
  final String name;
  final String? image;
  List<ChoreViewModel> chores = [];
  List<ShopViewModel> shopItems = [];
  List<EventViewModel> events = [];

  User({required this.name, this.image});

   factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'],
      image: json['image']
    );
  }

}
