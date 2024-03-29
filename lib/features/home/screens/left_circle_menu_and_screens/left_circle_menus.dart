import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/applyLeave/apply_leave.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/result.dart';
import 'dart:math';
import '../../../../utils/constants/colors.dart';
import 'package:get/get.dart';
import '../../../notice/notice.dart';
import '../../../personalization/screens/settings/settings.dart';
import 'attendance/attendance_screen.dart';
import 'gate_pass/gate_pass.dart';
import 'library/e_library/e_library.dart';
import 'library/history/book_history.dart';
import 'library/issued_books/issued_books.dart';
import 'library/library_screen.dart';

class LeftSideCircularScrollingBoxes extends StatefulWidget {
  final Function(int) onIndexChanged; // Add this line
  const LeftSideCircularScrollingBoxes({Key? key, required this.onIndexChanged}) : super(key: key);

  @override
  _LeftSideCircularScrollingBoxesState createState() =>
      _LeftSideCircularScrollingBoxesState();
}

class _LeftSideCircularScrollingBoxesState
    extends State<LeftSideCircularScrollingBoxes> {
  final double circleRadius = 128.0;
  final double boxWidth = 50.1;
  final double boxHeight = 90.5;
  late double _angle = 0.0;
  final double fontSize = 11.5;
  int selectedIndex = -1;
  late double previousAngle = 0.0;
  late List<bool> isSelected;

  final List<String> contentListLeft = [
    'Fees', //1
    'Library', //2
    'Attendance',//3
    'Apply Leave',// 4
    'Result',//5
    'Gate Pass',//6
    'eLibrary',//7
    'Book History',//8
    'Notice',//9
    'Issue Books', //10
    'Fees',//11
    'Library',//12
    'Attendance',//13
    'Apply Leave',//14
    'Result',//15
    'Gate Pass',//16
    'Book History',//17
    'Notice',//18
    'Issue Books',//19
  ];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentListLeft.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentListLeft.length;
    double boxSeparationAngle = 2 * pi / numberOfBoxes;

    return Container(
      width: 180,
      height: 400,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(-1, 1, 1), // Flip horizontally
        child: Stack(
          children: [
            GestureDetector(
              onPanStart: (details) {
                final touchPosition = details.localPosition;
                previousAngle = atan2(
                  touchPosition.dy - 25 * 8,
                  touchPosition.dx - 25 * 8,
                );
              },
              onPanUpdate: (details) {
                final touchPosition = details.localPosition;
                final currentAngle = atan2(
                  touchPosition.dy - 25 * 8,
                  touchPosition.dx - 25 * 8,
                );

                setState(() {
                  double delta = currentAngle - previousAngle;
                  if (delta.abs() > pi) {
                    delta -= delta > 0 ? -2 * pi : 2 * pi;
                  }
                  _angle += delta;
                  previousAngle = currentAngle;
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: List.generate(numberOfBoxes, (index) {
                    double boxAngle = boxSeparationAngle * index;
                    double adjustedAngle = _angle - boxAngle;

                    String displayText = contentListLeft[index];

                    return Positioned(
                      top: circleRadius * sin(adjustedAngle) -
                          (boxHeight / 2 - 20 * 9),
                      left: circleRadius * cos(adjustedAngle) -
                          (boxWidth / 2 - 13 * 12.1),
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Transform.rotate(
                          angle: adjustedAngle,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.onIndexChanged(index); // Notify the parent about the index change
                                  _navigateToScreenLeftMenus(index);
                                },
                                child: Image.asset(
                                  isUnderDevelopmentLeftMenus(index)
                                      ? 'assets/images/disable_rectangle.png'
                                      : 'assets/images/Rectangle_big.png',
                                  width: boxWidth + 4,
                                  // color: EColors.imagePrimary,
                                  height: boxHeight + 30,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Positioned(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.onIndexChanged(index); // Notify the parent about the index change
                                    _navigateToScreenLeftMenus(index);
                                  },
                                  child: Transform.rotate(
                                    angle:  pi/ 2,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.diagonal3Values(-1, 1, 1), // Flip horizontally
                                      child: Container(
                                        width: boxHeight,
                                        height: boxWidth,
                                        alignment: Alignment.center,
                                        child: Text(
                                          displayText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            //color: Color.fromRGBO(52, 55, 76, 1),
                                             color: EColors.textPrimary1,
                                             // color: EColors.textColorPrimary1,
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreenLeftMenus(int index) {
    Widget Function() screen;

    switch (index) {
      case 0:
      case 10:
      // Show the FeesCard and hide the ProfileBox
        toggleFeesCardAndProfileBox(showFeesCard: true);
        return;

      case 1:
      case 11:
        screen = () =>  LibraryScreen();
        break;
        case 2:
          case 12:
        screen = () => AttendanceScreen();
        break;
      case 3:
      case 13:
        screen = () => const ApplyLeave();

        case 4:
        case 14:
        screen = () => Result();
        break;

        case 5:
        case 15:
        screen = () => const GatePass();
        break;

        case 6:
        screen = () => const ELibraryScreen();
        break;


        case 7:
        case 16:
        screen = () => const BookHistoryScreen();
        break;

        case 8:
        case 17:
        screen = () => const Notice();
        break;

           case 9:
        case 18:
        screen = () => IssuedBooksScreen();
        break;

    // Add cases for other indices/screens as needed
      default:
        _showSnackbar("It is in under Development");
        return;
    }

    Get.to(
      screen,
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 500),
    );

    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
        isSelected[index] = false;
      } else {
        selectedIndex = index;
        isSelected = List.generate(
          contentListLeft.length,
              (i) => i == index,
        );
      }
    });
  }

  void toggleFeesCardAndProfileBox({required bool showFeesCard}) {
    setState(() {
      // Toggle the FeesCard based on index 0 or 10
      showFeesCard = (selectedIndex == 0 || selectedIndex == 10);
    });

    // If FeesCard is not supposed to be shown, hide it
    if (!showFeesCard) {
      // Delay the setState to ensure it happens after the initial one
      Future.delayed(Duration.zero, () {
        setState(() {
          selectedIndex = -1;
          isSelected = List.generate(
            contentListLeft.length,
                (i) => false,
          );
        });
      });
    }
  }




  void _showSnackbar(String message) {
    Get.snackbar(
      "Coming Soon...",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      colorText: EColors.white,
    );
  }

  bool isUnderDevelopmentLeftMenus(int index) {
    // Add the indices of screens that are under development
    List<int> underDevelopmentIndices = [ ];

    return underDevelopmentIndices.contains(index);
  }
}







// import 'package:flutter/material.dart';
// import 'dart:math';
// import '../../../../utils/constants/colors.dart';
// import 'package:get/get.dart';
// import 'fees/fees_screen.dart';
// import 'library/library_screen.dart';
//
// class LeftSideCircularScrollingBoxes extends StatefulWidget {
//   const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _LeftSideCircularScrollingBoxesState createState() =>
//       _LeftSideCircularScrollingBoxesState();
// }
//
// class _LeftSideCircularScrollingBoxesState
//     extends State<LeftSideCircularScrollingBoxes> {
//   final double circleRadius = 128.0;
//   final double boxWidth = 50.1;
//   final double boxHeight = 90.5;
//   late double _angle = 0.0;
//   final double fontSize = 12.0;
//   int selectedIndex = -1;
//   late double previousAngle = 0.0;
//   late List<bool> isSelected;
//
//   final List<String> contentListLeft = [
//     'Fees',
//     'Library',
//     'Attendance',
//     'Apply Leave',
//     'Result',
//     'Gate Pass',
//     'Placement',
//     'Career',
//     'Internship',
//     'Complaints',
//     'Fees',
//     'Library',
//     'Attendance',
//     'Apply Leave',
//     'Result',
//     'Feedback',
//     'Career',
//     'Internship',
//     'Complaints',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     isSelected = List.generate(contentListLeft.length, (index) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes = contentListLeft.length;
//     double boxSeparationAngle = 2 * pi / numberOfBoxes;
//
//     return Container(
//       width: 180,
//       height: 400,
//       child: Transform(
//         alignment: Alignment.center,
//         transform: Matrix4.diagonal3Values(-1, 1, 1), // Flip horizontally
//         child: Stack(
//           children: [
//             GestureDetector(
//               onPanStart: (details) {
//                 final touchPosition = details.localPosition;
//                 previousAngle = atan2(
//                   touchPosition.dy - 25 * 8,
//                   touchPosition.dx - 25 * 8,
//                 );
//               },
//               onPanUpdate: (details) {
//                 final touchPosition = details.localPosition;
//                 final currentAngle = atan2(
//                   touchPosition.dy - 25 * 8,
//                   touchPosition.dx - 25 * 8,
//                 );
//
//                 setState(() {
//                   double delta = currentAngle - previousAngle;
//                   if (delta.abs() > pi) {
//                     delta -= delta > 0 ? -2 * pi : 2 * pi;
//                   }
//                   _angle += delta;
//                   previousAngle = currentAngle;
//                 });
//               },
//               child: Container(
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                 ),
//                 child: Stack(
//                   children: List.generate(numberOfBoxes, (index) {
//                     double boxAngle = boxSeparationAngle * index;
//                     double adjustedAngle = _angle - boxAngle;
//
//                     String displayText = contentListLeft[index];
//
//                     return Positioned(
//                       top: circleRadius * sin(adjustedAngle) -
//                           (boxHeight / 2 - 20 * 9),
//                       left: circleRadius * cos(adjustedAngle) -
//                           (boxWidth / 2 - 13 * 12.1),
//                       child: Transform.rotate(
//                         angle: pi / 2,
//                         child: Transform.rotate(
//                           angle: adjustedAngle,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: () => _navigateToScreenLeftMenus(index),
//                                 child: Image.asset(
//                                   isUnderDevelopmentLeftMenus(index)
//                                       ? 'assets/images/disable_rectangle.png'
//                                       : 'assets/images/Rectangle_big.png',
//                                   // 'assets/images/Rectangle_big.png',
//                                   width: boxWidth + 4,
//                                   height: boxHeight + 30,
//                                   alignment: Alignment.center,
//                                 ),
//                               ),
//                               Positioned(
//                                 child: GestureDetector(
//                                   onTap: () => _navigateToScreenLeftMenus(index),
//                                   child: Transform.rotate(
//                                     angle:  pi/ 2,
//                                     child: Transform(
//                                       alignment: Alignment.center,
//                                       transform: Matrix4.diagonal3Values(-1, 1, 1), // Flip horizontally
//                                       child: Container(
//                                         width: boxHeight,
//                                         height: boxWidth,
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           displayText,
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             // color: isSelected[index]
//                                             //     ? EColors.white
//                                             //     : EColors.textColorPrimary1,
//                                             color: EColors.textColorPrimary1,
//                                             fontSize: fontSize,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _navigateToScreenLeftMenus(int index) {
//     Widget Function() screen;
//     switch (index) {
//       case 0:
//         screen = () => const FeesScreen();
//         break;
//       case 1:
//         screen = () => const LibraryScreen();
//         break;
//         case 11:
//         screen = () => const LibraryScreen();
//         break;
//         case 10:
//         screen = () => const FeesScreen();
//         break;
//     // Add cases for other indices/screens as needed
//       default:
//         _showSnackbar("It is in under Development");
//         return;
//     }
//
//     Get.to(
//       screen,
//       transition: Transition.cupertino, // or Transition.zoom, Transition.leftToRight, etc.
//       duration: const Duration(milliseconds: 500), // Optional: Specify the duration of the transition
//     );
//
//
//     setState(() {
//       if (selectedIndex == index) {
//         selectedIndex = -1;
//         isSelected[index] = false;
//       } else {
//         selectedIndex = index;
//         isSelected = List.generate(
//           contentListLeft.length,
//               (i) => i == index,
//         );
//       }
//     });
//   }
//
//   void _showSnackbar(String message) {
//     Get.snackbar(
//       "Coming Soon...",
//       message,
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.transparent,
//       colorText: EColors.white,
//     );
//   }
//
//   bool isUnderDevelopmentLeftMenus(int index) {
//     // Add the indices of screens that are under development
//     List<int> underDevelopmentIndices = [ 2 ,3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18];
//
//     return underDevelopmentIndices.contains(index);
//   }
//
// }
//
//
//


