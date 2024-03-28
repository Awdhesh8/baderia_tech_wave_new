import 'package:flutter/material.dart';

class ClassSchedule extends StatelessWidget {
  final String period;
  final String subject;
  final String professor;
  final String time;

  const ClassSchedule({
    required this.period,
    required this.subject,
    required this.professor,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
      // decoration: ShapeDecoration(
      //   color: Colors.white,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),

      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            // height: 64,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    period,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            textAlign: TextAlign.start,
                                            subject,
                                            style: const TextStyle(
                                              color: Color(0xFF353535),
                                              fontSize: 13,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              // height: 1.2,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            professor,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Color(0xFFE31E24),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              // height: 1.2,
                                            ),
                                            // maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    time,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}




// class ClassSchedule extends StatelessWidget {
//   final String period;
//   final String subject;
//   final String professor;
//   final String time;
//
//   const ClassSchedule({
//     required this.period,
//     required this.subject,
//     required this.professor,
//     required this.time,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flex(
//           direction: Axis.vertical,
//           children: [
//             Container(
//               decoration: ShapeDecoration(
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 64,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFFEEEE),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 period,
//                                 style: TextStyle(
//                                   color: Color(0xFF353535),
//                                   fontSize: 14,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       subject,
//                                       style: TextStyle(
//                                         color: Color(0xFF353535),
//                                         fontSize: 14,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w600,
//                                         height: 1.2,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                       professor,
//                                       style: TextStyle(
//                                         color: Color(0xFFE31E24),
//                                         fontSize: 12,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w600,
//                                         height: 1.2,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 time,
//                                 style: TextStyle(
//                                   color: Color(0xFF353535),
//                                   fontSize: 12,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
