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
  final ShoppingListViewModel _shoppingListViewModel = ShoppingListViewModel();

  @override
  void initState() {
    super.initState();
    _shoppingListViewModel.getData(widget.housekey);
    Provider.of<ShoppingListViewModel>(context, listen: false)
        .getData(widget.housekey);
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
            const Text('Shopping List',
                style: (TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ))),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ShoppingListViewModel>(context, listen: false)
                        .writeData(widget.housekey);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => ShoppingListViewModel(),
                                child: NewItem(
                                  username: widget.username,
                                  housekey: widget.housekey,
                                ),
                              )),
                    );
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
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 3),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.pinkAccent,
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: getImageWidget(
                                      user, _shoppingListViewModel),
                                ),
                              ),
                              const SizedBox(width: 8),
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
                            return _buildShoppingItem(item, user, shopList);
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
          Provider.of<ShoppingListViewModel>(context, listen: false)
              .writeData(widget.housekey);
          Navigator.pushNamed(context, route,
              arguments: SessionData.data(widget.username, widget.housekey));
        },
      ),
    );
  }

  Widget _buildShoppingItem(
      ShopViewModel item, UserViewModel user, ShoppingListViewModel shopList) {
    IconData getItemIcon(String itemType) {
      for (var type in types) {
        if (type['name'] == itemType) {
          return type['icon'];
        }
      }
      return Icons.question_mark_rounded;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: ListTile(
        onTap: () {
          Provider.of<ShoppingListViewModel>(context, listen: false)
              .writeData(widget.housekey);
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
              shopList.toggleShopComplete(item);
            });
          },
        ),
      ),
    );
  }

  Widget getImageWidget(
      UserViewModel user, ShoppingListViewModel shoppingListViewModel) {
    FutureBuilder<String?> imageFutureBuilder = FutureBuilder<String?>(
      future: shoppingListViewModel.getUserImage(user.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else {
            if (snapshot.data != null) {
              return Image.asset(
                'assets/images/${snapshot.data}',
                height: 33,
                width: 33,
                fit: BoxFit.cover,
              );
            } else {
              return Container(
                height: 33,
                width: 33,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent,
                ),
                child: Text(
                  user.name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

    return imageFutureBuilder;
  }
}
