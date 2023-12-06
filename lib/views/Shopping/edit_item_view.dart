import 'package:flutter/material.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController assignUserController;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController(text: widget.shop.name);
    quantityController =
        TextEditingController(text: widget.shop.quantity.toString());
    notesController = TextEditingController(text: widget.shop.notes);
    typeController = TextEditingController(text: widget.shop.type);
    assignUserController = TextEditingController(text: widget.user);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    itemController.dispose();
    quantityController.dispose();
    typeController.dispose();
    notesController.dispose();
    assignUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding (
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
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
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                  'Edit Item',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            
            // editable text fields
            const SizedBox(height: 20),
            buildEditableTextField("Item", itemController),
            buildEditableTextField("Assigned user", assignUserController),
            buildEditableTextField("Quantity", quantityController),
            buildEditableTextField("Type", typeController),
            buildEditableTextField("Notes", notesController),
            const SizedBox(height: 20),
            SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ShoppingListViewModel>(context, listen: false)
                            .deleteItem(
                                assignUserController.text, widget.lastItem);
                        Provider.of<ShoppingListViewModel>(context, listen: false)
                            .writeData("DSBU781");
                        Navigator.pushNamed(context, "/shopping_list");
                      },
                      child: const Text("Delete")),
                ),
          ],
        ),
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
          height: 45,
          width: 1250,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Align (
              alignment: Alignment.center,
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
