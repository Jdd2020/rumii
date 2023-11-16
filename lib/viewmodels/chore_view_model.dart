import 'package:rumii/models/chore_model.dart';

class ChoreViewModel {
  final Chore chore;

  ChoreViewModel({required this.chore});

  String get name {
    return chore.name;
  }

  bool get priority {
    return chore.priority;
  }

  String get dueDate {
    return chore.dueDate;
  }

  bool get isCompleted {
    return chore.isCompleted;
  }
}
