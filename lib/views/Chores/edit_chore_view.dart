import 'package:flutter/material.dart';
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

  const EditChore({
    Key? key,
    required this.chore,
    required this.user,
    required this.lastChore,
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
    Provider.of<ChoreListViewModel>(context, listen: false).getData("DSBU781");
    nameController.text = widget.chore.name;
    assignUserController.text = widget.user;
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
                        var altered = Chore(
                            name: nameController.text,
                            priority: false,
                            dueDate: dueDateController.text,
                            isCompleted: false);
                        Provider.of<ChoreListViewModel>(context, listen: false)
                            .editChore(altered, assignUserController.text,
                                widget.lastChore);
                        Provider.of<ChoreListViewModel>(context, listen: false)
                            .writeData("DSBU781");
                        Navigator.pushNamed(context, "/chores");
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
                Text(nameController.text,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                buildEditableInfoRow('Chore', nameController),
                buildEditableInfoRow('Assigned', assignUserController),
                buildEditableInfoRow('Due Date', dueDateController),
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
                            .writeData("DSBU781");
                        Navigator.pushNamed(context, "/chores");
                      },
                      child: const Text("Delete")),
                )
                /*
                buildEditableInfoRow('Repetition', repetitionController),
                buildEditableInfoRow('Reminder', reminderController),
                buildEditableInfoRow('Note', noteController),
                buildEditableInfoRow('Points', pointsController),
                */
              ],
            ),
          ),
        ));
  }

  Widget buildEditableInfoRow(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 2),
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
