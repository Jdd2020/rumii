class Event {
  final String name;
  final int day;
  final int month;
  final int year;
  final String starttime;
  final String endtime;
  final bool isRecurring;
  final String user;
  final int remind;
  final String note;

  Event({
    required this.name,
    required this.day,
    required this.month,
    required this.year,
    required this.starttime,
    required this.endtime,
    required this.isRecurring,
    required this.user,
    required this.remind,
    required this.note,
  });

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        day = json['day'] as int,
        month = json['month'] as int,
        year = json['year'] as int,
        starttime = json['starttime'] as String,
        endtime = json['endtime'] as String,
        isRecurring = json['isRecurring'] as bool,
        user = json['user'] as String,
        remind = json['remind'] as int,
        note = json['note'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'day': day,
        'month': month,
        'year': year,
        'starttime': starttime,
        'endtime': endtime,
        'isRecurring': isRecurring,
        'user': user,
        'remind': remind,
        'note': note,
      };
}
