import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:rumii/views/Chores/view_chore_view.dart';
import 'package:rumii/viewmodels/chore_view_model.dart';
import 'package:rumii/models/chore_model.dart';
import 'package:rumii/views/Dashboard/edit_household_view.dart';
import 'package:rumii/models/shop_model.dart';
import 'package:rumii/views/Shopping/view_item_view.dart';
import 'package:rumii/viewmodels/shop_view_model.dart';
import 'package:rumii/viewmodels/event_view_model.dart';
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
  String? _userImage;

  Future<void> _fetchUserData() async {
    final Map<String, dynamic> userData =
        await _dataProvider.fetchUserDataForImage(widget.username);

    setState(() {
      _userImage = userData['image'];
    });
  }

  List<Chore> _recentChores = [];
  List<Shop> _recentStoreNeeds = [];
  List<Event> _recentEvents = [];

  Future<void> _fetchData() async {
    if (widget.username != null && widget.housekey != null) {
      List<Chore> recentChores = await _dataProvider.fetchRecentChores(
          widget.username!, widget.housekey!);
      List<Shop> recentStoreNeeds = await _dataProvider.fetchRecentStoreNeeds(
          widget.username!, widget.housekey!);
      List<Event> recentEvents =
          await _dataProvider.fetchRecentEvents(widget.housekey!);

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
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.username;
    var house = widget.housekey;
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 20, 25),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        child: Row(
                          children: [
                            Text('Log Out',
                                style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                )),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.logout,
                              size: 14,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        onPressed: () {
                          _showLogoutConfirmationDialog();
                        }),
                  ],
                ),
                Row(children: [
                  const Icon(Icons.dashboard_outlined,
                      color: Colors.white, size: 32),
                  const SizedBox(width: 10),
                  Text('Dashboard',
                      style: (TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ))),
                ]),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        _userImage != null
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/$_userImage'),
                                radius: 30,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.34,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello, $user!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    const Icon(Icons.key_outlined,
                                        color: Colors.white, size: 18),
                                    const SizedBox(width: 5),
                                    Text('House Key: $house',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        )),
                                  ]),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditHousehold(
                                                      housekey:
                                                          widget.housekey)),
                                        );
                                      },
                                      child: const Row(children: [
                                        Text('Edit Household',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                        SizedBox(width: 5),
                                        Icon(Icons.edit_outlined,
                                            color: Colors.black, size: 16),
                                      ]),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          side: const BorderSide(
                                              color:
                                                  Color.fromARGB(0, 0, 0, 0))))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
            height: MediaQuery.of(context).size.height / 1.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Color.fromARGB(35, 0, 0, 0),
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Row(children: [
                    Icon(Icons.home_outlined, size: 35),
                    Text(' Overview',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26)),
                  ]),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(105, 255, 205, 221),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _buildList("Unfinished Chores", "/chores",
                        _recentChores, Icons.view_list_outlined, 'chore'),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(105, 255, 205, 221),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _buildList(
                        "Store Needs",
                        "/shopping_list",
                        _recentStoreNeeds,
                        Icons.shopping_cart_outlined,
                        'storeNeed'),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(105, 255, 205, 221),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _buildList("Upcoming Events", "/calendar",
                        _recentEvents, Icons.calendar_month_outlined, 'event'),
                  ),
                  const SizedBox(height: 15),
                ]),
          ),
        ]),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/home',
          onRouteChanged: (route) {
            Navigator.pushNamed(context, route,
                arguments: SessionData.data(user, house));
          }),
    );
  }

  Widget _buildList(String title, String route, List<dynamic> items,
      IconData iconData, String type) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 2,
          leading: Icon(iconData, color: Colors.pink),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
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
                          user: widget.username,
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
                  contentPadding: const EdgeInsets.only(left: 25),
                  title: Text(storeNeed.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewItem(
                          shop: shopViewModel,
                          user: widget.username,
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
                          user: widget.username,
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
          actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          contentPadding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
          icon: const Icon(Icons.logout),
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 30),
              SizedBox(
                width: 80,
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
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
                ),
              ),
              const SizedBox(width: 50),
              SizedBox(
                width: 80,
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.pink),
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
                  child: const Text('Yes',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
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

  Future<Map<String, dynamic>> fetchUserJsonData() async {
    String jsonString = await rootBundle.loadString('assets/userDB.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

  Future<List<Chore>> fetchRecentChores(
      String personName, String houseKey) async {
    final Map<String, dynamic> jsonData = await fetchJsonData();
    final List<Chore> recentChores = [];

    if (jsonData.containsKey(houseKey)) {
      final Map<String, dynamic> houseData = jsonData[houseKey];

      if (houseData.containsKey(personName)) {
        final Map<String, dynamic> personData = houseData[personName];
        final List<dynamic> chores = personData.values.toList();

        chores.sort((a, b) => a['dueDate'].compareTo(b['dueDate']));

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
      final Map<String, dynamic> houseData = jsonData[houseKey];

      if (houseData.containsKey(personName)) {
        final Map<String, dynamic> personData = houseData[personName];
        final List<dynamic> storeItems = personData.values.toList();

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
      final Map<String, dynamic> houseData = jsonData[houseKey];
      final List<dynamic> events = houseData.values.toList();

      for (int i = 0; i < 3 && i < events.length; i++) {
        final eventData = events[i];
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

  Future<Map<String, dynamic>> fetchUserDataForImage(String username) async {
    final Map<String, dynamic> jsonData = await fetchUserJsonData();

    if (jsonData.containsKey("Users")) {
      final Map<String, dynamic> usersData = jsonData["Users"];

      if (usersData.containsKey(username)) {
        return usersData[username];
      }
    }

    return {};
  }
}
