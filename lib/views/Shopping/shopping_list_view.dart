import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/views/Shopping/new_item_view.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';

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
        title: Image.asset('assets/images/rumii-logo.png',
            height: 28.00, width: 70.00), //const Text("Rumii"),
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
                const Text('Shopping List',
                    style: (TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      padding: EdgeInsets.all(3),
                      child: const Text(
                        "+",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => ShoppingListViewModel(),
                                  child: const NewItem(),
                                )),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // add the list
              ])),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/shopping_list',
          onRouteChanged: (route) {
            Navigator.of(context)
                .pushNamed(route); // navigate to a different view
          }),
    );
  }
}
