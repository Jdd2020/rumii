import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/viewmodels/login_view_model.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:provider/provider.dart';
import 'package:rumii/views/Dashboard/edit_household_view.dart';
import 'package:rumii/viewmodels/edit_household_view_model.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/views/Shopping/view_item_view.dart';
import 'package:rumii/views/Shopping/edit_item_view.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';


class DashboardView extends StatefulWidget {
  String? username;
  String? houseKey;

  DashboardView({Key? key, 
      this.username,
      this.houseKey, })
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DataProvider _dataProvider = DataProvider();

/*
  String personName = "";
  String houseKey = "";*/

  List<Chore> _recentChores = [];
  List<Shop> _recentStoreNeeds = [];
  List<String> _recentEvents = [];

  Future<void> _fetchData() async {

     if (widget.username != null && widget.houseKey != null) {
      List<Chore> recentChores = await _dataProvider.fetchRecentChores(widget.username!, widget.houseKey!);
      List<Shop> recentStoreNeeds = await _dataProvider.fetchRecentStoreNeeds(widget.username!, widget.houseKey!);
      List<String> recentEvents = await _dataProvider.fetchRecentEvents();

      setState(() {
        _recentChores = recentChores;
        _recentStoreNeeds = recentStoreNeeds;
        _recentEvents = recentEvents;
      });
    }
 
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text('Dashboard',
                        style: (TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ))),
                    const SizedBox(height: 20),
                    Text('Hello, ${widget.username}!',
                        style: TextStyle(
                          fontSize: 32,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('House Key: ${widget.houseKey}',
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditHousehold()),
                              );
                            },
                            child: const Text('Edit Household',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                side: const BorderSide(color: Colors.black)))
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildList("Unfinished Chores", "/chores", _recentChores,
                        Icons.view_list_outlined, 'chore'),
                    const SizedBox(height: 5),
                    _buildList(
                        "Store Needs",
                        "/shopping_list",
                        _recentStoreNeeds,
                        Icons
                            .shopping_cart_outlined,
                            'storeNeed'),
                    const SizedBox(height: 5),
                    _buildList(
                        "Upcoming Events",
                        "/calendar",
                        [], // replace array with _recentEvents
                        Icons.calendar_month_outlined, 'event'),
                    const SizedBox(height: 5),
                  ]))),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/home',
          onRouteChanged: (route) {
            Navigator.pushNamed(context, route); // navigate to a different view
          }),
    );
  }

  Widget _buildList(
      String title, String route, List<dynamic> items, IconData iconData, String type) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(iconData), // header icon
          title: Text(
            // header
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            // arrow to corresponding module
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.of(context).pushNamed(route);
            },
          ),
        ),
        

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            dynamic item = items[index];

            if (type == 'chore') {
            
            Chore chore = item;
            ChoreViewModel choreViewModel = ChoreViewModel(chore: chore);

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                title: Text(chore.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewChore(
                        chore: choreViewModel,
                        user: "Henry",
                        lastChore: chore.name,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (type == 'storeNeed') {
            
            Shop storeNeed = item;
            ShopViewModel shopViewModel = ShopViewModel(shop: storeNeed);

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                title: Text(storeNeed.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewItem(
                        shop: shopViewModel,
                        user: "Henry",
                        lastItem: storeNeed.name,
                      ),
                    ),
                  );
                },
                
              ),
            );
          } else if (type == 'event') {
            
            String event = item;
            
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                title: Text(event),
                
              ),
            );
          }

          
          return Container();
        },
      ),
    ],
  );
  }
}

class DataProvider {
  Future<Map<String, dynamic>> fetchJsonData() async {
    
    String jsonString = await rootBundle.loadString('assets/choreDB.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

  Future<Map<String, dynamic>> fetchStoreJsonData() async {
    
    String jsonString = await rootBundle.loadString('assets/shopDB.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

    Future<Map<String, dynamic>> fetchEventJsonData() async {

    String jsonString = await rootBundle.loadString('assets/eventDB.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

  Future<List<Chore>> fetchRecentChores(
      String personName, String houseKey) async {
    //await Future.delayed(const Duration(seconds: 0));

    final Map<String, dynamic> jsonData = await fetchJsonData();
    final List<Chore> recentChores = [];

    if (jsonData.containsKey(houseKey)) {
      //personName
      final Map<String, dynamic> houseData = jsonData[houseKey];

      if (houseData.containsKey(personName)) {
        final Map<String, dynamic> personData = houseData[personName];
        final List<dynamic> chores = personData.values.toList();

        // sort chores based on due date
        chores.sort((a, b) => a['dueDate'].compareTo(b['dueDate']));

        // retrieve up to 3 most recent chores
        for (int i = 0; i < 3 && i < chores.length; i++) {
          final choreData = chores[i];
          final chore = Chore(
            name: choreData['name'],
            dueDate: choreData['dueDate'],
            priority: choreData['priority'],
            isCompleted: choreData['isCompleted'],
          );
          recentChores.add(chore);
        }
      }
    }
    return recentChores;
  }

  Future<List<Shop>> fetchRecentStoreNeeds(personName, houseKey) async {
    
    final Map<String, dynamic> jsonData = await fetchStoreJsonData();
    final List<Shop> recentStoreNeeds = [];

    if (jsonData.containsKey(houseKey)) {
      //personName
      final Map<String, dynamic> houseData = jsonData[houseKey];

      if (houseData.containsKey(personName)) {
        final Map<String, dynamic> personData = houseData[personName];
        final List<dynamic> storeItems = personData.values.toList();

        // retrieve up to 3 most recent chores
        for (int i = 0; i < 3 && i < storeItems.length; i++) {
          final storeItemData = storeItems[i];
          final storeItem = Shop(
            name: storeItemData['name'],
            type: storeItemData['type'],
            notes: storeItemData['notes'],
            quantity: storeItemData['quantity'],
            isCompleted: storeItemData['isCompleted'],
          );
          recentStoreNeeds.add(storeItem);
        }
      }
    }
    return recentStoreNeeds;
}

  // example function to fetch the most upcoming events
  Future<List<String>> fetchRecentEvents() async {
    // fetch data from database
    await Future.delayed(const Duration(seconds: 0));
    return ["Event 1", "Event 2", "Event 3"];
  }

  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final Map<String, dynamic> jsonData = await fetchEventJsonData();

    if (jsonData.containsKey(username)) {
      return jsonData[username];
    }

    return {};
  }

}
