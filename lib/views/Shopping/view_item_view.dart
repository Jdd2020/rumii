import 'package:flutter/material.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/views/Shopping/edit_item_view.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';

class ViewItem extends StatefulWidget {
  final ShopViewModel shop;
  final String user;
  final String lastItem;

  const ViewItem({Key? key, 
      required this.shop,
      required this.user,
      required this.lastItem})
      : super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                'View Item',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItem(
                        shop: widget.shop,
                        user: widget.user,
                        lastItem: widget.lastItem,
                        ),
                    ),
                  );
                },
                child: const Text('Edit',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ))),
          ]),
          //add other widgets
          const SizedBox(height: 20),
          buildInfoRow('Item', widget.shop.name),
          buildInfoRow('Quantity', widget.shop.quantity.toString()),
          buildInfoRow('Type', widget.shop.type),
          buildInfoRow('Notes', widget.shop.notes),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  //the logic
                },
                child: const Text("Delete")),
          )
        ],
      ),
    );
  }
}

Widget buildInfoRow(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(
        width: 1250,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.grey.shade300,
          ),
          child: Text(value),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
