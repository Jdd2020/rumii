import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  final String user;
  final ShopViewModel shop;
  final String lastItem;
  final String housekey;
  final List<String> householdMembers = [];
  final String username;

  EditItem(
      {Key? key,
      required this.user,
      required this.shop,
      required this.lastItem,
      required this.housekey,
      required this.username})
      : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController itemController;
  late TextEditingController assignUserController;
  late TextEditingController quantityController;
//  late TextEditingController typeController;
  late String selectedType = '';
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
    //  typeController = TextEditingController(text: widget.shop.type);
    selectedAssignee = widget.user;
    selectedType = widget.shop.type;

    Provider.of<ShoppingListViewModel>(context, listen: false)
        .getData(widget.housekey);
  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    //  typeController.dispose();
    notesController.dispose();
    assignUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: InkWell(
                    onTap: () {
                      Provider.of<ShoppingListViewModel>(context, listen: false)
                          .deleteItem(widget.user, widget.shop.name);
                      Provider.of<ShoppingListViewModel>(context, listen: false)
                          .addItem(
                              Shop(
                                isCompleted: false,
                                name: itemController.text,
                                notes: notesController.text,
                                quantity: int.parse(quantityController.text),
                                type: selectedType,

                                //type: typeController.text
                              ),
                              widget.user);
                      Provider.of<ShoppingListViewModel>(context, listen: false)
                          .writeData(widget.housekey);
                      Navigator.pushNamed(context, shopListRoute,
                          arguments: SessionData.data(
                              widget.username, widget.housekey));
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
              buildEditableTextField("Item", itemController),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Type',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                  const SizedBox(height: 3),
                  buildTypeIcons(),
                ],
              ),
              const SizedBox(height: 20),
              buildEditableTextField("Assigned user", assignUserController),
              buildEditableTextField("Quantity", quantityController),
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
                          .writeData(widget.housekey);
                      Navigator.pushNamed(context, shopListRoute,
                          arguments: SessionData.data(
                              widget.username, widget.housekey));
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
              Consumer<ShoppingListViewModel>(
                builder: (context, shopList, child) {
                  var householdMembers = shopList.usernames;

                  return Expanded(
                    child: label == 'Assigned user'
                        ? DropdownButtonFormField<String>(
                            value: householdMembers.contains(controller.text)
                                ? controller.text
                                : householdMembers[0],
                            items: householdMembers.map((String member) {
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
                        : label == 'Item Type'
                            ? const SizedBox.shrink()
                            : TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildTypeIcons() {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 100, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedType = types[index]['name'];
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                0,
                8,
                index == types.length - 1 ? 0 : screenWidth * 0.03,
                8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: selectedType == types[index]['name']
                        ? Colors.pink
                        : Colors.grey,
                    child: Icon(
                      types[index]['icon'],
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 70, // Adjust the width as needed
                    child: Text(
                      types[index]['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: selectedType == types[index]['name']
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: selectedType == types[index]['name']
                            ? Colors.pink
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> types = [
  {'name': 'Eggs/Dairy', 'icon': Icons.egg_rounded},
  {'name': 'Produce', 'icon': Icons.apple_rounded},
  {'name': 'Protein', 'icon': Icons.lunch_dining_rounded},
  {'name': 'Grain', 'icon': Icons.breakfast_dining_rounded},
  {'name': 'Sweets', 'icon': Icons.cake},
  {'name': 'Beverage', 'icon': Icons.wine_bar_rounded},
  {'name': 'Snacks', 'icon': Icons.workspaces},
  {'name': 'Other', 'icon': Icons.question_mark_rounded},
];
