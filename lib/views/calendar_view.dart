import 'package:flutter/material.dart';
import 'package:rumii/views/widgets/CustomBottomNavigationBar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/rumii-logo.png', height: 28.00, width: 70.00), //const Text("Rumii"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Column(children: <Widget>[
              Text('Calendar'),
            ])),
           bottomNavigationBar: CustomBottomNavigationBar(
              currentRoute: '/calendar', 
              onRouteChanged: (route) {
                Navigator.of(context).pushNamed(route); // navigate to a different view
              } 
            ),
      );
  }
}
