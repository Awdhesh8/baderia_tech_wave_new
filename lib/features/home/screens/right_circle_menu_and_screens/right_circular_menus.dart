// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../../utils/constants/colors.dart';
//
// class RightSideCircularScrollingBoxes extends StatefulWidget {
//   const RightSideCircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _RightSideCircularScrollingBoxesState createState() =>
//       _RightSideCircularScrollingBoxesState();
// }
//
// class _RightSideCircularScrollingBoxesState
//     extends State<RightSideCircularScrollingBoxes> {
//   final double circleRadius = 128.0; // Adjust the circle radius as needed
//   final double boxWidth = 50.1; // Width of the scrolling boxes
//   final double boxHeight = 90.5; // Height of the scrolling boxes
//   late double _angle = 0.0; // Angle for box positioning and rotation
//   final double fontSize = 12.0; // Constant font size for text
//   int selectedIndex = -1; // Track the currently selected index
//   late double previousAngle = 0.0; // Previous angle for continuous rotation
//   late List<bool> isSelected; // List to track selection
//
//   final List<String> contentListRight = [
//     'CV/Resume',
//     'Assessment Test',
//     'Assignment',
//     'Fees',
//     'Mid Term',
//     'Certificate',
//     'VT Letter',
//     'Activity',
//     'Feedback',
//     'Training',
//     'CV/Resume',
//     'Assessment Test',
//     'Assignment',
//     'Fees',
//     'Mid Term',
//     'Certificate',
//     'VT Letter',
//     'Activity',
//     'Training',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     isSelected = List.generate(contentListRight.length, (index) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes =
//         contentListRight.length; // Number of boxes to be displayed
//     double boxSeparationAngle =
//         2 * pi / numberOfBoxes; // Angle between each box
//
//     return GestureDetector(
//       onPanStart: (details) {
//         final touchPosition = details.localPosition;
//         previousAngle = atan2(
//           touchPosition.dy - 25 * 8,
//           touchPosition.dx - 25 * 8,
//         );
//       },
//       onPanUpdate: (details) {
//         final touchPosition = details.localPosition;
//         final currentAngle = atan2(
//           touchPosition.dy - 25 * 8,
//           touchPosition.dx - 25 * 8,
//         );
//         setState(() {
//           double delta = currentAngle - previousAngle;
//           if (delta.abs() > pi) {
//             delta += delta > 0 ? -2 * pi : 2 * pi;
//           }
//           _angle += delta;
//           previousAngle = currentAngle;
//         });
//       },
//       child: Center(
//         child: Stack(
//           children: List.generate(numberOfBoxes, (index) {
//             double boxAngle = boxSeparationAngle * index;
//             double adjustedAngle = _angle + boxAngle;
//
//             String displayText = contentListRight[index];
//
//             return Positioned(
//               top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 9),
//               left: circleRadius * cos(adjustedAngle) -
//                   (boxWidth / 2 - 10 * 15.3),
//               child: Transform.rotate(
//                 angle: pi / 2, // Rotating the box to the 90-degree position
//                 child: Transform.rotate(
//                   angle:
//                       adjustedAngle, // Rotating the box according to the image
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             if (selectedIndex == index) {
//                               selectedIndex = -1;
//                               isSelected[index] = false;
//                             } else {
//                               selectedIndex = index;
//                               isSelected = List.generate(
//                                 contentListRight.length,
//                                 (i) => i == index,
//                               );
//                             }
//                           });
//                         },
//                         child: Image.asset(
//                           // isSelected[index]
//                           //     ? 'assets/images/red_rectangle.png'
//                           //     : 'assets/images/Rectangle_big.png',
//                           'assets/images/Rectangle_big.png',
//                           width: boxWidth + 4,
//                           height: boxHeight + 30,
//                           alignment: Alignment.center,
//                         ),
//                       ),
//                       Positioned(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (selectedIndex == index) {
//                                 selectedIndex = -1;
//                                 isSelected[index] = false;
//                               } else {
//                                 selectedIndex = index;
//                                 isSelected = List.generate(
//                                   contentListRight.length,
//                                   (i) => i == index,
//                                 );
//                               }
//                             });
//                           },
//                           child: Transform.rotate(
//                             angle: pi / 2,
//                             child: Container(
//                               width: boxHeight,
//                               height: boxWidth,
//                               alignment: Alignment.center,
//                               child: Text(
//                                 displayText,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   // color: isSelected[index]
//                                   //     ? EColors.white
//                                   //     : EColors.textColorPrimary1,
//                                  color: EColors.textColorPrimary1,
//                                   // : const Color.fromRGBO(16, 34, 130, 1),
//                                   fontSize: fontSize,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//
//
// }


import 'dart:math';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/syllabus/syllabus.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/tranining/training.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/vt_letter.dart';
import '../../../../routes_pages_navigation/named_routes_screens.dart';
import '../../../../utils/constants/colors.dart';
import 'activity/activity.dart';
import 'assessment_test/assessment_test_screen.dart';
import 'cv_resume/cv_resume_screen.dart';

class RightSideCircularScrollingBoxes extends StatefulWidget {
  const RightSideCircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _RightSideCircularScrollingBoxesState createState() =>
      _RightSideCircularScrollingBoxesState();
}

class _RightSideCircularScrollingBoxesState
    extends State<RightSideCircularScrollingBoxes> {
  final double circleRadius = 128.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  final double fontSize = 11.5; // Constant font size for text
  int selectedIndex = -1; // Track the currently selected index
  late double previousAngle = 0.0; // Previous angle for continuous rotation
  late List<bool> isSelected; // List to track selection

  final List<String> contentListRight = [
    'CV/Resume',
    'Assessment',
    'Assignment',
    'Syllabus',
    'Mid Term',
    'Certificate',
    'VT Letter',
    'Activity',
    'Feedback',
    'Training',
    'CV/Resume',
    'Assessment',
    'Assignment',
    'Syllabus',
    'Mid Term',
    'Certificate',
    'VT Letter',
    'Activity',
    'Training',
  ];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentListRight.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes =
        contentListRight.length; // Number of boxes to be displayed
    double boxSeparationAngle =
        2 * pi / numberOfBoxes; // Angle between each box

    return GestureDetector(
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
            delta += delta > 0 ? -2 * pi : 2 * pi;
          }
          _angle += delta;
          previousAngle = currentAngle;
        });
      },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;
            double adjustedAngle = _angle + boxAngle;

            String displayText = contentListRight[index];

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(adjustedAngle) -
                  (boxWidth / 2 - 10 * 15.3),
              child: Transform.rotate(
                angle: pi / 2, // Rotating the box to the 90-degree position
                child: Transform.rotate(
                  angle:
                  adjustedAngle, // Rotating the box according to the image
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = -1;
                              isSelected[index] = false;
                            } else {
                              selectedIndex = index;
                              isSelected = List.generate(
                                contentListRight.length,
                                    (i) => i == index,
                              );
                            }
                          });
                          _navigateToScreenRightMenus(index);
                        },
                        child: Image.asset(
                          isUnderDevelopmentRightMenus(index)
                              ? 'assets/images/disable_rectangle.png'
                              : 'assets/images/Rectangle_big.png',
                          // 'assets/images/Rectangle_big.png',
                          width: boxWidth + 4,
                          height: boxHeight + 30,
                          //color: EColors.imagePrimary,
                          alignment: Alignment.center,
                        ),
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedIndex == index) {
                                selectedIndex = -1;
                                isSelected[index] = false;
                              } else {
                                selectedIndex = index;
                                isSelected = List.generate(
                                  contentListRight.length,
                                      (i) => i == index,
                                );
                              }
                            });
                            _navigateToScreenRightMenus(index);
                          },
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Container(
                              width: boxHeight,
                              height: boxWidth,
                              alignment: Alignment.center,
                              child: Text(
                                displayText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  // color: isSelected[index]
                                  //     ? EColors.white
                                  //     : EColors.textColorPrimary1,
                                  //color: EColors.textColorPrimary1,
                                   color: EColors.textPrimary1,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w500,
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
    );
  }

  void _navigateToScreenRightMenus(int index) {
    Widget Function() screen;
    switch (index) {
      case 7:
      case 17:
        screen = () => Activity();
        break;
      case 3:
      case 13:
        screen = () => Syllabus();
        break;
      case 6:
      case 16:
        screen = () => VTLetter();
        break;
        case 9:
      case 18:
        screen = () => SyllabusScreen();
        break;
    // Add cases for other indices/screens as needed
      default:
        _showSnackbar("It is in under Development");
        return;
    }

    Get.to(
      screen,
      transition: Transition.cupertino, // or Transition.zoom, Transition.leftToRight, etc.
      duration: const Duration(milliseconds: 500), // Optional: Specify the duration of the transition
    );

    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
        isSelected[index] = false;
      } else {
        selectedIndex = index;
        isSelected = List.generate(
          contentListRight.length,
              (i) => i == index,
        );
      }
    });
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

  bool isUnderDevelopmentRightMenus(int index) {
    // Add the indices of screens that are under development
    List<int> underDevelopmentIndices = [0, 1, 2 , 4, 5, 8, 10, 11, 12, 14, 15,];

    return underDevelopmentIndices.contains(index);
  }

}




