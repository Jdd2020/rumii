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

class DashboardView extends StatefulWidget {

  const DashboardView({Key? key}) : super(key:key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DataProvider _dataProvider = DataProvider();

  String personName = "";
  String houseKey = "";

  List<Chore> _recentChores = [];
  List<String> _recentStoreNeeds = [];
  List<String> _recentEvents = [];

  Future<void> _fetchData() async {
    //List<String> recentChores = await _dataProvider.fetchRecentChores();
    List<String> recentStoreNeeds = await _dataProvider.fetchRecentStoreNeeds();
    List<String> recentEvents = await _dataProvider.fetchRecentEvents();

    Map<String, dynamic> jsonData = await _dataProvider.fetchJsonData();
    List<Chore> recentChores =
        await _dataProvider.fetchRecentChores("Henry", "DSBU781");

    setState(() {
      _recentChores = recentChores;
      _recentStoreNeeds = recentStoreNeeds;
      _recentEvents = recentEvents;
    });
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
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text('Dashboard',
                        style: (TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ))),
                    const SizedBox(height: 20),
                    const Text('Hello, Henry!',
                        style: const TextStyle(
                          fontSize: 32,
                        )),
                    const Text('House Key: DSBU781',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    const SizedBox(height: 20),
                    _buildList("Unfinished Chores", "/chores", _recentChores,
                        Icons.view_list_outlined),
                    const SizedBox(height: 5),
                    _buildList(
                        "Store Needs",
                        "/shopping_list",
                        [],
                        Icons
                            .shopping_cart_outlined), // replace array with _recentStoreNeeds
                    const SizedBox(height: 5),
                    _buildList(
                        "Upcoming Events",
                        "/calendar",
                        [], // replace array with _recentEvents
                        Icons.calendar_month_outlined),
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
      String title, String route, List<Chore> items, IconData iconData) {
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
        // add contents of list

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            Chore chore = items[index];
            ChoreViewModel choreViewModel = ChoreViewModel(chore: chore);

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                title: Text(chore.name),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewChore(
                          chore: choreViewModel,
                          user: "Henry",
                          lastChore: chore.name,
                    ),
                  ),
                  ),
                
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class DataProvider {
  Future<Map<String, dynamic>> fetchJsonData() async {
    // Load JSON from file
    String jsonString = await rootBundle.loadString('assets/choreDB.json');

    // Parse the JSON string into a map
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

        // Sort chores based on due date
        chores.sort((a, b) => a['dueDate'].compareTo(b['dueDate']));

        // Retrieve up to 3 most recent chores
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

  // example function to fetch the most recently added store needs
  Future<List<String>> fetchRecentStoreNeeds() async {
    // fetch data from database
    await Future.delayed(const Duration(seconds: 0));
    return ["Item 1", "Item 2", "Item 3"];
  }

  // example function to fetch the most upcoming events
  Future<List<String>> fetchRecentEvents() async {
    // fetch data from database
    await Future.delayed(const Duration(seconds: 0));
    return ["Event 1", "Event 2", "Event 3"];
  }

}
