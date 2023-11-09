import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  void initState() {
    super.initState();
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
              Text('Login'),
            ])),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentRoute: '/', 
              onRouteChanged: (route) {
                Navigator.of(context).pushNamed(route); // navigate to a different view
              } 
            ),
      );
  }
}
