/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../data/api/api_services.dart';
import '../../utils/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';

class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  Future<Timetable>? timetableData;

  @override
  void initState() {
    super.initState();
    timetableData = ApiService.getTimetable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            color: EColors.textPrimaryHeading,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: FutureBuilder<Timetable>(
        future: timetableData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print('Error fetching timetable data: ${snapshot.error}');
            return Center(child: Text('Error fetching timetable data. Please try again.'));
          } else if (snapshot.hasData) {
            Timetable data = snapshot.data!;
            return DefaultTabController(
              length: data.days.length,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      constraints: const BoxConstraints.expand(height: 60),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE0E5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFFFC1C5),
                            offset: Offset(-2, -2),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(5, 5),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.all(8),
                        isScrollable: true,
                        physics: const BouncingScrollPhysics(),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: const Color(0xFFFFE0E5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFFFC1C5),
                              offset: Offset(-2, -2),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(5, 5),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        labelColor: const Color(0xFF3C4043),
                        tabs: data.days
                            .map((day) => Tab(
                          text: day.day,
                          iconMargin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TabBarView(
                        children: data.days
                            .map((day) => buildDayTimetable(context, day))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No timetable data available.'));
          }
        },
      ),
    );
  }

  Widget buildDayTimetable(BuildContext context, Day day) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for ${day.day}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3C4043),
              ),
            ),
            const SizedBox(height: 20),
            if (day.periodData.isNotEmpty) ...{
              for (var periodEntry in day.periodData) ...{
                AnimatedTimetableEntry(
                  entry: periodEntry,
                ),
              }
            } else ...{
              Center(
                child: Text(
                  'No timetable available for ${day.day}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            },
            GestureDetector(
              onTap: () {
                // Handle lunch container tap
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFFFC1C5),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFE0E5),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lunch Break',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C4043),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '12:00 PM - 1:00 PM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          3,  // Adjust the number of shimmer items as needed
              (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedTimetableEntry extends StatelessWidget {
  final PeriodData entry;

  AnimatedTimetableEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0E5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFFC1C5),
            offset: Offset(-2, -2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(5, 5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lecturer ${entry.period ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.time ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            entry.subject ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
          Text(
            'Prof. ${entry.teacher}',
            style: const TextStyle(
              color: Color(0xFF3C4043),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class Timetable {
  final List<Day> days;
  final String message;
  final String status;

  Timetable({
    required this.days,
    required this.message,
    required this.status,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    List<dynamic> timetableData = json['response'];
    List<Day> days = timetableData.map((dayData) => Day.fromJson(dayData)).toList();

    return Timetable(
      days: days,
      message: json['message'],
      status: json['status'],
    );
  }
}

class Day {
  final String day;
  final List<PeriodData> periodData;

  Day({
    required this.day,
    required this.periodData,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    List<dynamic> periodDataList = json['perioddata'];
    List<PeriodData> periodData =
    periodDataList.map((periodEntry) => PeriodData.fromJson(periodEntry)).toList();

    return Day(
      day: json['day'],
      periodData: periodData,
    );
  }
}

class PeriodData {
  final String period;
  final String time;
  final String subject;
  final String teacher;

  PeriodData({
    required this.period,
    required this.time,
    required this.subject,
    required this.teacher,
  });

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    return PeriodData(
      period: json['period'],
      time: json['time'],
      subject: json['subject'],
      teacher: json['teacher'],
    );
  }
}


 */
///



// class AnimatedTimetableEntry extends StatelessWidget {
//   final Map<String, dynamic> entry;
//
//   AnimatedTimetableEntry({required this.entry});
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: customDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Period ${entry['period'] ?? ''}',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF3C4043),
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             entry['time'] ?? '',
//             style: const TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//           Text(
//             entry['subject'] ?? '',
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF9C27B0),
//             ),
//           ),
//           if (entry['teacher'] != null)
//             Text(
//               'Teacher: ${entry['teacher']}',
//               style: const TextStyle(
//                 color: Color(0xFF3C4043),
//                 fontSize: 13,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/time_table/widgets/decoration/contanier_decoration.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../data/api/api_services.dart';
import '../../utils/constants/sizes.dart';

class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            color: EColors.textPrimaryHeading,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.fetchTimetable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, dynamic> responseData = snapshot.data!;
            List<dynamic> timetableData = responseData['response'] ?? [];

            return DefaultTabController(
              length: timetableData.length,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      constraints: const BoxConstraints.expand(height: 60),
                      decoration: customDecoration(),
                      child: TabBar(
                        padding: const EdgeInsets.all(8),
                        isScrollable: true,
                        physics: const BouncingScrollPhysics(),
                        indicator: customDecoration(),
                        labelColor: const Color(0xFF3C4043),
                        tabs: timetableData
                            .map((dayData) {
                          String day = dayData.keys.first;
                          return Tab(
                            text: day,
                            iconMargin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                          );
                        })
                            .cast<Widget>()
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TabBarView(
                        children: timetableData
                            .map((dayData) {
                          return buildDayTimetable(dayData);
                        })
                            .cast<Widget>()
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Invalid API response format.'));
          }
        },
      ),
    );
  }

  Widget buildDayTimetable(Map<String, dynamic> dayData) {
    String day = dayData.keys.first;
    List<Map<String, dynamic>> timetableForDay =
        (dayData[day] as List?)?.cast<Map<String, dynamic>>() ?? [];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for $day',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: EColors.textColorPrimary1,
                fontFamily: 'Inter'
              ),
            ),
            const SizedBox(height: 20),
            for (var entry in timetableForDay)
              buildPeriodCard(entry),
              // buildPeriodCard(entry),
            // ... Additional UI elements
          ],
        ),
      ),
    );
  }

  Widget buildPeriodCard(Map<String, dynamic> period) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: customDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lecture ${period['period'] ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            period['time'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            period['subject'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              // color: Color(0xFF9C27B0),
              color: EColors.primary,
            ),
          ),
          if (period['teacher'] != null)
            Text(
              'Lecturer: ${period['teacher']}',
              style: const TextStyle(
                color: Color(0xFF3C4043),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
    // return Card(
    //   margin: const EdgeInsets.only(bottom: 16),
    //   child: ListTile(
    //     title: Text(
    //       'Lecturer ${period['period'] ?? ''}',
    //       style: const TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xFF3C4043),
    //         fontSize: 18,
    //       ),
    //     ),
    //     subtitle: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           period['time'] ?? '',
    //           // period['time'] ?? '',
    //           style: const TextStyle(
    //             color: Colors.grey,
    //             fontSize: 12,
    //           ),
    //         ),
    //         Text(
    //           ' ${period['subject'] ?? ''}',
    //           // period['subject'] ?? '',
    //           style: const TextStyle(
    //             fontSize: 13,
    //             fontWeight: FontWeight.bold,
    //             color: EColors.primary,
    //           ),
    //         ),
    //         if (period['teacher'] != null)
    //           Text(
    //             'Teacher: ${period['teacher']}',
    //             style: const TextStyle(
    //               color: Color(0xFF3C4043),
    //               fontSize: 13,
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }


}

class AnimatedTimetableEntry extends StatelessWidget {
  final Map<String, dynamic> entry;

  AnimatedTimetableEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: customDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Period ${entry['period'] ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry['time'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            entry['subject'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
          if (entry['teacher'] != null)
            Text(
              'Teacher: ${entry['teacher']}',
              style: const TextStyle(
                color: Color(0xFF3C4043),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}
*/




/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  Map<String, List<Map<String, dynamic>>>? _timetable; // Updated data type
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetchTimetable();
  }

  Future<void> _fetchTimetable() async {
    setState(() {
      _isLoading = true;
    });

    const headers = {
      'Cookie': 'ci_session=3obslvn95emuo6635jurbm9blaoil578',
    };
    const requestUrl = 'http://myglobalapp.in/global/API005/student_timetable';
    const apiKey = 'GNCS0225';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    String userType = prefs.getString('user_type') ?? '';

    // Handle potential null values from SharedPreferences
    if (userId.isEmpty || userType.isEmpty) {
      _errorMessage = 'Please store user ID and type in SharedPreferences';
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(requestUrl),
        headers: headers,
        body: {
          'APIKEY': apiKey,
          'USER_ID': userId,
          'USER_TYPE': userType,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == '1') {
          if (jsonData['response'] is List<dynamic>) {
            _timetable = {};
            for (final dayData in jsonData['response']) {
              final dayName = dayData.keys.first; // Get the first key (day name)
              _timetable![dayName] = dayData[dayName].cast<List<Map<String, dynamic>>>();
            }
          } else {
            print(response.body);
            print(response.body);
            _errorMessage = 'Unexpected response format';
          }
        } else {
          print(response.reasonPhrase);
          print(response.bodyBytes);
          _errorMessage = jsonData['message'] ?? 'Unknown error';
        }
      } else {
        _errorMessage = response.reasonPhrase ?? 'Network error';
      }
    } catch (error) {
      print(requestUrl);
      print(_timetable);
      print(_errorMessage);
      print(prefs);
      print(error);
      _errorMessage = 'Error fetching timetable: $error';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(_errorMessage),
      );
    }

    return DefaultTabController(
      length: _timetable!.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Timetable'),
          bottom: TabBar(
            isScrollable: true,
            tabs: _timetable!.keys.map((day) => Tab(text: day)).toList(),
          ),
        ),
        body: TabBarView(
          children: _timetable!.keys.map((day) {
            final dayTimetable = _timetable![day]!; // Access using the day key
            return _buildDayTimetable(dayTimetable);
          }).toList(),
        ),
      ),
    );
  }

  // Updated _buildDayTimetable method
  Widget _buildDayTimetable(List<Map<String, dynamic>> dayTimetable) {
    return ListView.builder(
      itemCount: dayTimetable.length,
      itemBuilder: (context, index) {
        final slot = dayTimetable[index];
        return ListTile(
          title: Text(slot['subject']),
          subtitle: Text('${slot['period']} - ${slot['time']}'),
          trailing: Text(slot['teacher']),
        );
      },
    );
  }
}


 */






///
/*
/// Correct UI Code ->>>>
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/sizes.dart';

class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final Map<String, List<Map<String, dynamic>>> timetableData = {
    'Monday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject': 'Spacecraft Design & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Tuesday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Wednesday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Thursday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Friday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            color: EColors.textPrimaryHeading,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: timetableData.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                constraints: const BoxConstraints.expand(height: 60),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E5),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFFFC1C5),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TabBar(
                  padding: const EdgeInsets.all(8),
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xFFFFE0E5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFFFC1C5),
                        offset: Offset(-2, -2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 5),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  labelColor: const Color(0xFF3C4043),
                  tabs: timetableData.keys
                      .map((day) => Tab(
                    text: day,
                    iconMargin:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TabBarView(
                  children: timetableData.keys
                      .map((day) => buildDayTimetable(context, day))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayTimetable(BuildContext context, String day) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for $day',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3C4043),
              ),
            ),
            const SizedBox(height: 20),
            for (var entry in timetableData[day]!)
              AnimatedTimetableEntry(entry: entry),
            // Lunch Container
            GestureDetector(
              onTap: () {
                // Handle lunch container tap
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFFFC1C5),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFE0E5),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lunch Break',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C4043),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '12:00 PM - 1:00 PM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AnimatedTimetableEntry extends StatelessWidget {
  final Map<String, dynamic> entry;

  AnimatedTimetableEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0E5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFFC1C5),
            offset: Offset(-2, -2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(5, 5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lecturer ${entry['period'] ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry['time'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            entry['subject'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
          if (entry['professor'] != null)
            Text(
              'Prof. ${entry['professor']}',
              style: const TextStyle(
                color: Color(0xFF3C4043),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}

/// Correct UI Code ->>>>
 */



/// --------



/// +++++++++
/*
import 'package:flutter/material.dart';

import '../../data/api/api_services.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? timetableData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // Assuming 5 days for Monday to Friday
    fetchData();
  }

  void fetchData() async {
    try {
      // String userId = ''; // Get user_id from local storage
      // String userType = ''; // Get user_type from local storage

      Map<String, dynamic> data = await ApiService.fetchTimetable();

      setState(() {
        timetableData = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            for (var day in timetableData?['response'] ?? [])
              Tab(text: day.keys.first), // Assuming each day is a tab
          ],
        ),
      ),
      body: timetableData != null
          ? TabBarView(
        controller: _tabController,
        children: [
          for (var day in timetableData!['response'])
            DayTimetableWidget(day: day),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DayTimetableWidget extends StatelessWidget {
  final Map<String, dynamic> day;

  DayTimetableWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    print("Day data: $day");

    // Extract the list of periods for the day
    List<dynamic> periods = day[day.keys.first] ?? [];

    if (periods.isEmpty) {
      return Center(
        child: Text('No timetable available for ${day.keys.first}'),
      );
    }

    return ListView.builder(
      itemCount: periods.length,
      itemBuilder: (context, index) {
        var period = periods[index]['period'];
        var time = periods[index]['time'];
        var subject = periods[index]['subject'];
        var teacher = periods[index]['teacher'];

        print("Period: $period, Time: $time, Subject: $subject, Teacher: $teacher");

        return ListTile(
          title: Text('Period $period - $subject'),
          subtitle: Text('$time | Teacher: $teacher'),
        );
      },
    );
  }
}


 */
//// ---- ++++


/*

import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/time_table/widgets/decoration/contanier_decoration.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../data/api/api_services.dart';
import '../../utils/constants/sizes.dart';

class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            color: EColors.textPrimaryHeading,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.fetchTimetable(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Map<String, dynamic> responseData = snapshot.data!;
            List<dynamic> timetableData = responseData['response'] ?? [];

            return DefaultTabController(
              length: timetableData.length,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      constraints: const BoxConstraints.expand(height: 60),
                      decoration: customDecoration(),
                      child: TabBar(
                        padding: const EdgeInsets.all(8),
                        isScrollable: true,
                        physics: const BouncingScrollPhysics(),
                        indicator: customDecoration(),
                        labelColor: const Color(0xFF3C4043),
                        tabs: timetableData
                            .map((dayData) {
                          String day = dayData.keys.first;
                          return Tab(
                            text: day,
                            iconMargin: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                          );
                        })
                            .cast<Widget>()
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TabBarView(
                        children: timetableData
                            .map((dayData) {
                          return buildDayTimetable(dayData);
                        })
                            .cast<Widget>()
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Invalid API response format.'));
          }
        },
      ),
    );
  }

  Widget buildDayTimetable(Map<String, dynamic> dayData) {
    String day = dayData.keys.first;
    List<Map<String, dynamic>> timetableForDay =
        (dayData[day] as List?)?.cast<Map<String, dynamic>>() ?? [];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for $day',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3C4043),
              ),
            ),
            const SizedBox(height: 20),
            for (var entry in timetableForDay)
              buildPeriodCard(entry),
            // ... Additional UI elements
          ],
        ),
      ),
    );
  }

  Widget buildPeriodCard(Map<String, dynamic> period) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(
          'Period ${period['period'] ?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3C4043),
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              period['time'] ?? '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Text(
              period['subject'] ?? '',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            if (period['teacher'] != null)
              Text(
                'Teacher: ${period['teacher']}',
                style: const TextStyle(
                  color: Color(0xFF3C4043),
                  fontSize: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }


}

class AnimatedTimetableEntry extends StatelessWidget {
  final Map<String, dynamic> entry;

  AnimatedTimetableEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: customDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Period ${entry['period'] ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry['time'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            entry['subject'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
          if (entry['teacher'] != null)
            Text(
              'Teacher: ${entry['teacher']}',
              style: const TextStyle(
                color: Color(0xFF3C4043),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}


 */

///

///
/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/api/api_services.dart';

// class Timetable {
//   final String day;
//   final List<Map<String, String>> periodData;
//
//   Timetable({required this.day, required this.periodData});
//
//   factory Timetable.fromJson(Map<String, dynamic> json) {
//     return Timetable(
//       day: json['day'],
//       periodData: (json['perioddata'] as List)
//           .map((period) => {
//         'period': period['period'].toString(),
//         'time': period['time'].toString(),
//         'subject': period['subject'].toString(),
//         'teacher': period['teacher'].toString(),
//       })
//           .toList(),
//     );
//   }
//
// }

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class Timetable {
  final String day;
  final List<PeriodData> periodData;

  Timetable({required this.day, required this.periodData});

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      day: json['day'],
      periodData: (json['perioddata'] as List)
          .map((period) => PeriodData.fromJson(period))
          .toList(),
    );
  }
}

