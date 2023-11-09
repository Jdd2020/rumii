import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {

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
              Text('Shopping'),
            ])),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentRoute: '/shopping_list', 
              onRouteChanged: (route) {
                Navigator.of(context).pushNamed(route); // navigate to a different view
              } 
            ),
      );
  }
}
