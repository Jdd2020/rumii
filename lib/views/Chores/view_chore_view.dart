import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/edit_chore_view.dart';
import 'chore_list_view.dart';

class ViewChore extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
                child: const Text('Cancel',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoreListView()))
                    }),
            /*InkWell(
                child: const Text('Edit',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditChore(
                                    choreName: '',
                                    assignUser: '',
                                    note: '',
                                    dueDate: '',
                                    repetition: '',
                                    reminder: '',
                                    points: '',
                                  )))
                    }),*/
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Chore',
              style: TextStyle(
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
                  child: Text(choreName),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Assigned',
              style: TextStyle(
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
                  child: Text(assignUser),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Due Date',
              style: TextStyle(
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
                  child: Text(dueDate),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Repetition',
              style: TextStyle(
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
                  child: Text(repetition),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Reminder',
              style: TextStyle(
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
                  child: Text(reminder),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Note',
              style: TextStyle(
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
                  child: Text(note),
                ))
          ]),
          const SizedBox(
            height: 30,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Points',
              style: TextStyle(
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
                  child: Text(points),
                ))
          ]),
        ]),
      ),
    );
  }
}
