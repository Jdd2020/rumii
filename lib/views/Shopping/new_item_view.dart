import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 


class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

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
  final List<String> householdMembers = ['Henry', 'Josh', 'Billy'];

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
    //assignUserController = TextEditingController();
    quantityController = TextEditingController();
    notesController = TextEditingController();
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
                fontWeight: selectedType == type ? FontWeight.bold : FontWeight.normal,
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
  
            const SizedBox(height: 20),
              const Text('New Item',
                  style: (TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ))),

              const SizedBox(height: 20),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                    child: const Text('Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () => {Navigator.pop(context)}),
                InkWell(
                    child: const Text('Save',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () async {
                      Navigator.pop(context);
                    }),
              ]),
              const SizedBox(
                height: 30,
              ),

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

          Column ( 
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
                  return buildTypeItem(types[index]['name'], types[index]['icon'], context);
                },
              ),
            ),
          ],),
            const SizedBox(height: 20),

            // Assign User Dropdown
            DropdownButtonFormField<String>(
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
            ),

            const SizedBox(height: 20),

            // Quantity Text Field
            TextFormField(
              controller: quantityController,
              onChanged: (value) {
                // handle quantity changes
              },
              decoration: const InputDecoration(
                labelText: 'Quantity',
                hintText: '#'
              ),
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
                margin: const EdgeInsets.symmetric(
                    vertical: 10),
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
