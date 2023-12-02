import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/views/Shopping/new_item_view.dart';
import 'package:rumii/views/Shopping/view_item_view.dart';
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
    Provider.of<ShoppingListViewModel>(context, listen: false)
        .getData("DSBU781");
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
                      fontSize: 40,
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
            Consumer<ShoppingListViewModel>(
                builder: (context, shopList, child) {
              return Expanded(
                child: ListView.separated(
                  itemCount: shopList.users.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, userIndex) {
                    final user = shopList.users[userIndex];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  user.name[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.black),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user.shopItems.length,
                          itemBuilder: (context, itemIndex) {
                            final item = user.shopItems[itemIndex];
                            return _buildShoppingItem(item);
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentRoute: '/shopping_list',
        onRouteChanged: (route) {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }

  Widget _buildShoppingItem(ShopViewModel item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewItem(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      item.notes,
                      style: const TextStyle(
                        color: Color.fromARGB(227, 112, 112, 112),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Checkbox(
              value: item.isCompleted,
              onChanged: (value) {
                setState(() {
                  //item.isCompleted = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Fake data
class User {
  final String name;
  final List<ShoppingItem> shoppingItems;

  User({required this.name, required this.shoppingItems});
}

class ShoppingItem {
  String itemName;
  bool isChecked;

  ShoppingItem({
    required this.itemName,
    required this.isChecked,
  });
}

List<User> users = [
  User(
    name: 'Henry',
    shoppingItems: [
      ShoppingItem(
        itemName: 'Apples',
        isChecked: false,
      ),
      ShoppingItem(
        itemName: 'Chicken',
        isChecked: true,
      ),
    ],
  ),
  User(
    name: 'Josh',
    shoppingItems: [
      ShoppingItem(
        itemName: 'Milk',
        isChecked: false,
      ),
      ShoppingItem(
        itemName: 'Bread',
        isChecked: true,
      ),
    ],
  ),
  User(
    name: 'Billy',
    shoppingItems: [
      ShoppingItem(
        itemName: 'Eggs',
        isChecked: false,
      ),
      ShoppingItem(
        itemName: 'Cheese',
        isChecked: true,
      ),
    ],
  ),
];
