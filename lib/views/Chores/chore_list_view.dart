import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';
import 'package:rumii/views/Chores/new_chore_view.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';


class ChoreListView extends StatefulWidget {
  const ChoreListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChoreListViewState createState() => _ChoreListViewState();
}

class _ChoreListViewState extends State<ChoreListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/rumii-logo.png', height: 28.00, width: 70.00), //const Text("Rumii"),
          centerTitle: true,
          automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            const SizedBox(height: 10),
            const Text('Chore List', style: (TextStyle(fontSize: 26, fontWeight: FontWeight.bold,))),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    child: const Text(
                      "+ New",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewChore()
                              ),
                            )
                          },
                        ),
                      ),
                      const SizedBox(height:20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(color: Colors.black,),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: user.chores.length,
                                  itemBuilder: (context, choreIndex) {
                                    final chore = user.chores[choreIndex];
                                    return InkWell(
                                      onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewChore(choreName: chore.name, assignUser: ""),
                                            ),
                                          )
                                        },
                                      child: Padding (
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              chore.priority
                                                ? Icons.star
                                                : Icons.star_border,
                                            ),
                                            onPressed: () {
                                              //toggle priority
                                              setState(() {
                                                chore.priority = !chore.priority;
                                              });
                                            },
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(chore.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                            
                                                Row(
                                                  children: [
                                                    const Text('Due Date: ', style: TextStyle(color: Color.fromARGB(227, 112, 112, 112),)),
                                                    Text(chore.dueDate, style: TextStyle(color: Color.fromARGB(227, 112, 112, 112),)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                            Spacer(),
                                            Checkbox(
                                              value: chore.isCompleted,
                                              onChanged: (value) {
                                                setState(() {
                                                  chore.isCompleted = value ?? false;
                                                });
                                              },
                                            ),
                                        ],
                                      ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }
                        ) ,)
          ]),),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/chores',
          onRouteChanged: (route) {
            Navigator.of(context)
                .pushNamed(route); // navigate to a different view
          }),
    );
  }
}

class User {
  final String name;
  final List<Chore> chores;

  User({required this.name, required this.chores});
}

class Chore {
  bool priority;
  String name;
  String dueDate;
  bool isCompleted;

  Chore({
    required this.priority,
    required this.name,
    required this.dueDate,
    required this.isCompleted,
  });
}

// Example data
List<User> users = [
  User(
    name: 'Henry',
    chores: [
      Chore(priority: true, name: 'Wash the Dishes', dueDate: '11-16-2023', isCompleted: false),
      Chore(priority: false, name: 'Vaccuum the Living Room', dueDate: '11-16-2023', isCompleted: false),
      Chore(priority: false, name: 'Wipe Down Bathroom', dueDate: '11-19-2023', isCompleted: false),
    ],
  ),
  User(
    name: 'Josh',
    chores: [
      Chore(priority: true, name: "Clean Soccer Uniforms", dueDate: '11-16-2023', isCompleted: false),
      Chore(priority: false, name: "Meal Prep for the Week", dueDate: '11-26-2023', isCompleted: false),
    ],
  ),
  User(
    name: 'Billy',
    chores: [
      Chore(priority: false, name: "Do Laundry", dueDate: '11-16-2023', isCompleted: false),
      Chore(priority: false, name: "Take Out the Trash", dueDate: '11-26-2023', isCompleted: false),
    ],
  ),
];