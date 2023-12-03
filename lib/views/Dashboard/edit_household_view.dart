import 'package:flutter/material.dart';
import 'dart:convert';

class EditHousehold extends StatefulWidget {
  const EditHousehold({Key? key}) : super(key: key);

  @override
  _EditHouseholdState createState() => _EditHouseholdState();
}

class _EditHouseholdState extends State<EditHousehold> {
  List<String> householdMembers = [];
  late Map<String, dynamic> choreData;
  bool deleteMode = false;
  late String currentHouseKey = "";

  @override
  void initState() {
    super.initState();
    _loadChoreData();
  }

  Future<void> _loadChoreData() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/choreDB.json');
    choreData = json.decode(jsonString);

    currentHouseKey = choreData.keys.first;

    choreData.forEach((houseKey, members) {
      householdMembers.addAll(members.keys);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Household'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 35, 16, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 30.0,
            childAspectRatio: 1.0,
          ),
          itemCount: householdMembers.length + 1,
          itemBuilder: (context, index) {
            if (index == householdMembers.length) {
              return GestureDetector(
                onTap: () {
                  _showAddNewDialog();
                },
              child: Column(
                children: [
                 // _buildAddUserCircle(),
                  const SizedBox(height: 55.0),
                  Text(
                    'Add New + \n',
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(0.0,0.4),
                          blurRadius: 1.0,
                        )
                      ]
                    ),
                  ),
                ],
              ),
              );
              
            }
            return Column(
              children: [
                _buildUserCircle(householdMembers[index], index),
                const SizedBox(height: 8.0),
                Text(
                  householdMembers[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserCircle(String userName, int index) {
    return GestureDetector(
      onTap: () {
        if (deleteMode) {
          _showDeleteConfirmationDialog(userName);
        } else {
          // Handle user click (optional)
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.pink, // Outline color
            width: 2.0,
          ),
          color: Colors.grey[200], // Filled color
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                userName.substring(0, 1), // Display the first initial
                style: const TextStyle(
                  color: Colors.grey, // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment(1.15, -1.15),
              child: GestureDetector(
                onTap: () {
                  _showDeleteConfirmationDialog(userName);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
  Widget _buildAddUserCircle() {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255), // Outline color
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(

          )
            onPressed: () {
              // Handle the "Add User" button press
              // Implement your logic for adding a new user here
            },
          ),
        ],
      ),
    );
  }*/

  Future<void> _showDeleteConfirmationDialog(String userName) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Household Member'),
          content: Text('Are you sure you want to remove $userName from the household?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteUser(userName);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(String userName) {
    setState(() {
      householdMembers.remove(userName);
    });
  }

  void _showAddNewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Generate the house key and share link here
        
        String shareLink = 'https://example.com/join/$currentHouseKey'; // Replace with your logic for generating the share link

        return AlertDialog(
          title: const Text('Add New Household Member'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('House Key: $currentHouseKey', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text('Share Link: $shareLink'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

}

