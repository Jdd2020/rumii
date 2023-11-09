import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0; // Index for the currently selected tab

  @override
  void initState() {
    super.initState();
  }

   // list of views or screens that correspond to each tab
    final List<Widget> _pages = [
      Text('Dashboard'),
      Text('Chores'),
      Text('Shopping List'),
      Text('Calendar')
    ];

    // Function to handle tab selection
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Rumii")),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Column(children: <Widget>[
              Text('Dashboard'),
            ])),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_outlined),
              label: 'Chores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Shopping List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendar',
            ),
          ],
          currentIndex: _selectedIndex, // Current tab index
          selectedItemColor: Colors.pink, // Color of the selected tab icon and label
          unselectedItemColor: Colors.grey, // Color of unselected tab icons and labels
          onTap: _onItemTapped, // Callback when a tab is tapped
        ),
      );
  }
}
