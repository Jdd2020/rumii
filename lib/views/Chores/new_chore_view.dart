import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/chore_model.dart';

// NewChore View
class NewChore extends StatefulWidget {
  final String housekey;
  final String username;
  const NewChore({Key? key, required this.username, required this.housekey})
      : super(key: key);

  @override
  _NewChoreState createState() => _NewChoreState();
}

class _NewChoreState extends State<NewChore> {
  DateTime? dueDate;
  ChoreListViewModel choreList = ChoreListViewModel();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController assignUserController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController repetitionController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();

  //users
  late String selectedAssignee = '';

  Future<void> fetchUsers(String houseKey) async {
    await choreList.getData(houseKey);
    setState(() {});
  }

  Future<void> writeUsers(String houseKey) async {
    await choreList.writeData(houseKey);
  }

  Future<void> addChore(String username, Chore chore) async {
    await choreList.addChore(chore, username);
  }

  @override
  initState() {
    super.initState();
    Provider.of<ChoreListViewModel>(context, listen: false)
        .getData(widget.housekey);
    selectedAssignee = '';
  }

  @override
  void dispose() {
    nameController.dispose();
    //assignUserController.dispose();
    dueDateController.dispose();
    noteController.dispose();
    pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(children: <Widget>[
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
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                              var newChore = Chore(
                                  name: nameController.text,
                                  priority: false,
                                  dueDate: dueDateController.text,
                                  isCompleted: false);
                              Provider.of<ChoreListViewModel>(context,
                                      listen: false)
                                  .addChore(newChore, selectedAssignee);
                              Provider.of<ChoreListViewModel>(context,
                                      listen: false)
                                  .writeData(widget.housekey);
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, choreListRoute,
                                  arguments: SessionData.data(
                                      widget.username, widget.housekey));
                            }),
                      ),
                    ]),

                const Text('New Chore',
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
                        labelText: 'Name your Chore'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Assign User Dropdown
                Consumer<ChoreListViewModel>(
                    builder: (context, choreList, child) {
                  var householdMembers = choreList.usernames;
                  return DropdownButtonFormField<String>(
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
                  );
                }),

                /*  SizedBox(
                width: 1500,
                child: TextField(
                  controller: assignUserController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Assign User'),
                ),
              ), */
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null && selectedDate != dueDate) {
                      setState(() {
                        dueDate = selectedDate;
                        dueDateController.text =
                            '${dueDate!.month}/${dueDate!.day}/${dueDate!.year}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      width: 1500,
                      child: TextField(
                        controller: dueDateController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Due Date',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1500,
                  child: DropdownButton<String>(
                    value: reminderController.text.isEmpty
                        ? null
                        : reminderController.text,
                    items: const [
                      DropdownMenuItem<String>(
                        value: '1 hour',
                        child: Text('1 hour'),
                      ),
                      DropdownMenuItem<String>(
                        value: '1 day',
                        child: Text('1 day'),
                      ),
                      DropdownMenuItem<String>(
                        value: '1 week',
                        child: Text('1 week'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'custom',
                        child: Text('custom'),
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
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1500,
                  child: TextField(
                    controller: noteController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Note'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 1500,
                  child: TextField(
                    controller: pointsController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Points'),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
