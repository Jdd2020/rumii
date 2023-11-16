import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/edit_chore_view.dart';
import 'chore_list_view.dart';

class ViewChore extends StatefulWidget {
  final String choreName;
  final String assignUser;
  final String note;
  final String dueDate;
  final String repetition;
  final String reminder;
  final String points;

  const ViewChore(
      {Key? key,
      required this.choreName,
      required this.assignUser,
      required this.note,
      required this.dueDate,
      required this.repetition,
      required this.reminder,
      required this.points})
      : super(key: key);

  @override
  _ViewChoreState createState() => _ViewChoreState();
}

class _ViewChoreState extends State<ViewChore> {
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
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChoreListView())),
                              }),
                      InkWell(
                          child: const Text('Edit',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditChore(
                                              choreName: widget.choreName,
                                              assignUser: widget.assignUser,
                                              dueDate: widget.dueDate,
                                              repetition: widget.repetition,
                                              reminder: widget.reminder,
                                              note: widget.note,
                                              points: widget.points,
                                            )))
                              }),
                    ]),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 30),
                buildInfoRow('Chore', widget.choreName),
                buildInfoRow('Assigned', widget.assignUser),
                buildInfoRow('Due Date', widget.dueDate),
                buildInfoRow('Repetition', widget.repetition),
                buildInfoRow('Reminder', widget.reminder),
                buildInfoRow('Note', widget.note),
                buildInfoRow('Points', widget.points),
              ],
            ),
          ),
        ));
  }

  Widget buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 1500,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.grey.shade300,
            ),
            child: Text(value),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
