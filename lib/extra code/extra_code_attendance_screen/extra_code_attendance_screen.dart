

/// This calender code is correct ----->>>>>
/*class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9 ?? 300,
      height: MediaQuery.of(context).size.height * 0.5 ?? 200,
      child: CalendarPage(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  final List<CalendarEvent> _events = [
    CalendarEvent(
      eventName: 'P',
      eventDate: DateTime(2024, 2, 1),
      eventTextStyle: TextStyle(color: Colors.cyan.shade100, fontWeight: FontWeight.bold),
    ),
    CalendarEvent(
      eventName: 'A',
      eventDate: DateTime(2024, 2, 5),
      eventTextStyle: TextStyle(color: Colors.red.shade200, fontWeight: FontWeight.bold),
    ),
    CalendarEvent(
      eventName: 'L',
      eventDate: DateTime(2024, 2, 13),
      eventTextStyle: TextStyle(color: Colors.green.shade500, fontWeight: FontWeight.bold),
    ),
    CalendarEvent(
      eventName: 'H',
      eventDate: DateTime(2024, 2, 15),
      eventTextStyle: TextStyle(color: Colors.orange.shade300, fontWeight: FontWeight.bold),
    ),
    CalendarEvent(
      eventName: 'WH',
      eventDate: DateTime(2024, 2, 20),
      eventTextStyle: TextStyle(color: Colors.yellow.shade300, fontWeight: FontWeight.bold),
    ),
  ];

  // Sample JSON data representing events
  final String jsonData = '''
    [
      {"eventName": "P", "eventDate": "2024-02-01", "eventColor": "#00FFF"},
      {"eventName": "A", "eventDate": "2024-02-05", "eventColor": "#FF0000"},
      {"eventName": "L", "eventDate": "2024-02-13", "eventColor": "#008000"},
      {"eventName": "H", "eventDate": "2024-02-15", "eventColor": "#FFA500"},
      {"eventName": "WH", "eventDate": "2024-02-20", "eventColor": "#FFFF00"}
    ]
  ''';

  List<CalendarEvent> getEventsFromJson(String jsonData) {
    final List<dynamic> parsedData = jsonDecode(jsonData);
    return parsedData.map((data) {
      return CalendarEvent(
        eventName: data['eventName'],
        eventDate: DateTime.parse(data['eventDate']),
        eventTextStyle: TextStyle(color: HexColor(data['eventColor']), fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CellCalendar(
      events: _events,
      onCellTapped: (date) {
        // Handle the tapped date as needed
        print("$date is tapped!");
      },
      daysOfTheWeekBuilder: (dayIndex) {
        final labels = ["S", "M", "T", "W", "T", "F", "S"];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            labels[dayIndex],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
      monthYearLabelBuilder: (datetime) {
        if (datetime != null) {
          final year = datetime.year.toString();
          final month = datetime.month.toString();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "$month, $year",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// Utility class to convert hex color string to Color
class HexColor extends Color {
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

 */

/// ----------->>>>>>>>>
/*
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey _calendarKey = GlobalKey();  final Map<DateTime, EventWrapper> attendanceData = {
    DateTime(2024, 2, 1): EventWrapper('present'),
    DateTime(2024, 2, 5): EventWrapper('present'),
    DateTime(2024, 2, 13): EventWrapper('leave'),
    DateTime(2024, 2, 15): EventWrapper('holiday'),
    DateTime(2024, 2, 20): EventWrapper('weekend_holiday'),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _calendarKey,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: CalendarCarousel<EventWrapper>(
        onDayPressed: (DateTime date, List<EventWrapper> events) {
          // Handle day pressed
          // print(date);
        },
        weekendTextStyle: const TextStyle(color: Colors.grey),
        headerTextStyle: const TextStyle(color: Colors.grey),
        thisMonthDayBorderColor: Colors.grey,
        customDayBuilder: (
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          Color cellColor = EColors.calenderBoxColor;
          Color textColor = Colors.black;

          if (isToday) {
            if (attendanceData.containsKey(day)) {
              switch (attendanceData[day]!.type) {
                case 'absent':
                  cellColor = Colors.red.shade200;
                  break;
                case 'present':
                  cellColor = Colors.cyan.shade100;
                  break;
                case 'leave':
                  cellColor = Colors.green.shade500;
                  break;
                case 'holiday':
                  cellColor = Colors.orange.shade300;
                  break;
                case 'weekend_holiday':
                  cellColor = Colors.yellow.shade300;
                  break;
              }
            } else {
              // Default color for today if not in attendanceData
              cellColor = EColors.calenderBoxColor;
            }
          } else if (attendanceData.containsKey(day)) {
            switch (attendanceData[day]!.type) {
              case 'absent':
                cellColor = Colors.red.shade200;
                break;
              case 'present':
                cellColor = Colors.cyan.shade100;
                break;
              case 'leave':
                cellColor = Colors.green.shade500;
                break;
              case 'holiday':
                cellColor = Colors.orange.shade300;
                break;
              case 'weekend_holiday':
                cellColor = Colors.yellow.shade300;
                break;
            }
          }

          if (!isThisMonthDay) {
            textColor = Colors.grey;
          } else if (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) {
            textColor = Colors.grey;
          }

          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: cellColor,
                borderRadius: BorderRadius.circular(isToday ? 30 : 8),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventWrapper implements EventInterface {
  final String type;

  EventWrapper(this.type);

  @override
  String toString() => type;

  @override
  DateTime getDate() => throw UnimplementedError();

  @override
  String? getDescription() => throw UnimplementedError();

  @override
  Widget? getDot() => throw UnimplementedError();

  @override
  Widget? getIcon() => throw UnimplementedError();

  @override
  int? getId() => throw UnimplementedError();

  @override
  String? getLocation() => throw UnimplementedError();

  @override
  String? getTitle() => throw UnimplementedError();
}


 */



///  --------- >
/*
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import 'attendance_widgets/example_attendance_boxes.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Width inside _CalendarPageState: ${MediaQuery.of(context).size.width}');
    // print('Height inside _CalendarPageState: ${MediaQuery.of(context).size.height}');
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

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9 ?? 300, // replace 300 with a default width
                height: MediaQuery.of(context).size.height * 0.5 ?? 200, // replace 200 with a default height
                child: const CalendarPage(),
              ),


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