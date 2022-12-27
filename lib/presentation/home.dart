import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:benzy_infotech/model/food_delivery.dart';

import '../controller/controller.dart';
import '../model/breakfast_enum.dart';
import '../model/report.dart';
import 'widgets/bill_calculator.dart';
import 'widgets/drawer.dart';

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
      final newDate = DateFormat('yyyy-MM-dd').parse(element.date);

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
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Order'),
        centerTitle: true,
      ),
      drawer: IDrawer(foodDelivery: _foodDelivery),
      body: FutureBuilder<FoodDelivery>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
                  onPageChanged: _onPageChanged,
                  onDaySelected: _onDaySelected,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    weekendTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                      if (events.isEmpty || events[0].optIns == null) {
                        return Container();
                      }
                      return BillCalculator(
                        event: events[0],
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

  void _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _selectedEvents.value = _getEventsForDay(selectedDay);
  }

  void _onPageChanged(focusedDay) {
    setState(() {
      _isLoading = true;
    });
    setState(() {
      _future = _controller.getReport(focusedDay.month).then((value) {
        _foodDelivery = value;
        _isLoading = false;

        _selectedDay = _focusedDay;
        _selectedEvents.value = _getEventsForDay(_focusedDay);
        return value;
      });
    });
    setState(() {
      _focusedDay = focusedDay;
      _isLoading = true;
    });
  }
}
