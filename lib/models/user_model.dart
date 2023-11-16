import 'package:rumii/viewmodels/chore_view_model.dart';

class User {
  final String name;
  final List<ChoreViewModel> chores;

  User({required this.name, required this.chores});
}
