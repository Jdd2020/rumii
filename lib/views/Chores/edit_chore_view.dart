import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/chore_model.dart';

class EditChore extends StatefulWidget {
  final String user;
  final ChoreViewModel chore;
  final String lastChore;
  final String housekey;
  final String username;

  const EditChore(
      {Key? key,
      required this.chore,
      required this.user,
      required this.lastChore,
      required this.housekey,
      required this.username})
      : super(key: key);

  @override
  _EditChoreState createState() => _EditChoreState();
}

class _EditChoreState extends State<EditChore> {
  DateTime? dueDate;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController assignUserController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController repetitionController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  String selectedAssignee = '';

  @override
  void initState() {
    super.initState();
    Provider.of<ChoreListViewModel>(context, listen: false)
        .getData(widget.housekey);
    nameController.text = widget.chore.name;
    selectedAssignee = widget.user;
    dueDateController.text = widget.chore.dueDate;
    /*
    repetitionController.text = widget.repetition;
    reminderController.text = widget.reminder;
    noteController.text = widget.note;
    pointsController.text = widget.points;
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
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
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300],
                      ),
                      child: InkWell(
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          //save changes
                          var altered = Chore(
                              name: nameController.text,
                              priority: false,
                              dueDate: dueDateController.text,
                              isCompleted: false);
                          Provider.of<ChoreListViewModel>(context,
                                  listen: false)
                              .editChore(altered, assignUserController.text,
                                  widget.lastChore);
                          Provider.of<ChoreListViewModel>(context,
                                  listen: false)
                              .writeData("DSBU781");
                          Navigator.pushNamed(context, "/chores");
                        },
                      ),
                    ),
                  ],
                ),
                const Text('Edit Chore',
                    style: (TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 5),
                Text(nameController.text,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                buildEditableTextField('Chore', nameController),
                buildEditableTextField('Assigned user', assignUserController),
                buildEditableTextField('Due Date', dueDateController),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ChoreListViewModel>(context, listen: false)
                            .deleteChore(
                                assignUserController.text, widget.lastChore);
                        Provider.of<ChoreListViewModel>(context, listen: false)
                            .writeData(widget.housekey);
                        Navigator.pushNamed(context, choreListRoute,
                            arguments: SessionData.data(
                                widget.username, widget.housekey));
                      },
                      child: const Text("Delete")),
                )
                /*
                buildEditableTextField('Repetition', repetitionController),
                buildEditableTextField('Reminder', reminderController),
                buildEditableTextField('Note', noteController),
                buildEditableTextField('Points', pointsController),
                */
              ],
            ),
          ),
        ));
  }

  Widget buildEditableTextField(
      String label, TextEditingController controller) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: label == 'Assigned user'
                    ? DropdownButtonFormField<String>(
                        value: widget.householdMembers.contains(controller.text)
                            ? controller.text
                            : widget.householdMembers[0],
                        items: widget.householdMembers.map((String member) {
                          return DropdownMenuItem<String>(
                            value: member,
                            child: Text(member),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              controller.text = newValue;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    : TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
