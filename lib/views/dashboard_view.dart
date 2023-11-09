import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rumii"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Column(children: <Widget>[
              Text('Dashboard'),
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
