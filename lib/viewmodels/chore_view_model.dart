import 'package:rumii/models/chore_model.dart';
import 'package:flutter/foundation.dart';

class ChoreViewModel extends ChangeNotifier {
  Chore chore;
  // update to logic for fetching saved state

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

  String? get note {
    return chore.note;
  }

  String? get isRecurring {
    return chore.isRecurring;
  }

  String? get remind {
    return chore.remind;
  }

}
