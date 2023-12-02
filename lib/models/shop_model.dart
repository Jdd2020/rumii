class Shop {
  final String name;
  final String notes;
  final int quantity;
  final String type;
  final bool isCompleted;

  Shop({
    required this.name,
    required this.notes,
    required this.quantity,
    required this.type,
    required this.isCompleted,
  });

  Shop.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        notes = json['notes'] as String,
        quantity = json['quantity'] as int,
        type = json['type'] as String,
        isCompleted = json['isCompleted'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'notes': notes,
        'quantity': quantity,
        'type': type,
        'isCompleted': isCompleted
      };
}
