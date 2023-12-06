import 'package:flutter/material.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  final String user;
  final ShopViewModel shop;
  final String lastItem;
  final List<String> householdMembers = ['Henry', 'Josh', 'Billy'];

  EditItem({Key? key, 
    required this.user,
    required this.shop,
    required this.lastItem,
  }) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController itemController;
  late TextEditingController assignUserController;
  late TextEditingController quantityController;
  late TextEditingController typeController;
  late TextEditingController notesController;
  String selectedAssignee = '';

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController(text: widget.shop.name);
    assignUserController = TextEditingController(text: widget.user);
    quantityController =
        TextEditingController(text: widget.shop.quantity.toString());
    notesController = TextEditingController(text: widget.shop.notes);
    typeController = TextEditingController(text: widget.shop.type);
    selectedAssignee = widget.user;
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
              Container (
                padding: const EdgeInsets.fromLTRB(10,2,10,2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                  color: Colors.grey[300],
                ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),),
              Container (
                padding: const EdgeInsets.fromLTRB(10,2,10,2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                  color: Colors.grey[300],
                ),
              child: InkWell(
                onTap: () {
                  //save
                  Navigator.pop(context);
                },
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    )),
              ),
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
         const SizedBox(height: 2),
        Container(
          width: MediaQuery.of(context).size.width * 0.98,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: label == "Assign User"
                    ? DropdownButtonFormField<String>(
                        value: controller.text,
                        items: widget.householdMembers.map((String member) {
                          return DropdownMenuItem<String>(
                            value: member,
                            child: Text(member),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              controller.text = newValue;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    : TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
            ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
