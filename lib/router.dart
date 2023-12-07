import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/constants.dart';
import 'package:provider/provider.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/viewmodels/shopping_list_view_model.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';
import 'package:rumii/views/Login/login_view.dart';
import 'package:rumii/views/Login/register_view.dart';
import 'package:rumii/viewmodels/chore_list_view_model.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/views/Shopping/shopping_list_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as SessionData;
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => LoginListViewModel(),
                  child: const LoginView(),
                ));
      case registerRoute:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => LoginListViewModel(),
                  child: const RegisterView(),
                ));
      case choreListRoute:
        SessionData userData = args;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => ChoreListViewModel(),
                  child: ChoreListView(
                    username: userData.username,
                    housekey: userData.housekey,
                  ),
                ));
      case shopListRoute:
        SessionData userData = args;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => ShoppingListViewModel(),
                  child: ShoppingListView(
                    username: userData.username,
                    housekey: userData.housekey,
                  ),
                ));
      case dashRoute:
        SessionData userData = args;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => ChoreListViewModel(),
                  child: DashboardView(
                    username: userData.username,
                    housekey: userData.housekey,
                  ),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
