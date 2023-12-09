import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/views/Shopping/edit_item_view.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';

class ViewItem extends StatefulWidget {
  final ShopViewModel shop;
  final String user;
  final String lastItem;
  final String housekey;
  final String username;

  const ViewItem(
      {Key? key,
      required this.shop,
      required this.user,
      required this.lastItem,
      required this.housekey,
      required this.username})
      : super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                    create: (context) =>
                                        ShoppingListViewModel(),
                                    child: EditItem(
                                        user: widget.user,
                                        shop: widget.shop,
                                        lastItem: widget.lastItem,
                                        housekey: widget.housekey,
                                        username: widget.username),
                                  )));
                    },
                    child: const Text('Edit',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ))),
              ),
            ]),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'View Item',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //add other widgets
            const SizedBox(height: 20),
            buildInfoRow(context, 'Item', widget.shop.name),
            buildInfoRow(context, 'Type', widget.shop.type),
            buildInfoRow(context, 'Assigned user', widget.user),
            buildInfoRow(context, 'Quantity', widget.shop.quantity.toString()),
            buildInfoRow(context, 'Notes', widget.shop.notes),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget buildInfoRow(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      const SizedBox(height: 2),
      label == 'Type'
          ? Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: types.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      8,
                      index == types.length - 1 ? 0 : 20,
                      8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: value == types[index]['name']
                              ? Colors.pink
                              : Colors.grey,
                          child: Icon(
                            types[index]['icon'],
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 70,
                          child: Text(
                            types[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: value == types[index]['name']
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: value == types[index]['name']
                                  ? Colors.pink
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Text(value),
                ],
              ),
            ),
      const SizedBox(height: 10),
    ],
  );
}
