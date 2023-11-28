import 'package:flutter/material.dart';
import 'package:rumii/models/user_model.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/views/Chores/edit_chore_view.dart';
import 'chore_list_view.dart';
import 'package:provider/provider.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';

class ViewChore extends StatefulWidget {
  final ChoreViewModel chore;
  final String user;
  final String lastChore;

  const ViewChore(
      {Key? key,
      required this.chore,
      required this.user,
      required this.lastChore})
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
                                Navigator.pushNamed(context, "/chores"),
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
                                      builder: (_) => ChangeNotifierProvider(
                                            create: (context) =>
                                                ChoreListViewModel(),
                                            child: EditChore(
                                                chore: widget.chore,
                                                user: widget.user,
                                                lastChore: widget.lastChore),
                                          )),
                                )
                              }),
                    ]),
                const Text('View Chore',
                    style: (TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 5),
                Text(widget.chore.name,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                buildInfoRow('Chore', widget.chore.name),
                buildInfoRow('Assigned', widget.user),
                buildInfoRow('Due Date', widget.chore.dueDate),
                //buildInfoRow('Repetition', widget.repetition),
                // buildInfoRow('Reminder', widget.reminder),
                //buildInfoRow('Note', widget.note),
                //buildInfoRow('Points', widget.points),
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