class PeriodData {
  final String period;
  final String time;
  final String subject;
  final String teacher;

  PeriodData({
    required this.period,
    required this.time,
    required this.subject,
    required this.teacher,
  });

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    return PeriodData(
      period: json['period'],
      time: json['time'],
      subject: json['subject'],
      teacher: json['teacher'],
    );
  }
}

class _TimeTableState extends State<TimeTable> {
  List<Timetable> timetableList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final responseData = await ApiService.fetchTimetable();

      if (responseData['status'] == '1') {
        List<dynamic> responseList = responseData['response'];
        timetableList =
            responseList.map((item) => Timetable.fromJson(item)).toList();

        // Debug prints
        print('Timetable List Length: ${timetableList.length}');
        for (var timetable in timetableList) {
          print('Day: ${timetable.day}');
          for (var period in timetable.periodData) {
            print(
                'Period: ${period.period}, Time: ${period.time}, Subject: ${period.subject}, Teacher: ${period.teacher}');
          }
        }

        setState(() {});
      } else {
        print(responseData['message']);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
      ),
      body: timetableList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: timetableList.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: timetableList
                        .map((timetable) => Tab(text: timetable.day))
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: timetableList.map((timetable) {
                        return ListView.builder(
                          itemCount: timetable.periodData.length,
                          itemBuilder: (context, index) {
                            final period = timetable.periodData[
                                index]; // Accessing PeriodData object

                            return ListTile(
                              title: Text(
                                  'Period: ${period.period}'), // Using period property
                              subtitle: Text(
                                  'Time: ${period.time}'), // Using time property
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      'Subject: ${period.subject}'), // Using subject property
                                  Text(
                                      'Teacher: ${period.teacher}'), // Using teacher property
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

 */

/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/sizes.dart';

class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final Map<String, List<Map<String, dynamic>>> timetableData = {
    'Monday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject': 'Spacecraft Design & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Tuesday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Wednesday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Thursday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
    'Friday': [
      {
        'Lecturer': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'Lecturer': '2',
        'subject':
        'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'Lecturer': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        title: Text(
          'Time Table',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            color: EColors.textPrimaryHeading,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: timetableData.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                constraints: const BoxConstraints.expand(height: 60),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E5),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFFFC1C5),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TabBar(
                  padding: const EdgeInsets.all(8),
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xFFFFE0E5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFFFC1C5),
                        offset: Offset(-2, -2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 5),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  labelColor: const Color(0xFF3C4043),
                  tabs: timetableData.keys
                      .map((day) => Tab(
                    text: day,
                    iconMargin:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TabBarView(
                  children: timetableData.keys
                      .map((day) => buildDayTimetable(context, day))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayTimetable(BuildContext context, String day) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable for $day',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3C4043),
              ),
            ),
            const SizedBox(height: 20),
            for (var entry in timetableData[day]!)
              AnimatedTimetableEntry(entry: entry),
            // Lunch Container
            GestureDetector(
              onTap: () {
                // Handle lunch container tap
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E5),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFFFC1C5),
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Color(0xFFFFE0E5),
                      offset: Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lunch Break',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C4043),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '12:00 PM - 1:00 PM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AnimatedTimetableEntry extends StatelessWidget {
  final Map<String, dynamic> entry;

  AnimatedTimetableEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE0E5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFFC1C5),
            offset: Offset(-2, -2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(5, 5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lecturer ${entry['period'] ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3C4043),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry['time'] ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            entry['subject'] ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
            ),
          ),
          if (entry['professor'] != null)
            Text(
              'Prof. ${entry['professor']}',
              style: const TextStyle(
                color: Color(0xFF3C4043),
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }
}


 */

// static Future<void> getTimeTable() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String userId = prefs.getString('user_id') ?? '';
//   String userType = prefs.getString('user_type') ?? '';
//
//   var headers = {
//     'Cookie': 'ci_session=pmhmf9h9ej3u5oo1d7b6l4ofbhl9v5j2',
//   };
//
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse(APIConstants.getFullUrl(APIConstants.getTimeTable)),
//   );
//
//   request.fields.addAll({
//     'APIKEY': 'GNCS0225',
//     'USER_ID': userId,
//     'USER_TYPE': userType,
//   });
//
//   request.headers.addAll(headers);
//
//   try {
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       // Handle the response data as needed
//     } else {
//       print(response.reasonPhrase);
//       // Handle error
//     }
//   } catch (e) {
//     print('Error: $e');
//     // Handle exception
//   }
// }



/*
  static Future<Map<String, dynamic>> getTimeTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    String userType = prefs.getString('user_type') ?? '';

    var headers = {
      'Cookie': 'ci_session=ga2gv43kdoaqr8bs0f91tqof0rss55r4',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(APIConstants.getFullUrl(APIConstants.getTimeTable)));

    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> decodedResponse = json.decode(responseBody);
        return decodedResponse;
      } else {
        return {
          'status': '0',
          'message': 'Failed to fetch time table',
        };
      }
    } catch (e) {
      return {
        'status': '0',
        'message': 'Error: $e',
      };
    }
  }


   */

/// -----
/*
  static Future<Map<String, dynamic>> fetchTimetable() async {
    try {
      // Retrieve user_id and user_type from local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('user_id') ?? '';
      String userType = prefs.getString('user_type') ?? '';

      var headers = {
        'Cookie': 'ci_session=ofmkjs7j9v66paef1l5428hhmti32c1s',
      };

      var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/student_timetable'));

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'USER_TYPE': userType,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());
        return responseData;
      } else {
        print(response.reasonPhrase);
        return {'error': response.reasonPhrase};
      }
    } catch (error) {
      print('Error: $error');
      return {'error': 'Error occurred during API request'};
    }
  }
   */