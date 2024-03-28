
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/models/day_values_model.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import 'attendance_widgets/example_attendance_boxes.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        centerTitle: true,
        showBackArrow: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Attendance',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              const TopHeading(
                text: 'Every Day Counts:\nYour Attendance\nChronicle',
              ),
              const SizedBox(height: 16),

              // CalendarWidget added here
              // CalendarWidget(),
              Container(
                // height: 300,
                // width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        const BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: MyCalendar(),
                    child: CalendarPage(),
                  )),

              const ColorIndicationBoxExample(),
              const SizedBox(height: 15),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      "Academic Day's :",
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "22/15",
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: EColors.primary, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      "Your Current Semester Attendance :",
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter'),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "98.99 %",
                      style: TextStyle(fontSize: 14, fontFamily: 'Inter', color: EColors.primary, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/// another calander
/*
/// Correct calendar
class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  final CleanCalendarController _calendarController = CleanCalendarController(
    minDate: DateTime(2010, 1, 1),
    maxDate: DateTime(2050, 12, 31),
    onDayTapped: (DateTime date) {
      // Handle day tapped event
    },
    onRangeSelected: (DateTime minDate, DateTime? maxDate) {
      // Handle range selected event
    },
  );

  final String jsonData = '''
    [
      {"eventName": "P", "eventDate": "2024-02-01"},
      {"eventName": "P", "eventDate": "2024-02-02"},
      {"eventName": "P", "eventDate": "2024-02-03"},
      {"eventName": "A", "eventDate": "2024-02-04"},
      {"eventName": "P", "eventDate": "2024-02-05"},
      {"eventName": "A", "eventDate": "2024-02-06"},
      {"eventName": "L", "eventDate": "2024-02-13"},
      {"eventName": "H", "eventDate": "2024-02-15"},
      {"eventName": "WH", "eventDate": "2024-02-20"}
    ]
  ''';

  List<Map<String, String>> events = [];

  @override
  void initState() {
    super.initState();
    events = List<Map<String, String>>.from(
      json.decode(jsonData).map((item) =>
      Map<String, String>.from(item),
      ),
    );
  }
  Color getEventBackgroundColor(String eventName) {
    switch (eventName) {
      case 'P':
        return Colors.cyan.shade100;
      case 'A':
        return Colors.red.shade200;
      case 'L':
        return Colors.green.shade500;
      case 'H':
        return Colors.orange.shade300;
      case 'WH':
        return Colors.yellow.shade300;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return

      Padding(
        padding: EdgeInsets.all(16.0),
        child: ScrollableCleanCalendar(
          calendarController: _calendarController,
          monthBuilder: (BuildContext context, String month) {
            // Customize month rendering as needed
            return Text(month);
          },
          weekdayBuilder: (BuildContext context, String weekday) {
            // Customize weekday rendering as needed
            return Text(weekday);
          },
          dayBuilder: (BuildContext context, DayValues values) {
            final date = values.day;
            final event = events.firstWhere(
                  (event) => DateTime.parse(event['eventDate']!) == date,
              orElse: () => {},
            );

            final eventName = event.isNotEmpty ? event['eventName'] : null;
            final backgroundColor = eventName != null
                ? getEventBackgroundColor(eventName!)
                : Colors.transparent;

            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}

 */

/*
/// another calendar
class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  final CleanCalendarController _calendarController = CleanCalendarController(
    minDate: DateTime(2024, 1, 1),
    maxDate: DateTime(2024, 12, 31),
    onDayTapped: (DateTime date) {
      // Handle day tapped event
    },
    onRangeSelected: (DateTime minDate, DateTime? maxDate) {
      // Handle range selected event
    },
  );

  Map<DateTime, List<String>> events = {
    DateTime(2024, 2, 1): ['P'],
    DateTime(2024, 2, 5): ['A', 'H'],
    DateTime(2024, 2, 10): ['L', 'WH'],
    // Add more events as needed
  };

  Color getEventBackgroundColor(String eventName) {
    switch (eventName) {
      case 'P':
        return Colors.cyan.shade100;
      case 'A':
        return Colors.red.shade200;
      case 'L':
        return Colors.green.shade500;
      case 'H':
        return Colors.orange.shade300;
      case 'WH':
        return Colors.yellow.shade300;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Calendar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ScrollableCleanCalendar(
          calendarController: _calendarController,
          dayBuilder: (BuildContext context, DayValues values) {
            final date = values.day;
            final eventColors = events[date] ?? [];
            final selected = values.isSelected;
             // final disabled = values.disabled;

            Color backgroundColor;

            if (selected) {
              backgroundColor = Colors.blue; // Customize as needed
            }
            // else if (disabled) {
            //   backgroundColor = Colors.grey.withOpacity(0.5); // Customize as needed
            // }
            else {
              backgroundColor = eventColors.isEmpty
                  ? Colors.transparent
                  : getEventBackgroundColor(eventColors.first);
            }

            return Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

 */

/*
class CalendarEvent {
  final String eventName;
  final DateTime eventDate;

  CalendarEvent({
    required this.eventName,
    required this.eventDate,
  });
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _currentMonth;

  // Sample JSON data representing events
  final String jsonData = '''
    [
      {"eventName": "P", "eventDate": "2024-02-01"},
      {"eventName": "P", "eventDate": "2024-02-02"},
      {"eventName": "P", "eventDate": "2024-02-03"},
      {"eventName": "A", "eventDate": "2024-02-04"},
      {"eventName": "P", "eventDate": "2024-02-05"},
      {"eventName": "A", "eventDate": "2024-02-06"},
      {"eventName": "L", "eventDate": "2024-02-13"},
      {"eventName": "H", "eventDate": "2024-02-15"},
      {"eventName": "WH", "eventDate": "2024-02-20"}
    ]
  ''';

  List<CalendarEvent> _events = [];

  void _loadEventsFromJson() {
    final List<dynamic> jsonDataList = jsonDecode(jsonData);
    _events = jsonDataList.map((data) {
      return CalendarEvent(
        eventName: data['eventName'],
        eventDate: DateTime.parse(data['eventDate']),
      );
    }).toList();
  }

  Color getEventBackgroundColor(String eventName) {
    switch (eventName) {
      case 'P':
        return Colors.cyan.shade100;
      case 'A':
        return Colors.red.shade200;
      case 'L':
        return Colors.green.shade500;
      case 'H':
        return Colors.orange.shade300;
      case 'WH':
        return Colors.yellow.shade300;
      default:
        return Colors.transparent;
    }
  }

  Widget buildCell(DateTime date) {
    List<CalendarEvent> eventsOnDate = _events
        .where((event) => event.eventDate.isAtSameMomentAs(DateTime(date.year, date.month, date.day)))
        .toList();

    Color cellColor = Colors.transparent;

    if (eventsOnDate.isNotEmpty) {
      cellColor = getEventBackgroundColor(eventsOnDate.first.eventName);
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: cellColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              DateFormat('EEE').format(date), // Display the day of the week
              style: const TextStyle(
                color: Colors.black,
                fontSize: 8,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMonth(DateTime firstDayOfMonth) {
    List<Widget> dayWidgets = [];
    DateTime currentDate = DateTime(firstDayOfMonth.year, firstDayOfMonth.month, 1);
    int daysInMonth = DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day;

    while (currentDate.month == firstDayOfMonth.month) {
      dayWidgets.add(buildCell(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return dayWidgets[index];
      },
      itemCount: dayWidgets.length,
    );
  }

  Widget buildMonthHeader(String monthName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            monthName,
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 5
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _loadEventsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (BuildContext context, int monthIndex) {
          final DateTime currentMonth = DateTime.now();
          final DateTime firstDayOfMonth = DateTime(currentMonth.year, monthIndex + 1, 1);

          return Container(
            margin: const EdgeInsets.all(6),
            child: Column(
              children: [
                buildMonthHeader(DateFormat('MMMM').format(firstDayOfMonth)),
                buildMonth(firstDayOfMonth),
              ],
            ),
          );
        },
      ),
    );
  }
}

 */