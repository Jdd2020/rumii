import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class EditEvent extends StatefulWidget {
  final ExpandEvent event;

  EditEvent({Key? key, required this.event}) : super(key: key);

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

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data
    titleController = TextEditingController(text: widget.event.title);
    noteController = TextEditingController(text: widget.event.note ?? '');

    // Initialize date and time with existing data
    selectedDate = widget.event.date;
    selectedStartTime = TimeOfDay(
        hour: widget.event.startTime.hour,
        minute: widget.event.startTime.minute,
      );
    selectedEndTime = TimeOfDay(
        hour: widget.event.endTime.hour,
        minute: widget.event.endTime.minute,
      );

    // Initialize repetition and reminder with existing data
    selectedRepetition = widget.event.isRecurring;
    selectedReminder = widget.event.remind;
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
                        // Save changes
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
                      null; // Reset start time when date changes
                  selectedEndTime = null; // Reset end time when date changes
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
                ['1 Hour Before', '1 Day Before', '1 Week Before', 'Custom'],
                selectedReminder,
                (String? value) {
                  setState(() {
                    selectedReminder = value;
                  });
                },
              ),
              buildTextField('Note', noteController),
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
