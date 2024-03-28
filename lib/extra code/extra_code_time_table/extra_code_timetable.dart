/// Original code of the timetable screen ---->
/*

import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/time_table/time_table_data.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final Map<String, List<Map<String, String>>> timetableData = {
    'Monday': [
      {
        'period': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'period': '2',
        'subject': 'Spacecraft Design & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'period': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
      {
        'period': '4',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'period': '5',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'period': '6',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },

      // Add more entries for Monday as needed
    ],
    'Tuesday': [
      {
        'period': '1',
        'subject': 'Orbital Mechanics',
        'professor': 'Prof. Amelia Bennett',
        'time': '9:00 AM',
      },
      {
        'period': '2',
        'subject':
            'Spacecraft Design & Systems Engineering & Systems Engineering',
        'professor': 'Prof. Marcus Rodriguez',
        'time': '9:45 AM',
      },
      {
        'period': '3',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
      {
        'period': '4',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },
      {
        'period': '5',
        'subject': 'Aerodynamics',
        'professor': 'Prof. Elena Chang',
        'time': '10:30 AM',
      },

      // Add more entries for Monday as needed
    ],
    // Repeat the same structure for other days
    // 'Tuesday': [...],
    // 'Wednesday': [...],
    // 'Thursday': [...],
    // 'Friday': [...],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: false,
        title: Text(
          'Time Table',
          style: TextStyle(
              fontSize: ESizes.appTitle,
              color: EColors.textPrimaryHeading,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),

      /// Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [



            Expanded(
              child: TimetableScreen(),
            ),



          ],
        ),
      ),
    );
  }
}


 */


/// -------->>>>>>>>>>

/*

  // // Day-wise timetable
            // for (final day in timetableData.keys)
            //   Column(
            //     children: [
            //       const SizedBox(height: ESizes.spaceBtwItemsHeadings),
            //       Row(
            //         children: [
            //           Text(
            //             day,
            //             style: const TextStyle(
            //                 fontSize: ESizes.fontSizeSm,
            //                 color: EColors.textPrimaryHeading,
            //                 fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: ESizes.spaceBtwItemsHeadings),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               width: double.infinity,
            //               height: 50,
            //               decoration: ShapeDecoration(
            //                 color: Colors.white,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                 ),
            //               ),
            //               child: const Padding(
            //                 padding: EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       'Period',
            //                       style: TextStyle(
            //                         color: Color(0xFF353535),
            //                         fontSize: 14,
            //                         fontFamily: 'Inter',
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                     Text(
            //                       'Subject &\nProfessor',
            //                       style: TextStyle(
            //                         color: Color(0xFF353535),
            //                         fontSize: 14,
            //                         fontFamily: 'Inter',
            //                         fontWeight: FontWeight.w500,
            //                         height: 0,
            //                       ),
            //                     ),
            //                     Text(
            //                       'Class begins',
            //                       style: TextStyle(
            //                         color: Color(0xFF353535),
            //                         fontSize: 14,
            //                         fontFamily: 'Inter',
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: ESizes.spaceBtwItemsHeadings),
            //       Column(
            //         children: [
            //           for (final schedule in timetableData[day]!)
            //             ClassSchedule(
            //               period: schedule['period']!,
            //               subject: schedule['subject']!,
            //               professor: schedule['professor']!,
            //               time: schedule['time']!,
            //             ),
            //           // Add more ClassSchedule widgets for each schedule on the day
            //         ],
            //       ),
            //     ],
            //   ),
            // const SizedBox(height: ESizes.spaceBtwItemsHeadings),
 */
/*
            /// Heading
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: TopHeading(
                text: ETexts.timeTableHeading1,
              ),
            ),

            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            */

/*
            /// Time Table Container
            Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Monday',
                      style: TextStyle(
                          fontSize: ESizes.fontSizeSm,
                          color: EColors.textPrimaryHeading,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItemsHeadings),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Period',
                                style: TextStyle(
                                  color: Color(0xFF353535),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text('Subject &\nProfessor',
                                style: TextStyle(
                                  color: Color(0xFF353535),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              Text(
                                'Class begins',
                                style: TextStyle(
                                  color: Color(0xFF353535),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItemsHeadings),
                Column(
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // width: 365,
                                        height: 64,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFEEEE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1',
                                                style: TextStyle(
                                                  color: Color(0xFF353535),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                             Padding(
                                               padding: EdgeInsets.only(top: 8),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,

                                                 children: [
                                                   Text.rich(
                                                     TextSpan(
                                                       text: 'Orbital Mechanics',
                                                       style: TextStyle(
                                                         color: Color(0xFF353535),
                                                         fontSize: 14,
                                                         fontFamily: 'Inter',
                                                         fontWeight: FontWeight.w600,
                                                         height: 0,
                                                       ),
                                                     ),
                                                   ),
                                                   Text.rich(
                                                     TextSpan(
                                                       text: 'Prof. Amelia Bennett',
                                                       style: TextStyle(
                                                         color: Color(0xFFE31E24),
                                                         fontSize: 12,
                                                         fontFamily: 'Inter',
                                                         fontWeight: FontWeight.w600,
                                                         height: 0,
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                              Text(
                                                ' 9:00 AM',
                                                style: TextStyle(
                                                  color: Color(0xFF353535),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,

                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: ESizes.spaceBtwItemsHeadings),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // width: 365,
                                        height: 64,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFFFEEEE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '1',
                                                style: TextStyle(
                                                  color: Color(0xFF353535),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),

                                             Padding(
                                               padding: EdgeInsets.only(top: 8),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,

                                                 children: [
                                                   Text.rich(
                                                     TextSpan(
                                                       text: 'Orbital Mechanics',
                                                       style: TextStyle(
                                                         color: Color(0xFF353535),
                                                         fontSize: 14,
                                                         fontFamily: 'Inter',
                                                         fontWeight: FontWeight.w600,
                                                         height: 0,
                                                       ),
                                                     ),
                                                   ),
                                                   Text.rich(
                                                     TextSpan(
                                                       text: 'Prof. Amelia Bennett',
                                                       style: TextStyle(
                                                         color: Color(0xFFE31E24),
                                                         fontSize: 12,
                                                         fontFamily: 'Inter',
                                                         fontWeight: FontWeight.w600,
                                                         height: 0,
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                              Text(
                                                ' 9:00 AM',
                                                style: TextStyle(
                                                  color: Color(0xFF353535),
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,

                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
             */
