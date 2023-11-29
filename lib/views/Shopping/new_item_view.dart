import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:provider/provider.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  'New Item',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add logic for "Save" button here
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ))),
              ]),
            //add other widgets
          ],
        ),
      ),
    );
  }
}
