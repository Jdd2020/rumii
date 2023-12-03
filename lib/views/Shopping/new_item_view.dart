import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  late TextEditingController itemController;
  late TextEditingController assignUserController;
  late TextEditingController quantityController;
  late TextEditingController notesController;
  late TextEditingController typeController;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
    assignUserController = TextEditingController();
    quantityController = TextEditingController();
    notesController = TextEditingController();
    typeController = TextEditingController();
  }

  @override
  void dispose() {
    itemController.dispose();
    assignUserController.dispose();
    quantityController.dispose();
    notesController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cancel Button at the top
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'New Item',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Item Text Field
            TextField(
              controller: itemController,
              onChanged: (value) {
                // Handle item changes
              },
              decoration: InputDecoration(labelText: 'Item Name'),
            ),

            const SizedBox(height: 20),

            // Assign User Text Field
            TextField(
              controller: assignUserController,
              onChanged: (value) {
                // Handle assign user changes
              },
              decoration: InputDecoration(labelText: 'Assign User'),
            ),

            const SizedBox(height: 20),

            // Quantity Text Field
            TextField(
              controller: quantityController,
              onChanged: (value) {
                // Handle quantity changes
              },
              decoration: InputDecoration(labelText: 'Quantity'),
            ),

            const SizedBox(height: 20),

            // Type Dropdown Menu
            DropdownButton<String>(
              hint: const Text('Type'),
              value:
                  typeController.text.isNotEmpty ? typeController.text : null,
              items: [
                'Dairy',
                'Protein',
                'Grain',
                'Sweets',
                'Beverage',
                'Other'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle dropdown value change
                setState(() {
                  typeController.text = newValue ?? '';
                });
              },
            ),
            const SizedBox(height: 20),

            // Notes
            Expanded(
              child: TextField(
                controller: notesController,
                maxLines: null, // Allows multiline input
                onChanged: (value) {
                  // Handle notes changes
                },
                decoration: InputDecoration(labelText: 'Notes'),
              ),
            ),

            // Image Preview
            //find a way to display the item's image

            // Spacer to create space between Cancel and Submit
            const Spacer(),

            // Submit Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  onPressed: () {
                    // Add logic for "Submit" button
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
