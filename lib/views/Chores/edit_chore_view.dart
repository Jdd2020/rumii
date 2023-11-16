import 'package:flutter/material.dart';
//import 'package:rumii/views/Chores/chore_list_view.dart';

// EditChore View
class EditChore extends StatelessWidget {

  final String chore;
  final String assignedUser;

  const EditChore({Key? key, required this.chore, required this.assignedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
        const SizedBox(height: 40),
        const Text('Edit Chore',
              style: (TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ))),
        const SizedBox(height:5),
        Text("$chore", style: const TextStyle(
          fontSize: 20,
        )),
        const SizedBox(height: 20),
        ]),
      )
    );
  }
}