//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:rumii/views/Chores/new_chore_view.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';

class ChoreListView extends StatefulWidget {
  final String username;
  final String housekey;
  const ChoreListView(
      {Key? key, required this.username, required this.housekey})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChoreListViewState createState() => _ChoreListViewState();
}

class _ChoreListViewState extends State<ChoreListView> {
  //ChoreListViewModel choreList = ChoreListViewModel();

  /*=
      Future<List<UserViewModel>>(() async {
    ChoreListViewModel chores = ChoreListViewModel();
    chores.getUserList("DSBU781");
    return chores.users;
  });
  */

  //Future<void> toggleChorePriority(ChoreViewModel choreViewModel) {
  //choreList.toggleChorePriority(choreViewModel);
  //}

  @override
  initState() {
    super.initState();
    Provider.of<ChoreListViewModel>(context, listen: false)
        .getData(widget.housekey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/rumii-logo.png',
            height: 28.00, width: 70.00), 
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text('Chore List',
                style: (TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ))),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                                create: (context) => ChoreListViewModel(),
                                child: NewChore(
                                  username: widget.username,
                                  housekey: widget.housekey,
                                ),
                              )),
                    )
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "+ New",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Consumer<ChoreListViewModel>(
              builder: (context, choreList, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: choreList.users.length,
                    itemBuilder: (context, index) {
                      final user = choreList.users[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: user.chores.length,
                            itemBuilder: (context, choreIndex) {
                              final chore = user.chores[choreIndex];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: ListTile(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider(
                                                create: (context) =>
                                                    ChoreListViewModel(),
                                                child: ViewChore(
                                                  chore: chore,
                                                  user: user.name,
                                                  lastChore: chore.name,
                                                  housekey: widget.housekey,
                                                  username: widget.username,
                                                ),
                                              )),
                                    )
                                  },
                                  contentPadding: const EdgeInsets.all(8.0),
                                  leading: IconButton(
                                    icon: Icon(
                                      chore.priority
                                          ? Icons.star
                                          : Icons.star_border,
                                    ),
                                    onPressed: () {
                                      choreList.toggleChorePriority(chore);
                                    },
                                  ),
                                  title: Text(chore.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Row(
                                    children: [
                                      const Text('Due Date: ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                227, 112, 112, 112),
                                          )),
                                      Text(chore.dueDate,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                227, 112, 112, 112),
                                          )),
                                    ],
                                  ),
                                  trailing: Checkbox(
                                    value: chore.isCompleted,
                                    onChanged: (value) {
                                      choreList.toggleChoreComplete(chore);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/chores',
          onRouteChanged: (route) {
            Provider.of<ChoreListViewModel>(context, listen: false)
                .writeData(widget.housekey);
            Navigator.pushNamed(context, route,
                arguments: SessionData.data(widget.username, widget.housekey));
          }),
    );
  }
}
