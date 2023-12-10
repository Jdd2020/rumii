import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/views/Calendar/new_event_view.dart';
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
            height: 28.00, width: 70.00),
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
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => CalendarViewModel(),
                                child: NewEvent(
                                  username: widget.username,
                                  houseKey: widget.housekey,),
                              )),
                    ),
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "+ New",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TableCalendar(
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    )),
                calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                )),
                rowHeight: 55,
                daysOfWeekHeight: 30,
                firstDay: DateTime.utc(2023, 12, 1),
                currentDay: DateTime.now(),
                focusedDay: DateTime.now(),
                lastDay: DateTime.utc(2050, 12, 31),
                eventLoader: (date) {
                  return context.read<CalendarViewModel>().getEventsForDate(date);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, calendar) {
  if (calendar.isNotEmpty) {
    return Stack(
      children: [
        Positioned(
          right: 1,
          bottom: 1,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
            width: 6.0,
            height: 5.0,
          ),
        ),
      ],
    );
  }
 // return [];
},
                )
                ),
            const SizedBox(height: 20),
            const Text('Upcoming Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          
          // Display upcoming events
            Expanded(
              child: ListView(
                children: context
                    .watch<CalendarViewModel>()
                    .calendar
                    .map((event) => ListTile(
                          title: Text(event.name),
                          subtitle: Text(
                              '${event.startTime.format(context)} - ${event.endTime.format(context)}'),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
          currentRoute: '/calendar',
          onRouteChanged: (route) {
            Navigator.pushNamed(context, route,
                arguments: SessionData.data(widget.username, widget.housekey));
          }),
    );
  }
}
