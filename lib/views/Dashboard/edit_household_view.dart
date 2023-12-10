import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:rumii/viewmodels/edit_household_view_model.dart';

class EditHousehold extends StatefulWidget {
  final String housekey;
  const EditHousehold({Key? key, required this.housekey}) : super(key: key);

  @override
  _EditHouseholdState createState() => _EditHouseholdState();
}

class _EditHouseholdState extends State<EditHousehold> {
  List<String> householdMembers = [];
  late Map<String, dynamic> choreData;
  late String currentHouseKey;

  final EditHouseholdViewModel _editHouseholdViewModel = EditHouseholdViewModel();

  @override
  void initState() {
    super.initState();
    currentHouseKey = widget.housekey;
    _loadChoreData();
  }

  Future<void> _loadChoreData() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/choreDB.json');
    choreData = json.decode(jsonString);

    if (choreData.containsKey(currentHouseKey)) {
      Map<String, dynamic> members = choreData[currentHouseKey];
      householdMembers = members.keys.toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text('Edit Household',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    )),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: householdMembers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _buildUserCircle(householdMembers[index], index),
                        const SizedBox(height: 8.0),
                        Text(
                          householdMembers[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: Color.fromARGB(0, 0, 0, 0),
                          width: 0,
                        ),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.pink),
                  ),
                  child: const Text(
                    '+ Add Household Member',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18.0,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.4),
                            blurRadius: 1.0,
                          )
                        ]),
                  ),
                  onPressed: () {
                    _showAddNewDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCircle(String userName, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.pink,
          width: 2.0,
        ),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: _getUserImageWidget(userName, _editHouseholdViewModel),
          ),
          Align(
            alignment: const Alignment(1.15, -1.15),
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
    );
  }

  Future<void> _showDeleteConfirmationDialog(String userName) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Household Member'),
          content: Text(
              'Are you sure you want to remove $userName from the household?'),
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
        String shareLink = 'https://example.com/join/$currentHouseKey';

        return AlertDialog(
          title: const Text('Add New Household Member'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('House Key: $currentHouseKey',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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

Widget _getUserImageWidget(String userName, EditHouseholdViewModel editHouseholdViewModel) {
    return FutureBuilder<String?>(
      future: editHouseholdViewModel.getUserImage(userName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else {
            if (snapshot.data != null) {
              return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/${snapshot.data}'),
                  fit: BoxFit.cover,
                ),
              ),);
            } else {
              return Text(
                  userName.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
              );
            }
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
