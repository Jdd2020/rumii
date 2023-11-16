import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';

class EditChore extends StatefulWidget {
  final String choreName;
  final String assignUser;
  final String note;
  final String dueDate;
  final String repetition;
  final String reminder;
  final String points;

  const EditChore({
    Key? key,
    required this.choreName,
    required this.assignUser,
    required this.note,
    required this.dueDate,
    required this.repetition,
    required this.reminder,
    required this.points,
  }) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    nameController.text = widget.choreName;
    assignUserController.text = widget.assignUser;
    dueDateController.text = widget.dueDate;
    repetitionController.text = widget.repetition;
    reminderController.text = widget.reminder;
    noteController.text = widget.note;
    pointsController.text = widget.points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const Text('Cancel',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      onTap: () => Navigator.pop(context),
                    ),
                    InkWell(
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        //save changes
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Text('Edit Chore',
                    style: (TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 5),
                Text(widget.choreName,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                buildEditableInfoRow('Chore', nameController),
                buildEditableInfoRow('Assigned', assignUserController),
                buildEditableInfoRow('Due Date', dueDateController),
                buildEditableInfoRow('Repetition', repetitionController),
                buildEditableInfoRow('Reminder', reminderController),
                buildEditableInfoRow('Note', noteController),
                buildEditableInfoRow('Points', pointsController),
              ],
            ),
          ),
        ));
  }

  Widget buildEditableInfoRow(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: 1,
          obscureText: false,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10), // Adjust internal padding
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
