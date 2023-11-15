import 'package:flutter/material.dart';
import 'package:rumii/views/Chores/edit_chore_view.dart';

class ViewChore extends StatelessWidget {
  final String choreName;
  final String assignUser;
  

  ViewChore({
    required this.choreName,
    required this.assignUser,
    
  });

  // fetch additional chore details based on choreName and assignUser
  // (placeholder)
  Map<String, String> fetchChoreDetails() {
    // replace with actual data fetching logic 
    return {
      'dueDate': '2023-12-31',
      'repetition': 'Weekly',
      // ...
    };
  }

  @override
  Widget build(BuildContext context) {
    
    final Map<String, String> choreDetails = fetchChoreDetails();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Chore List'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              
              Navigator.push(
                context,
                  MaterialPageRoute(
                    builder: (context) => EditChore(chore: choreName, assignedUser: assignUser),
                    ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              'View Chore',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // chore details in a non-mutable format
            Text('Chore Name: $choreName'),
            Text('Assigned User: $assignUser'),
            Text('Due Date: ${choreDetails['dueDate']}'),
            Text('Repetition: ${choreDetails['repetition']}'),
            // rest
          ],
        ),
      ),
    );
  }
}
