import 'package:rumii/models/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class EditHouseholdViewModel extends ChangeNotifier {
  List<String> householdMembers = [];
  late Map<String, dynamic> choreData;
  late String currentHouseKey = "";

  EditHouseholdViewModel() {
    loadChoreData();
  }

Future<void> loadChoreData() async {
  try {
    // load data
    String jsonString = await rootBundle.loadString('assets/choreDB.json');
    choreData = json.decode(jsonString);

    currentHouseKey = choreData.keys.first;

    householdMembers = [];
    choreData[currentHouseKey]?.forEach((personName, _) {
      householdMembers.add(personName);
    });

    notifyListeners();
  } catch (error) {
    print('Error loading chore data: $error');
  }
}

  void deleteUser(String userName) {
    householdMembers.remove(userName);

    choreData[currentHouseKey]?.remove(userName);

    notifyListeners();
  }

  void showAddNewDialog(BuildContext context) {

    String shareLink = 'https://example.com/join/$currentHouseKey';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Household Member'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('House Key: $currentHouseKey', style: const TextStyle(fontWeight: FontWeight.bold)),
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