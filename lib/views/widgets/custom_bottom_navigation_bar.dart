import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String currentRoute;
  final ValueChanged<String> onRouteChanged;

  const CustomBottomNavigationBar(
      {super.key, required this.currentRoute, required this.onRouteChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: _getSelectedIndex(currentRoute),
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        onRouteChanged(_getRouteFromIndex(index));
      },
    );
  }

  int _getSelectedIndex(String route) {
    if (route == '/home') return 0;
    if (route == '/chores') return 1;
    if (route == '/shopping_list') return 2;
    if (route == '/calender') return 3;
    return 0;
  }

  String _getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/chores';
      case 2:
        return '/shopping_list';
      case 3:
        return '/calender';
      default:
        return '/';
    }
  }
}
