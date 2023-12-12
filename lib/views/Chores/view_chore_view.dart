import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/views/Chores/edit_chore_view.dart';
import 'package:provider/provider.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';

class ViewChore extends StatefulWidget {
  final ChoreViewModel chore;
  final String user;
  final String lastChore;
  final String housekey;
  final String username;

  const ViewChore(
      {Key? key,
      required this.chore,
      required this.user,
      required this.lastChore,
      required this.housekey,
      required this.username})
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            onTap: () => {
                                  Navigator.pop(context),
                                }),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        child: InkWell(
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
                                                  lastChore: widget.lastChore,
                                                  housekey: widget.housekey,
                                                  username: widget.username),
                                            )),
                                  )
                                }),
                      ),
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
                buildInfoRow('Note', widget.chore.note.toString()),
                buildInfoRow('Repetition', widget.chore.isRecurring.toString()),
                buildInfoRow('Reminder', widget.chore.remind.toString()),
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
              color: const Color.fromARGB(207, 220, 220, 220),
            ),
            child: Text(value),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
