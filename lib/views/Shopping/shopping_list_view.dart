import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/user_view_model.dart';
import 'package:rumii/views/Shopping/new_item_view.dart';
import 'package:rumii/views/Shopping/view_item_view.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';

class ShoppingListView extends StatefulWidget {
  final String username;
  final String housekey;
  const ShoppingListView(
      {Key? key, required this.username, required this.housekey})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShoppingListViewModel>(context, listen: false)
        .getData(widget.housekey);
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
        padding: const EdgeInsets.all(25),
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
            //const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  child: ElevatedButton(
                      child: const Text(
                        "+ New",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          //color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (context) =>
                                        ShoppingListViewModel(),
                                    child: NewItem(
                                      username: widget.username,
                                      housekey: widget.housekey,
                                    ),
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ))),
            ),
            //const SizedBox(height: 20),
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
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 6),
                          child: Row(
                            children: [
                              Container(
                                height: 33,
                                width: 33,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pinkAccent,
                                  //borderRadius: BorderRadius.circular(5),
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
                            return _buildShoppingItem(item, user);
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
          Navigator.pushNamed(context, route,
              arguments: SessionData.data(widget.username, widget.housekey));
        },
      ),
    );
  }

  Widget _buildShoppingItem(ShopViewModel item, UserViewModel user) {
    IconData getItemIcon(String itemType) {
      for (var type in types) {
        if (type['name'] == itemType) {
          return type['icon'];
        }
      }
      // Return a default icon if the item type is not found
      return Icons.question_mark_rounded;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewItem(
                  shop: item,
                  user: user.name,
                  lastItem: item.name,
                  housekey: widget.housekey,
                  username: widget.username,
                ),
              ));
        },
        contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        leading: Icon(
          getItemIcon(item.type),
          size: 32,
          color: Colors.grey,
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item.notes,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color.fromARGB(227, 112, 112, 112),
          ),
        ),
        trailing: Checkbox(
          value: item.isCompleted,
          onChanged: (value) {
            setState(() {
              // item.isCompleted = value ?? false;
            });
          },
        ),
      ),
    );
  }
}
/*
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
*/
