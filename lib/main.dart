import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_list_view_model.dart';
import 'package:rumii/views/calendar_view.dart';
import 'package:rumii/views/chore_list_view.dart';
import 'package:rumii/views/dashboard_view.dart';
import 'package:rumii/views/login_view.dart';
import 'package:rumii/views/shopping_list_view.dart';
import 'package:provider/provider.dart';

import 'router.dart' as local_router;
import 'constants.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
      initialRoute: '/',
      routes: {
        '/home': (context) => const DashboardView(),
        '/chores': (context) => const ChoreListView(),
        '/shopping_list': (context) => const ShoppingListView(),
        '/calendar': (context) => const CalendarView(),
      },
    );
  }
}
