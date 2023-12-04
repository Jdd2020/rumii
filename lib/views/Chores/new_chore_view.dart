import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/chore_model.dart';

// NewChore View
class NewChore extends StatefulWidget {
  const NewChore({Key? key}) : super(key: key);

  @override
  _NewChoreState createState() => _NewChoreState();
}

class _NewChoreState extends State<NewChore> {
  DateTime? dueDate;
  ChoreListViewModel choreList = ChoreListViewModel();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController assignUserController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController repetitionController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();

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
    Provider.of<ChoreListViewModel>(context, listen: false).getData("DSBU781");
  }

  @override
  void dispose() {
    nameController.dispose();
    assignUserController.dispose();
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
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              const SizedBox(height: 40),
              const Text('New Chore',
                  style: (TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ))),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                    child: const Text('Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () => {Navigator.pop(context)}),
                InkWell(
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
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .addChore(newChore, assignUserController.text);
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .writeData("DSBU781");
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("/chores");
                    }),
              ]),
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
              SizedBox(
                width: 1500,
                child: TextField(
                  controller: assignUserController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Assign User'),
                ),
              ),
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
        ));
  }
}
