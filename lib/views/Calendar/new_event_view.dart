import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  
  CalendarViewModel _calendarViewModel = CalendarViewModel();
  final TextEditingController nameController = TextEditingController();

  //users
  late String selectedAssignee = '';
  final List<String> householdMembers = ['Henry', 'Josh', 'Billy'];

  @override
  void initState() {
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container (
                  padding: const EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Colors.grey[300],
                  ),
                child: InkWell(
                    child: const Text('Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () => {Navigator.pop(context)}),
                ),
                Container(
                padding: EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Colors.grey[300],
                  ),
                child: InkWell(
                    child: const Text('Save',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () async {
                      /*
                      var newChore = Chore(
                          name: nameController.text,
                          priority: false,
                          dueDate: dueDateController.text,
                          isCompleted: false);
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .addChore(newChore, selectedAssignee);
                      Provider.of<ChoreListViewModel>(context, listen: false)
                          .writeData("DSBU781");
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("/chores");*/
                    }),
                ),
              ]),
              
              const Text('New Event',
                  style: (TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ))),
              const SizedBox(height: 20),
              
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 1500,
                child: TextField(
                  controller: nameController,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name your Event'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
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
            ],
          ),
          ),
          ),
        ),
          );

  }
}