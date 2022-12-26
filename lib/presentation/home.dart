import 'package:benzy_infotech/model/food_delivery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/controller.dart';
import '../model/breakfast_enum.dart';
import '../model/report.dart';

extension on String {
  String titlize() {
    return this[0].toUpperCase() + substring(1);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  final ValueNotifier<List<Report>> _selectedEvents = ValueNotifier([]);

  final _controller = Controller();
  Future<FoodDelivery>? _future;
  FoodDelivery? _foodDelivery;

  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    _future = _controller.getReport(null).then((value) {
      setState(() {
        _foodDelivery = value;
        _isLoading = false;
      });
      _selectedDay = _focusedDay;
      _selectedEvents.value = _getEventsForDay(_focusedDay);
      return value;
    });
    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Report> _getEventsForDay(DateTime day) {
    final events = [...(_foodDelivery?.reports ?? <Report>[])];
    events.removeWhere((element) {
      // var tempDate = element.executionDate.toString().split("-");
      // int year = int.parse(tempDate[0]);
      // int mo = int.parse(tempDate[1]);
      // int date = int.parse(tempDate[2]);
      // print(element.date);
      final newDate = DateFormat('yyyy-MM-dd').parse(element.date);
      // print(newDate.toString());
      // print(isSameDay(day, newDate));
      // log('$day ${element.startDate.toString()} == ${isSameDay(day, DateTime(year, mo, date))}');
      // log(DateTime(year, mo, date).toString());
      if (isSameDay(day, newDate)) {
        return false;
      }
      return true;
    });
    return events;
  }

  final _calendarBuilder = CalendarBuilders<Report>(
    singleMarkerBuilder: (context, day, event) {
      if (event.optIns == null) {
        return Container();
      }
      Color color = Colors.green;

      if (event.optIns!.breakfast == Breakfast.pending ||
          event.optIns!.lunch == Breakfast.pending ||
          event.optIns!.dinner == Breakfast.pending) {
        color = Colors.red;
      }

      return Row(
        children: [
          Container(
            // child: Text('${day.day}'),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      );
    },
    // todayBuilder: (context, day, focusedDay) {
    //   return Container(
    //     // child: Text('${day.day}'),
    //     height: 10,
    //     width: 10,
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).primaryColor,
    //       shape: BoxShape.circle,
    //     ),
    //   );
    // },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Order'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text('${_foodDelivery?.user.email}'),
              accountName: Text('${_foodDelivery?.user.fName}'),
              currentAccountPicture: Image.network(
                '${_foodDelivery?.user.image}',
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: const [0.8, 0.2],
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).backgroundColor,
                  ],
                ),
              ),
              arrowColor: Colors.black,
              // onDetailsPressed: () {},
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: const Icon(Icons.phone_android_rounded),
              title: Text('${_foodDelivery?.user.phone}'),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: const Icon(Icons.person),
              title: Text('${_foodDelivery?.user.empId}'),
            ),
          ],
        ),
      ),
      body: FutureBuilder<FoodDelivery>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // print(snapshot.stackTrace);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TableCalendar<Report>(
                  firstDay: DateTime.utc(2022, 6, 1),
                  lastDay: DateTime.utc(2023, 1, 31),
                  focusedDay: _focusedDay,
                  eventLoader: _getEventsForDay,
                  calendarBuilders: _calendarBuilder,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onPageChanged: (focusedDay) {
                    // focusedDay
                    setState(() {
                      _future =
                          _controller.getReport(focusedDay.month).then((value) {
                        // setState(() {
                        _foodDelivery = value;
                        _isLoading = false;
                        // });
                        _selectedDay = _focusedDay;
                        _selectedEvents.value = _getEventsForDay(_focusedDay);
                        return value;
                      });
                    });
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _selectedEvents.value = _getEventsForDay(selectedDay);
                  },

                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    weekendTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  // enabledDayPredicate: (day) => false,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.white,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                ),
              ),
              SliverToBoxAdapter(
                child: ValueListenableBuilder<List<Report>>(
                    valueListenable: _selectedEvents,
                    builder: (context, events, __) {
                      // print(events);
                      if (events.isEmpty || events[0].optIns == null) {
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.breakfast_dining),
                                title: Text(
                                  '${events[0].optIns?.breakfast.name}'
                                      .titlize(),
                                ),
                                trailing: events[0].optIns?.breakfast ==
                                        Breakfast.pending
                                    ? const Text('\$100')
                                    : const Text('No Fine'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.lunch_dining),
                                title: Text(
                                  '${events[0].optIns?.lunch.name}'.titlize(),
                                ),
                                trailing:
                                    events[0].optIns?.lunch == Breakfast.pending
                                        ? const Text('\$100')
                                        : const Text('No Fine'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.dinner_dining),
                                title: Text(
                                  '${events[0].optIns?.dinner.name}'.titlize(),
                                ),
                                trailing: events[0].optIns?.dinner ==
                                        Breakfast.pending
                                    ? const Text('\$100')
                                    : const Text('No Fine'),
                              ),
                              ListTile(
                                tileColor: Colors.amber,
                                title: const Text(
                                  'Total Fines',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  '\$${events[0].fine}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
      persistentFooterButtons: [
        Visibility(
          visible: !_isLoading,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListTile(
            tileColor: Colors.amber,
            title: const Text(
              'Month Total Fine',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '\$${_foodDelivery?.monthFine}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
