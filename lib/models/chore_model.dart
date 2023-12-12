class Chore {
  final String name;
  final bool priority;
  final String dueDate;
  final bool isCompleted;
  final String? note;
  final String? isRecurring;
  final String? remind;

  Chore({
    required this.priority,
    required this.name,
    required this.dueDate,
    required this.isCompleted,
    this.note, 
    this.isRecurring,
    this.remind,
  });

  Chore.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        priority = json['priority'] as bool,
        dueDate = json['dueDate'] as String,
        isCompleted = json['isCompleted'] as bool,
        note = json['note'] as String?,
        isRecurring = json['isRecurring'] as String?,
        remind = json['remind'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'priority': priority,
        'dueDate': dueDate,
        'isCompleted': isCompleted,
        'note': note,
        'isRecurring': isRecurring,
        'remind': remind,
      };
}
