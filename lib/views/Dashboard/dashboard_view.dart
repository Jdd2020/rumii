import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
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
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/models/event_model.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class DashboardView extends StatefulWidget {
  final String username;
  final String housekey;

  const DashboardView(
      {Key? key, required this.username, required this.housekey})
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
  List<Event> _recentEvents = [];

  Future<void> _fetchData() async {
    if (widget.username != null && widget.housekey != null) {
      List<Chore> recentChores = await _dataProvider.fetchRecentChores(
          widget.username!, widget.housekey!);
      List<Shop> recentStoreNeeds = await _dataProvider.fetchRecentStoreNeeds(
          widget.username!, widget.housekey!);
      List<Event> recentEvents = await _dataProvider.fetchRecentEvents(widget.housekey!);

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
    var user = widget.username;
    var house = widget.housekey;
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
              padding: const EdgeInsets.fromLTRB(25,0,25,25),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row (
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton (
                            child: const Row(
                              children: [
                              Text('Log Out', style: TextStyle(color: Colors.black)),
                              SizedBox(width: 6),
                              Icon(Icons.logout, size: 14, color: Colors.black),],),
                          onPressed: () {
                            _showLogoutConfirmationDialog();
                          }
                        ),  
                      ],
                      ),
                    const Text('Dashboard',
                        style: (TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ))),
                    const SizedBox(height: 20),
                    Text('Hello, $user!',
                        style: const TextStyle(
                          fontSize: 32,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('House Key: $house',
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditHousehold(housekey: widget.housekey)),
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
                        Icons.shopping_cart_outlined,
                        'storeNeed'),
                    const SizedBox(height: 5),
                    _buildList(
                        "Upcoming Events",
                        "/calendar",
                        _recentEvents, // replace array with _recentEvents
                        Icons.calendar_month_outlined,
                        'event'),
                    const SizedBox(height: 5),
                  ]))),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/home',
          onRouteChanged: (route) {
            Navigator.pushNamed(context, route,
                arguments: SessionData.data(
                    user, house)); // navigate to a different view
          }),
    );
  }

  Widget _buildList(String title, String route, List<dynamic> items,
      IconData iconData, String type) {
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
              Navigator.pushNamed(context, route,
                  arguments:
                      SessionData.data(widget.username, widget.housekey));
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
                          username: widget.username,
                          housekey: widget.housekey,
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
                          housekey: widget.housekey,
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (type == 'event') {
              Event event = item;
              EventViewModel eventViewModel = EventViewModel(event: event);

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(event.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewEvent(
                          event: ExpandEvent(
                            title: eventViewModel.name,
                            date: eventViewModel.date,
                            startTime: eventViewModel.startTime,
                            endTime: eventViewModel.endTime,
                            isRecurring: eventViewModel.isRecurring,
                            remind: eventViewModel.remind,
                            note: eventViewModel.note),
                          eventViewModel: eventViewModel,
                          user: "Henry",
                          lastItem: event.name,
                          housekey: widget.housekey,
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.fromLTRB(10,0,10,10),
          contentPadding: const EdgeInsets.fromLTRB(30,15,30,10),
          icon: const Icon(Icons.logout),
          title: const Text('Log Out'),
          content: 
          const Text('Are you sure you want to log out?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              const SizedBox(height:30),
              SizedBox(
              width: 80,
              height: 40,
                child: TextButton(
                  style: ButtonStyle(
                
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: const BorderSide(
                                color: Colors.pink,
                                width: 1.25,
                              ),
                          ),
                          ),


              ),
              
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No', style: TextStyle(fontSize: 18)),
            ),),
            const SizedBox(width:50),

            SizedBox(
              width: 80,
              height: 40,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.pink),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: const BorderSide(
                                color: Color.fromARGB(0, 233, 30, 98),
                                width: 0,
                              ),
                          ),
                          ),


              ),
              onPressed: () {
                Navigator.pushNamed(context, loginRoute);
              },
              child: const Text('Yes', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),),
            const SizedBox(height: 70),
            ]),
          ],
        );
      },
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

   Future<List<Event>> fetchRecentEvents(houseKey) async {
    final Map<String, dynamic> jsonData = await fetchEventJsonData();
    final List<Event> recentEvents = [];

    if (jsonData.containsKey(houseKey)) {
      //personName
      final Map<String, dynamic> houseData = jsonData[houseKey];
      final List<dynamic> events = houseData.values.toList();

    for (int i = 0; i < 3 && i < events.length; i++) {
          final eventData = events[i];    
        // retrieve up to 3 most recent chores
          final event = Event(
            name: eventData['name'],
            day: eventData['day'],
            month: eventData['month'],
            year: eventData['year'],
            starttime: eventData['starttime'],
            endtime: eventData['endtime'],
            isRecurring: eventData['isRecurring'],
            user: eventData['user'],
            remind: eventData['remind'],     
            note: eventData['note'],     
          );
          recentEvents.add(event);
      }
    }
    return recentEvents;
  }
   

  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final Map<String, dynamic> jsonData = await fetchEventJsonData();

    if (jsonData.containsKey(username)) {
      return jsonData[username];
    }

    return {};
  }
}
