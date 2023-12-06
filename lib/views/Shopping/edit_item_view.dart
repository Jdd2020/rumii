import 'package:flutter/material.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';

class EditItem extends StatefulWidget {
  final String user;
  final ShopViewModel shop;
  final String lastItem;
  final List<String> householdMembers = ['Henry', 'Josh', 'Billy'];

  EditItem({
    Key? key,
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
    assignUserController.dispose();
    quantityController.dispose();
    typeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              // Editable text fields
              const SizedBox(height: 20),
              buildEditableTextField("Item", itemController),
              buildEditableTextField("Assign User", assignUserController),
              buildEditableTextField("Quantity", quantityController),
              buildEditableTextField("Type", typeController),
              buildEditableTextField("Notes", notesController),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the delete logic
                  },
                  child: const Text("Delete"),
                ),
              ),
              const SizedBox(height: 20),
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
        const SizedBox(height: 6),
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
