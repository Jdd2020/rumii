import 'package:rumii/models/chore_model.dart';
import 'package:flutter/foundation.dart';

class ChoreViewModel extends ChangeNotifier {
  final Chore chore;

  bool _isCompleted = false; // update to logic for fetching saved state

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

  bool get isCompleted => _isCompleted;

  set isCompleted (bool value){
    if(_isCompleted != value) {
      _isCompleted = value;
      notifyListeners();
    }
  }
}
