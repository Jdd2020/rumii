import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/models/shop_model.dart';

class NewItem extends StatefulWidget {
  final String housekey;
  final String username;
  const NewItem({Key? key, required this.username, required this.housekey})
      : super(key: key);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  late TextEditingController itemController;
  //late TextEditingController assignUserController;
  late String selectedAssignee = '';
  late TextEditingController quantityController;
  late TextEditingController notesController;
  //late TextEditingController typeController;
  late String selectedType = '';
  List<String> householdMembers = [];

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
    //assignUserController = TextEditingController();
    quantityController = TextEditingController();
    notesController = TextEditingController();

    Provider.of<ShoppingListViewModel>(context, listen: false)
        .getData(widget.housekey);
    //typeController = TextEditingController();
    selectedType = '';
    selectedAssignee = householdMembers.isNotEmpty ? householdMembers[0] : '';
  }

  @override
  void dispose() {
    itemController.dispose();
    //assignUserController.dispose();
    quantityController.dispose();
    notesController.dispose();
    //typeController.dispose();
    super.dispose();
  }

  Widget buildTypeItem(String type, IconData icon, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
        });
      },
      child: Container(
        height: 100, // Adjust the height as needed
        margin: EdgeInsets.fromLTRB(0, 8, screenWidth * 0.03, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: selectedType == type ? Colors.pink : Colors.grey,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Container(
              width: 70, // Adjust the width as needed
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selectedType == type
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selectedType == type ? Colors.pink : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: const Text('Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
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
                        var item = Shop(
                            name: itemController.text,
                            notes: notesController.text,
                            quantity: int.parse(quantityController.text),
                            type: selectedType,
                            isCompleted: false);
                        Provider.of<ShoppingListViewModel>(context,
                                listen: false)
                            .addItem(item, selectedAssignee);
                        Provider.of<ShoppingListViewModel>(context,
                                listen: false)
                            .writeData(widget.housekey);
                        Navigator.pushNamed(context, shopListRoute,
                            arguments: SessionData.data(
                                widget.username, widget.housekey));
                      },
                      child: const Text('Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),

              const Text('New Item',
                  style: (TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ))),

              const SizedBox(height: 20),

              // Item Text Field
              TextFormField(
                controller: itemController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'Enter item name',
                ),
                onChanged: (value) {
                  // handle item changes
                },
              ),

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
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        return buildTypeItem(types[index]['name'],
                            types[index]['icon'], context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Assign User Dropdown
              Consumer<ShoppingListViewModel>(
                  builder: (context, shopList, child) {
                var householdMembers = shopList.usernames;
                return DropdownButtonFormField<String>(
                  value: householdMembers.contains(selectedAssignee)
                      ? selectedAssignee
                      : null,
                  items: householdMembers.map((member) {
                    return DropdownMenuItem<String>(
                      value: member,
                      child: Text(member),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedAssignee = newValue;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Assign User',
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Quantity Text Field
              TextFormField(
                controller: quantityController,
                onChanged: (value) {
                  // handle quantity changes
                },
                decoration:
                    const InputDecoration(labelText: 'Quantity', hintText: '#'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),

              // Type Dropdown Menu
              /*
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
            ),*/
              const SizedBox(height: 2),

              // Notes
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: notesController,
                    maxLines: 5,
                    minLines: 1,
                    onChanged: (value) {
                      // handle notes changes
                    },
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      hintText:
                          'e.g. Mention any dietary restrictions or preferences such as flavor, brand, etc.',
                    ),
                  ),
                ),
              ),

              // Image Preview
              //find a way to display the item's image
            ],
          ),
        ),
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
  {'name': 'Other', 'icon': Icons.question_mark_rounded},
];
