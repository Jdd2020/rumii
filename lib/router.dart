import 'package:flutter/material.dart';
import 'package:rumii/viewmodels/login_view_model.dart';
import 'package:rumii/views/login_view.dart';

import 'package:provider/provider.dart';

import 'package:rumii/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => LoginViewModel(),
                  child: const LoginView(),
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
