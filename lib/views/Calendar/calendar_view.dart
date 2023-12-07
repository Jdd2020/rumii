import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/views/Calendar/new_event_view.dart';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatefulWidget {
  final String username;
  final String housekey;
  const CalendarView({Key? key, required this.username, required this.housekey})
      : super(key: key);

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
        title: Image.asset('assets/images/rumii-logo.png',
            height: 28.00, width: 70.00), //const Text("Rumii"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text('Calendar',
                style: (TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ))),
            //const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  child: ElevatedButton(
                      child: const Text(
                        "+ New",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          //color: Colors.black,
                        ),
                      ),
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        create: (context) =>
                                            CalendarViewModel(),
                                        child: const NewEvent(),
                                      )),
                            ),
                          },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/calendar',
          onRouteChanged: (route) {
            Navigator.pushNamed(context, route,
                arguments: SessionData.data(widget.username,
                    widget.housekey)); // navigate to a different view
          }),
    );
  }
}
