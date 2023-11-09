import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

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
          title: const Text("Rumii"),
          automaticallyImplyLeading: false
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Column(children: <Widget>[
              Text('Chore List'),
            ])),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentRoute: '/chores', 
              onRouteChanged: (route) {
                Navigator.of(context).pushNamed(route); // navigate to a different view
              } 
            ),
      );
  }
}
