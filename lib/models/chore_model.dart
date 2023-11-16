class Chore {
  final String name;
  final bool priority;
  final String dueDate;
  final bool isCompleted;

  Chore({
    required this.priority,
    required this.name,
    required this.dueDate,
    required this.isCompleted,
  });

  Chore.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        priority = json['priority'] as bool,
        dueDate = json['dueDate'] as String,
        isCompleted = json['isCompleted'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'priority': priority,
        'dueDate': dueDate,
        'isCompleted': isCompleted
      };
}
