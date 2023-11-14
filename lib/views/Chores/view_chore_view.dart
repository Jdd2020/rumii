import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';

//ViewChore View
class ViewChore extends StatelessWidget {
  final Chore chore;

  const ViewChore({Key? key, required this.chore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
        Text(chore.name)
      )
    );
  }
}