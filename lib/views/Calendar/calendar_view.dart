import 'package:flutter/material.dart';
import 'package:rumii/SessionData.dart';
import 'package:rumii/views/Calendar/expand_event_view.dart';
import 'package:rumii/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rumii/viewmodels/calendar_view_model.dart';
import 'package:rumii/views/Calendar/new_event_view.dart';
import 'package:provider/provider.dart';
import 'package:rumii/models/event_model.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:rumii/viewmodels/event_view_model.dart';
import 'package:rumii/views/Calendar/view_event_view.dart';

class CalendarView extends StatefulWidget {
  final String username;
  final String housekey;

  const CalendarView({Key? key, required this.username, required this.housekey})
      : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime? _selectedDate;
  List<Event> _recentEvents = [];

  @override
  void initState() {
    super.initState();
    Provider.of<CalendarViewModel>(context, listen: false)
        .getData(widget.housekey);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/rumii-logo.png',
          height: 28.00,
          width: 70.00,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              const Text('Calendar',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
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
                              houseKey: widget.housekey,
                            ),
                          ),
                        ),
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: TableCalendar(
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  rowHeight: 55,
                  daysOfWeekHeight: 30,
                  firstDay: DateTime.utc(2023, 12, 1),
                  currentDay: DateTime.now(),
                  focusedDay: DateTime.now(),
                  lastDay: DateTime.utc(2050, 12, 31),
                  eventLoader: (date) {
                    return Provider.of<CalendarViewModel>(context,
                            listen: false)
                        .getDayEvents(date);
                  },
                  onDaySelected: (selectedDate, focusedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                    print(_selectedDate);
                    var dayEvents =
                        Provider.of<CalendarViewModel>(context, listen: false)
                            .getDayEvents(_selectedDate!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandView(
                          selectedDay: selectedDate,
                          housekey: widget.housekey,
                          dayEvents: dayEvents,
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, calendar) {
                      if (calendar.isNotEmpty) {
                        return Stack(
                          children: [
                            Positioned(
                              right: 25,
                              bottom: 7,
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
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<CalendarViewModel>(builder: (context, eventList, child) {
                return _buildList("Upcoming Events", "/calendar",
                    eventList.calendar, Icons.calendar_month_outlined, 'event');
              }),
              const SizedBox(height: 5),
            ],
          ),
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

  Future<List<Event>> fetchRecentEvents(houseKey) async {
    final Map<String, dynamic> jsonData = await fetchEventJsonData();
    final List<Event> recentEvents = [];

    if (jsonData.containsKey(houseKey)) {
      final Map<String, dynamic> houseData = jsonData[houseKey];
      final List<dynamic> events = houseData.values.toList();

      for (int i = 0; i < 3 && i < events.length; i++) {
        final eventData = events[i];

        final event = Event(
          name: eventData['name'],
          day: eventData['day'],
          month: eventData['month'],
          year: eventData['year'],
          starttime: eventData['starttime'],
          endtime: eventData['endtime'],
          isRecurring: eventData['isRecurring'],
          user: eventData['user'],
          remind: eventData['remind'],
          note: eventData['note'],
        );
        recentEvents.add(event);
      }
    }
    return recentEvents;
  }

  Future<Map<String, dynamic>> fetchEventJsonData() async {
    String jsonString = await rootBundle.loadString('assets/eventDB.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    return jsonData;
  }

  Widget _buildList(String title, String route, List<EventViewModel> items,
      IconData iconData, String type) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(iconData), 
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (items.isNotEmpty)
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              EventViewModel item = items[index];
              EventViewModel eventViewModel = item;
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(eventViewModel.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewEvent(
                          event: ExpandEvent(
                              title: eventViewModel.name,
                              date: eventViewModel.date,
                              startTime: eventViewModel.startTime,
                              endTime: eventViewModel.endTime,
                              isRecurring: eventViewModel.isRecurring,
                              remind: eventViewModel.remind,
                              note: eventViewModel.note),
                          eventViewModel: eventViewModel,
                          user: widget.username,
                          lastItem: eventViewModel.name,
                          housekey: widget.housekey,
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}
