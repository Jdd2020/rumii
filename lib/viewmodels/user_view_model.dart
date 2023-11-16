import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';

class UserViewModel {
  final User user;

  UserViewModel({required this.user});

  List<ChoreViewModel> get chores {
    return user.chores;
  }

  String get name {
    return user.name;
  }
}
