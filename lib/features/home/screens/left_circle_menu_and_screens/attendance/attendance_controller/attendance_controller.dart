import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../attendance_screen.dart';

/// Attendance Controller using GetX
class AttendanceController extends GetxController {
  late DateTime currentMonth;
  final PageController pageController = PageController(initialPage: DateTime.now().month - 1);

  @override
  void onInit() {
    super.onInit();
    currentMonth = DateTime.now();
    _loadEventsFromJson();
    loadEventsForCurrentMonth();
  }
  // Define the method to load events for the current month
  void loadEventsForCurrentMonth() {
    _loadEventsFromJson();
  }


  List<CalendarEvent> _events = [];

  void _loadEventsFromJson() {
    // const jsonData = '''
    //   [
    //     {"eventName": "P", "eventDate": "2024-02-01"},
    //     {"eventName": "P", "eventDate": "2024-02-02"},
    //     {"eventName": "P", "eventDate": "2024-02-03"},
    //     {"eventName": "A", "eventDate": "2024-02-04"},
    //     {"eventName": "P", "eventDate": "2024-02-05"},
    //     {"eventName": "A", "eventDate": "2024-02-06"},
    //     {"eventName": "L", "eventDate": "2024-02-13"},
    //     {"eventName": "H", "eventDate": "2024-02-15"},
    //     {"eventName": "WH", "eventDate": "2024-02-20"}
    //   ]
    // ''';

    // final List<dynamic> jsonDataList = jsonDecode(jsonData);
    // _events = jsonDataList.map((data) {
    //   return CalendarEvent(
    //     eventName: data['eventName'],
    //     eventDate: DateTime.parse(data['eventDate']),
    //   );
    // }).toList();
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
}
