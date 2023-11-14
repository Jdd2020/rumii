import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  DataProvider _dataProvider = DataProvider();

  List<String> _recentChores = [];
  List<String> _recentStoreNeeds = [];
  List<String> _recentEvents = [];

  Future<void> _fetchData() async {
    List<String> recentChores = await _dataProvider.fetchRecentChores();
    List<String> recentStoreNeeds = await _dataProvider.fetchRecentStoreNeeds();
    List<String> recentEvents = await _dataProvider.fetchRecentEvents();

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
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text('Dashboard', style: (TextStyle(fontSize: 26, fontWeight: FontWeight.bold,))),
                const SizedBox(height: 20),
                const Text('Hello, (Name)!', style: TextStyle(fontSize: 32,)),
                const Text('House Key: (#####)', style: TextStyle(fontSize: 18,)),
                const SizedBox(height: 20),
                _buildList("Unfinished Chores", "/chores", _recentChores, Icons.view_list_outlined),
                const SizedBox(height: 10),
                _buildList("Store Needs", "/shopping_list", _recentStoreNeeds, Icons.shopping_cart_outlined),
                const SizedBox(height: 10),
                _buildList("Upcoming Events", "/calendar", _recentEvents, Icons.calendar_month_outlined),
                const SizedBox(height: 10),
              ])),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/',
          onRouteChanged: (route) {
            Navigator.of(context)
                .pushNamed(route); // navigate to a different view
          }),
    );
  }

  Widget _buildList(
      String title, String route, List<String> items, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40,
              child: ListTile(
                title: Text(items[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}

class DataProvider {
  // example function to fetch the most critical chores
  Future<List<String>> fetchRecentChores() async {
    // fetch data from database
    await Future.delayed(const Duration(seconds: 0));
    return ["Chore 1", "Chore 2", "Chore 3"];
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