import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/SessionData.dart';
import 'package:provider/provider.dart';
import 'package:rumii/constants.dart';

class NewEvent extends StatefulWidget {
  final String username;
  final String houseKey;

  const NewEvent({Key? key, required this.username, required this.houseKey,}) : super(key: key);

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  final CalendarViewModel _calendarViewModel = CalendarViewModel();
  final TextEditingController nameController = TextEditingController();

  //users
  late String selectedAssignee = '';
  final List<String> householdMembers = ['Henry', 'Josh', 'Billy'];

  DateTime? date;
  final TextEditingController dateController = TextEditingController();

  TimeOfDay? startTime;
  final TextEditingController startTimeController = TextEditingController();

  TimeOfDay? endTime;
  final TextEditingController endTimeController = TextEditingController();

  //String? note;
  final TextEditingController noteController = TextEditingController();

  final TextEditingController reminderController = TextEditingController();

  final TextEditingController repetitionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    noteController.dispose();
    reminderController.dispose();
    repetitionController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
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
                            child: const Text('Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            onTap: () => {Navigator.pop(context)}),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        child: InkWell(
                            child: const Text('Save',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            onTap: () async {

                              String name = nameController.text;
                              DateTime? eventDate = date;
                              TimeOfDay? startTime = this.startTime;
                              TimeOfDay? endTime = this.endTime;
                              String assignee = selectedAssignee;

                              var newEvent = Event(
                                  name: name,
                                  day: eventDate?.day ?? 0,
                                  month: eventDate?.month ?? 0,
                                  year: eventDate?.year ?? 0,
                                  starttime: startTime?.format(context) ?? "",
                                  endtime: endTime?.format(context) ?? "",
                                  isRecurring: repetitionController.text,
                                  user: assignee,
                                  remind: reminderController.text,
                                  note: noteController.text,
                                );
                              Provider.of<CalendarViewModel>(context,
                                      listen: false)
                                  .addEvent(newEvent, selectedAssignee);
                              Provider.of<CalendarViewModel>(context,
                                      listen: false)
                                  .writeData(widget.houseKey);
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, calendarRoute,
                                  arguments: SessionData.data(
                                      widget.username, widget.houseKey));
                            }, 
                              /*
                      var newChore = Chore(
                          name: nameController.text,
                          priority: false,
                          dueDate: dueDateController.text,
                          isCompleted: false);
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .addChore(newChore, selectedAssignee);
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .writeData("DSBU781");
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("/chores");*/
                            ),),],),

                const Text('New Event',
                    style: (TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 20),

                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1500,
                  child: TextField(
                    controller: nameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name your Event'),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null && selectedDate != date) {
                      setState(() {
                        date = selectedDate;
                        dateController.text =
                            '${date!.month}/${date!.day}/${date!.year}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      width: 1500,
                      child: TextField(
                        controller: dateController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Date',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.input,
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    );
                    if (selectedTime != null && selectedTime != startTime) {
                      setState(() {
                        startTime = selectedTime;
                        startTimeController.text =
                            '${startTime!.hour}/${startTime!.minute}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      width: 1500,
                      child: TextField(
                        controller: startTimeController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Start Time',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.input,
                      context: context,
                      initialTime: const TimeOfDay(hour: 0, minute: 0),
                    );
                    if (selectedTime != null && selectedTime != endTime) {
                      setState(() {
                        endTime = selectedTime;
                        endTimeController.text =
                            '${endTime!.hour}/${endTime!.minute}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      width: 1500,
                      child: TextField(
                        controller: endTimeController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'End Time',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // assign User Dropdown
                DropdownButtonFormField<String>(
                  value: householdMembers.contains(selectedAssignee)
                      ? selectedAssignee
                      : null,
                  items: householdMembers.map((member) {
                    return DropdownMenuItem<String>(
                      value: member,
                      child: Text(member),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedAssignee = newValue;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Assign User',
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 1500,
                  child: DropdownButton<String>(
                    value: repetitionController.text.isEmpty
                        ? null
                        : repetitionController.text,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'None',
                        child: Text('None'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Bi-weekly',
                        child: Text('Bi-weekly'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Monthly',
                        child: Text('Monthly'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Custom',
                        child: Text('Custom'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        repetitionController.text = value!;
                      });
                      return;
                    },
                    hint: const Text('Repetition'),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 1500,
                  child: DropdownButton<String>(
                    value: reminderController.text.isEmpty
                        ? null
                        : reminderController.text,
                    items: const [
                      DropdownMenuItem<String>(
                        value: '1 Hour Before',
                        child: Text('1 Hour Before'),
                      ),
                      DropdownMenuItem<String>(
                        value: '1 Day Before',
                        child: Text('1 Day Before'),
                      ),
                      DropdownMenuItem<String>(
                        value: '1 Week Before',
                        child: Text('1 Week Before'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Custom',
                        child: Text('Custom'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        reminderController.text = value!;
                      });
                      return;
                    },
                    hint: const Text('Reminder'),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 1500,
                  child: TextField(
                    controller: noteController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Note'),
                  ),
                ),
              ],
                ),
              
            ),
          ),
    ),);
  }
}
