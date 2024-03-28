import 'package:flutter/material.dart';
import '../../common/widgets/Heading_Container_Horizontal/horizontal_heading_Container.dart';
import '../../common/widgets/time_table/time_table_widget.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class TimetableScreen extends StatelessWidget {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // Replace the data with your actual schedule
  final Map<String, List<Map<String, String>>> timetableData = {
    'Monday': [
      {'period': '1', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '2', 'subject': 'Spacecraft Design & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '3', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},
      // Add more entries for Monday as needed
      {'period': '4', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '5', 'subject': 'Spacecraft Design & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '6', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},
    ],
    'Tuesday': [
      {'period': '1', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '2', 'subject': 'Spacecraft Design & Systems Engineering & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '3', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},
      // Add more entries for Tuesday as needed
    ],
    // Repeat the same structure for other days
    'Wednesday': [
      {'period': '1', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '2', 'subject': 'Spacecraft Design & Systems Engineering & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '3', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},],
    'Thursday': [
      {'period': '1', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '2', 'subject': 'Spacecraft Design & Systems Engineering & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '3', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},],
    'Friday': [
      {'period': '1', 'subject': 'Orbital Mechanics', 'professor': 'Prof. Amelia Bennett', 'time': '9:00 AM'},
      {'period': '2', 'subject': 'Spacecraft Design & Systems Engineering & Systems Engineering', 'professor': 'Prof. Marcus Rodriguez', 'time': '9:45 AM'},
      {'period': '3', 'subject': 'Aerodynamics', 'professor': 'Prof. Elena Chang', 'time': '10:30 AM'},],
  };

  TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: days.length,
      child: Column(
        children: [
          // Custom Tab Container with gradient and rounded corners.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: TabBar(
                    isScrollable: true,
                    indicator: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFFFFEEEE),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black, // Customize the label color
                    unselectedLabelColor: Colors.black, // Customize the unselected label color
                    tabs: days.map((day) => Tab(text: day)).toList(),
                  ),
                ),
              ),
            ),
          ),

          // TabBarView with improved schedule UI
          Expanded(
            child: TabBarView(
              children: days.map((day) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: EColors.primary,
                        ),
                      ),
                      const SizedBox(height: ESizes.spaceBtwItemsHeadings), // Adjust the height as needed
                      const HeadingContainerTexts(titleOne: 'Period', titleSecond: 'Subject & Professor', titleThird: 'Timing',),
                      const SizedBox(height: ESizes.spaceBtwItemsHeadings), // Adjust the height as needed
                      Column(
                        children: [
                          for (final schedule in timetableData[day]!)
                            ClassSchedule(
                              period: schedule['period']!,
                              subject: schedule['subject']!,
                              professor: schedule['professor']!,
                              time: schedule['time']!,
                            ),
                          // Add more ClassSchedule widgets for each schedule on the day
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

        ],
      ),
    );
  }
}

