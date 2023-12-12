import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class EditEvent extends StatefulWidget {
  final ExpandEvent event;
  final String housekey;
  final String username;

  const EditEvent(
      {Key? key,
      required this.event,
      required this.housekey,
      required this.username})
      : super(key: key);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late TextEditingController titleController;
  late TextEditingController noteController;

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  String? selectedRepetition;
  String? selectedReminder;
  String? selectedUser;
  String? initEventTitle;
  List<String>? usernames;

  @override
  void initState() {
    super.initState();
    initEventTitle = widget.event.title;

    titleController = TextEditingController(text: widget.event.title);
    noteController = TextEditingController(text: widget.event.note ?? '');

    selectedDate = widget.event.date;
    selectedStartTime = TimeOfDay(
      hour: widget.event.startTime.hour,
      minute: widget.event.startTime.minute,
    );
    selectedEndTime = TimeOfDay(
      hour: widget.event.endTime.hour,
      minute: widget.event.endTime.minute,
    );

    selectedRepetition = widget.event.isRecurring;
    selectedReminder = widget.event.remind;
    selectedUser = widget.username;

    Provider.of<CalendarViewModel>(context, listen: false)
        .getData(widget.housekey);
    Provider.of<CalendarViewModel>(context, listen: false)
        .getUsers(widget.housekey);

    usernames =
        Provider.of<CalendarViewModel>(context, listen: false).usernames;
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: InkWell(
                      onTap: () {
                        var event = Event(
                            name: titleController.text,
                            day: selectedDate!.day,
                            month: selectedDate!.month,
                            year: selectedDate!.year,
                            starttime: selectedStartTime!.format(context),
                            endtime: selectedEndTime!.format(context),
                            isRecurring: selectedRepetition.toString(),
                            user: selectedUser!,
                            remind: selectedReminder.toString(),
                            note: noteController.text);
                        Provider.of<CalendarViewModel>(context, listen: false)
                            .deleteEvent(initEventTitle!);
                        Provider.of<CalendarViewModel>(context, listen: false)
                            .addEvent(event);
                        Provider.of<CalendarViewModel>(context, listen: false)
                            .writeData(widget.housekey);
                        Navigator.pushNamed(context, calendarRoute,
                            arguments: SessionData.data(
                                widget.username, widget.housekey));
                      },
                      child: const Text('Save',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildTextField('Event', titleController),
              buildDateTimePicker('Select Date', selectedDate, (DateTime date) {
                setState(() {
                  selectedDate = date;
                  selectedStartTime =
                      null; // reset start time when date changes
                  selectedEndTime = null; // reset end time when date changes
                });
              }),
              buildTimePicker(
                'Start Time',
                selectedStartTime,
                (TimeOfDay time) {
                  setState(() {
                    selectedStartTime = time;
                  });
                },
              ),
              buildTimePicker(
                'End Time',
                selectedEndTime,
                (TimeOfDay time) {
                  setState(() {
                    selectedEndTime = time;
                  });
                },
              ),
              Consumer<CalendarViewModel>(builder: (context, calendar, child) {
                return buildDropdown(
                  'Assigned User',
                  calendar.usernames,
                  selectedUser,
                  (String? value) {
                    setState(() {
                      selectedUser = value;
                    });
                  },
                );
              }),
              buildDropdown(
                'Repetition',
                ['None', 'Daily', 'Weekly', 'Bi-weekly', 'Monthly', 'Custom'],
                selectedRepetition,
                (String? value) {
                  setState(() {
                    selectedRepetition = value;
                  });
                },
              ),
              buildDropdown(
                'Reminder',
                ['1 hour Before', '1 day Before', '1 week Before', 'Custom'],
                selectedReminder,
                (String? value) {
                  setState(() {
                    selectedReminder = value;
                  });
                },
              ),
              buildTextField('Note', noteController),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Provider.of<CalendarViewModel>(context, listen: false)
                              .deleteEvent(titleController.text);
                          Provider.of<CalendarViewModel>(context, listen: false)
                              .writeData(widget.housekey);
                          Navigator.pushNamed(context, calendarRoute,
                              arguments: SessionData.data(
                                  widget.username, widget.housekey));
                        },
                        child: const Text("Delete")),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildDropdown(
    String label,
    List<String> options,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    //options = Provider.of<CalendarViewModel>(context, listen: false).usernames;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
            hint: const Text('Select'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildDateTimePicker(
    String label,
    DateTime? selectedDate,
    Function(DateTime) onDateChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                onDateChanged(pickedDate);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate != null
                    ? DateFormat('EEEE, MMMM d, y').format(selectedDate!)
                    : 'Select Date'),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildTimePicker(
    String label,
    TimeOfDay? selectedTime,
    Function(TimeOfDay) onTimeChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialEntryMode: TimePickerEntryMode.input,
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (pickedTime != null) {
                onTimeChanged(pickedTime);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedTime != null
                    ? '${selectedTime!.hour}:${selectedTime.minute}'
                    : 'Select Time'),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
