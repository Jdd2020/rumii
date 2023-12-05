import 'package:flutter/material.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';

class EditItem extends StatefulWidget {
  final String user;
  final ShopViewModel shop;
  final String lastItem;

  const EditItem({Key? key, 
    required this.user,
    required this.shop,
    required this.lastItem,
  }) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController itemController;
  late TextEditingController quantityController;
  late TextEditingController typeController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController(text: widget.shop.name);
    quantityController =
        TextEditingController(text: widget.shop.quantity.toString());
    notesController = TextEditingController(text: widget.shop.notes);
    typeController = TextEditingController(text: widget.shop.type);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    itemController.dispose();
    quantityController.dispose();
    typeController.dispose();
    notesController.dispose();
    super.dispose();
  }

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
                  'Edit Item',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  //save
                  Navigator.pop(context);
                },
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    )),
              ),
            ]),
            // editable text fields
            const SizedBox(height: 20),
            buildEditableTextField("Item", itemController),
            buildEditableTextField("Quantity", quantityController),
            buildEditableTextField("Type", typeController),
            buildEditableTextField("Notes", notesController),
          ],
        ),
      ),
    );
  }

  Widget buildEditableTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 1250,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
