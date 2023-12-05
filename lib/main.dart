import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/Calendar/calendar_view.dart';
import 'package:rumii/views/Chores/chore_list_view.dart';
import 'package:rumii/views/Dashboard/dashboard_view.dart';
import 'package:rumii/views/Login/login_view.dart';
import 'package:rumii/views/Shopping/shopping_list_view.dart';
import 'package:provider/provider.dart';

import 'router.dart' as local_router;
import 'constants.dart';

import 'package:rumii/viewmodels/login_view_model.dart';
//import 'package:rumii/services/user_provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      /*
      home: ChangeNotifierProvider(
        create: (context) => null,
        child: const LoginView(),
      ),
      onGenerateRoute: local_router.Router.generateRoute,
      initialRoute: loginRoute,*/
      home: ChangeNotifierProvider(
        create: (context) => LoginListViewModel(),
        child: const LoginView(),
      ),
      onGenerateRoute: local_router.Router.generateRoute,
      initialRoute: loginRoute,
      routes: {
        '/home': (context) {
            /*var userProvider = Provider.of<UserProvider>(context);
            var username = userProvider.username;
            var houseKey = userProvider.houseKey;*/
            return DashboardView(username: "Henry", houseKey: "DSBU781");
          },
        // '/chores': (context) => const ChoreListView(),
        // '/shopping_list': (context) => const ShoppingListView(),
        '/calendar': (context) => const CalendarView(),
      },
    );
  }
}