/*
import 'dart:math';
import 'package:flutter/material.dart';

class RightSideCircularScrollingBoxes extends StatefulWidget {
  const RightSideCircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _RightSideCircularScrollingBoxesState createState() => _RightSideCircularScrollingBoxesState();
}

class _RightSideCircularScrollingBoxesState extends State<RightSideCircularScrollingBoxes> {
  final double circleRadius = 128.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  final double fontSize = 12.0; // Constant font size for text

  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship',
    // 'Complaints',
  ];

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length; // Number of boxes to be displayed
    double boxSeparationAngle = 2 * pi / numberOfBoxes; // Angle between each box

    return GestureDetector(

      onPanUpdate: (details) {
        setState(() {
          _angle -= details.delta.dx * 0.003; // Update angle based on the pan gesture
          if (_angle < 0) {
            _angle += 2 * pi; // Ensure angle remains within the range of 0 to 2*pi
          } else if (_angle >= 2 * pi) {
            _angle -= 2 * pi;
          }
        });
      },

      // onPanUpdate: (details) {
      //   setState(() {
      //     _angle += details.delta.dx * 0.01; // Adjust the sensitivity of scrolling
      //   });
      // },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;

            // Calculate the adjusted angle to reposition boxes from above 180 degrees to 0 degrees
            double adjustedAngle = _angle + boxAngle;
            if (adjustedAngle > pi) {
              adjustedAngle -= 2 * pi;
            }

            String displayText = contentList[index];

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(adjustedAngle) - (boxWidth /  2 - 10* 15.3),
              child: Transform.rotate(
                angle: pi / 2, // Rotating the box to the 90-degree position
                child: Transform.rotate(
                  angle: adjustedAngle, // Rotating the box according to the image
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Rectangle_big.png',
                        width: boxWidth +4,
                        height: boxHeight +30,
                        alignment: Alignment.center,
                      ),
                      Transform.rotate(
                        angle: pi / 2,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: boxHeight,
                            height: boxWidth,
                            alignment: Alignment.center,
                            child: Text(
                              displayText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(16, 34, 130, 1),
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
 */
