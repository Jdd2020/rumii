import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';

// EditChore View
class EditChore extends StatelessWidget {

  final String chore;
  final String assignedUser;

  const EditChore({Key? key, required this.chore, required this.assignedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Text('Edit ${chore}'), 
    );
  }
}