// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class LeftSideCircularScrollingBoxes extends StatefulWidget {
//   const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _LeftSideCircularScrollingBoxesState createState() => _LeftSideCircularScrollingBoxesState();
// }
//
// class _LeftSideCircularScrollingBoxesState extends State<LeftSideCircularScrollingBoxes> {
//   final double circleRadius = 128.0; // Adjust the circle radius as needed
//   final double boxWidth = 50.1; // Width of the scrolling boxes
//   final double boxHeight = 90.5; // Height of the scrolling boxes
//   late double _angle = 0.0; // Angle for box positioning and rotation
//   final double fontSize = 12.0; // Constant font size for text
//
//   final List<String> contentList = [
//     'Name', 'sem', 'exam', 'college', 'sports',
//     '1 sem', 'a', 'Career', 'Internship', 'Complaints',
//     'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
//     'Feedback', 'Placement', 'Career', 'Internship',
//     // 'Complaints',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes = contentList.length; // Number of boxes to be displayed
//     // double boxSeparationAngle = 2 * pi / numberOfBoxes; // Angle between each box
//
//     return GestureDetector(
//       onPanUpdate: (details) {
//         setState(() {
//           _angle -= details.delta.dx * 0.003; // Update angle based on the pan gesture
//           if (_angle < 0) {
//             _angle += 2 * pi; // Ensure angle remains within the range of 0 to 2*pi
//           } else if (_angle >= 2 * pi) {
//             _angle -= 2 * pi;
//           }
//         });
//       },
//       child: Center(
//         child: Stack(
//           children: List.generate(numberOfBoxes, (index) {
//             double boxAngle = 2 * pi / numberOfBoxes * index;
//
//             String displayText = contentList[index];
//
//             return Positioned(
//               top: circleRadius * sin(_angle - boxAngle) - (boxHeight / 2 - 20 * 9),
//               left: circleRadius * cos(_angle - boxAngle) - (boxWidth / 2 + 3 * 4.6),
//               child: Transform.rotate(
//                 angle: _angle - boxAngle + pi / 2, // Rotate the box according to the image
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Image.asset(
//                        'assets/images/Rectangle_big.png',
//                       // 'assets/images/red_rectangle.png',
//                       width: boxWidth +4,
//                       height: boxHeight + 30,
//                       alignment: Alignment.center,
//                     ),
//                     Transform.rotate(
//                       angle: -pi / 2,
//                       child: InkWell(
//                         onTap: () {},
//                         child: Container(
//                           width: boxHeight,
//                           height: boxWidth,
//                           alignment: Alignment.center,
//                           child: Text(
//                             displayText,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: const Color.fromRGBO(16, 34, 130, 1),
//                               fontSize: fontSize,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//
//
//
//   }
// }


/*
import 'dart:math';
import 'package:flutter/material.dart';

class LeftSideCircularScrollingBoxes extends StatefulWidget {
  const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);

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
  final double fontSize = 12.0;
  int selectedIndex = -1; // Track the selected index
  double _startAngle = 0.0;


  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship',
    // 'Complaints',
  ];

  List<bool> isSelected = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length;

    return GestureDetector(

      onPanStart: (details) {
        final touchPosition = details.localPosition;
        _startAngle = atan2(
          touchPosition.dy + 200,
          touchPosition.dx + 200,
        );
      },
      onPanUpdate: (details) {
        final touchPosition = details.localPosition;
        final currentAngle = atan2(
          touchPosition.dy + 200,
          touchPosition.dx + 200,
        );
        setState(() {
          double delta = currentAngle - _startAngle;
          // Ensuring continuous rotation even if delta crosses pi/-pi
          if (delta.abs() > pi) {
            delta -= delta.sign * 2 * pi;
          }
          _angle += delta;
          _startAngle = currentAngle;
        });
      },


      // onPanStart: (details) {
      //   final touchPosition = details.localPosition;
      //   _startAngle = atan2(
      //     touchPosition.dy + 200,
      //     touchPosition.dx + 200,
      //   );
      // },
      // onPanUpdate: (details) {
      //   final touchPosition = details.localPosition;
      //   final currentAngle = atan2(
      //     touchPosition.dy + 200,
      //     touchPosition.dx + 200,
      //   );
      //   setState(() {
      //     double delta = currentAngle - _startAngle;
      //     // Ensuring continuous rotation even if delta crosses pi/-pi
      //     if (delta.abs() > pi) {
      //       delta += delta > 0 ? -2 * pi : 2 * pi;
      //     }
      //     // Adjust the multiplier for faster rotation, e.g., 2.0, 3.0, etc.
      //     _angle += delta * 4.0; // Increasing the speed of rotation by multiplying delta
      //     _startAngle = currentAngle;
      //   });
      // },


      /*
      onPanStart: (details) {
        final touchPosition = details.localPosition;
        _startAngle = atan2(
          touchPosition.dy +200,
          touchPosition.dx +200,
        );
      },
      onPanUpdate: (details) {
        final touchPosition = details.localPosition;
        final currentAngle = atan2(
          touchPosition.dy +200,
          touchPosition.dx +200,
        );
        setState(() {
          double delta = currentAngle - _startAngle;
          // Ensuring continuous rotation even if delta crosses pi/-pi
          if (delta.abs() > pi) {
            delta += delta > 0 ? -2 * pi : 2 * pi;
          }
          _angle += delta;
          _startAngle = currentAngle;
        });
      },

       */

      // onPanStart: (details) {
      //   _startRotation = details.localPosition;
      // },
      // onPanUpdate: (details) {
      //   final currentRotation = details.localPosition;
      //   final dx = currentRotation.dx - _startRotation.dx;
      //   final dy = currentRotation.dy - _startRotation.dy;
      //   final angle = atan2(dy, dx);
      //   setState(() {
      //     _angle = angle;
      //   });
      // },
      // onPanEnd: (_) {
      //   _startRotation = Offset.zero;
      // },
      /*------------------------------- */
      // onPanUpdate: (details) {
      //   setState(() {
      //     _angle -= details.delta.dx * 0.003;
      //     if (_angle < 0) {
      //       _angle += 2 * pi;
      //     } else if (_angle >= 2 * pi) {
      //       _angle -= 2 * pi;
      //     }
      //   });
      // },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = 2 * pi / numberOfBoxes * index;

            String displayText = contentList[index];

            return Positioned(
              top: circleRadius * sin(_angle - boxAngle) -
                  (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(_angle - boxAngle) -
                  (boxWidth / 2 + 3 * 4.6),
              child: Transform.rotate(
                angle: _angle - boxAngle + pi / 2,
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
                              contentList.length,
                              (i) => i == index,
                            );
                          }
                        });
                      },
                      child: Image.asset(
                        isSelected[index]
                            ? 'assets/images/red_rectangle.png'
                            : 'assets/images/Rectangle_big.png',
                        width: boxWidth + 4,
                        height: boxHeight + 30,
                        alignment: Alignment.center,
                      ),
                    ),
                    Transform.rotate(
                      angle: -pi / 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = -1;
                              isSelected[index] = false;
                            } else {
                              selectedIndex = index;
                              isSelected = List.generate(
                                contentList.length,
                                (i) => i == index,
                              );
                            }
                          });
                        },
                        child: Container(
                          width: boxHeight,
                          height: boxWidth,
                          alignment: Alignment.center,
                          child: Text(
                            displayText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected[index]
                                  ? Colors.white
                                  : const Color.fromRGBO(16, 34, 130, 1),
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
            );
          }),
        ),
      ),
    );
  }
}


 */






/// this code is fine
// import 'dart:math';
// import 'package:flutter/material.dart';
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
//   int selectedIndex = -1; // Track the selected index
//   double _startAngle = 0.0;
//
//   final List<String> contentList = [
//     'Name', 'sem', 'exam', 'college', 'sports',
//     '1 sem', 'a', 'Career', 'Internship', 'Complaints',
//     'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
//     'Feedback', 'Placement', 'Career', 'Internship',
//     // 'Complaints',
//   ];
//
//   List<bool> isSelected = [];
//
//   @override
//   void initState() {
//     super.initState();
//     isSelected = List.generate(contentList.length, (index) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes = contentList.length;
//
//     return GestureDetector(
//       onPanStart: (details) {
//         final touchPosition = details.localPosition;
//         _startAngle = atan2(
//           touchPosition.dy,
//           touchPosition.dx,
//         );
//       },
//       onPanUpdate: (details) {
//         final touchPosition = details.localPosition;
//         final currentAngle = atan2(
//           touchPosition.dy,
//           touchPosition.dx,
//         );
//         setState(() {
//           _angle += currentAngle - _startAngle;
//           _startAngle = currentAngle;
//         });
//       },
//
//
//
//
//
//       child: Center(
//         child: Stack(
//           children: List.generate(numberOfBoxes, (index) {
//             double boxAngle = 2 * pi / numberOfBoxes * index;
//
//             String displayText = contentList[index];
//
//             return Positioned(
//               top: circleRadius * sin(_angle - boxAngle) -
//                   (boxHeight / 2 - 20 * 9),
//               left: circleRadius * cos(_angle - boxAngle) -
//                   (boxWidth / 2 + 3 * 4.6),
//               child: Transform.rotate(
//                 angle: _angle - boxAngle + pi / 2,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (selectedIndex == index) {
//                             selectedIndex = -1;
//                             isSelected[index] = false;
//                           } else {
//                             selectedIndex = index;
//                             isSelected = List.generate(
//                               contentList.length,
//                                   (i) => i == index,
//                             );
//                           }
//                         });
//                       },
//                       child: Image.asset(
//                         isSelected[index]
//                             ? 'assets/images/red_rectangle.png'
//                             : 'assets/images/Rectangle_big.png',
//                         width: boxWidth + 4,
//                         height: boxHeight + 30,
//                         alignment: Alignment.center,
//                       ),
//                     ),
//                     Transform.rotate(
//                       angle: -pi / 2,
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             if (selectedIndex == index) {
//                               selectedIndex = -1;
//                               isSelected[index] = false;
//                             } else {
//                               selectedIndex = index;
//                               isSelected = List.generate(
//                                 contentList.length,
//                                     (i) => i == index,
//                               );
//                             }
//                           });
//                         },
//                         child: Container(
//                           width: boxHeight,
//                           height: boxWidth,
//                           alignment: Alignment.center,
//                           child: Text(
//                             displayText,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: isSelected[index]
//                                   ? Colors.white
//                                   : const Color.fromRGBO(16, 34, 130, 1),
//                               fontSize: fontSize,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }



import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class LeftSideCircularScrollingBoxes extends StatefulWidget {
  const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _LeftSideCircularScrollingBoxes createState() =>
      _LeftSideCircularScrollingBoxes();
}

class _LeftSideCircularScrollingBoxes
    extends State<LeftSideCircularScrollingBoxes> {
  final double circleRadius = 128.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  final double fontSize = 12.0; // Constant font size for text
  int selectedIndex = -1; // Track the currently selected index
  late double previousAngle = 0.0; // Previous angle for continuous rotation


  late List<bool> isSelected; // List to track selection

  final List<String> contentList = [
    'Name', 'EColors.white,', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship',
    // 'Complaints',
  ];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length; // Number of boxes to be displayed
    double boxSeparationAngle = 2 * pi / numberOfBoxes; // Angle between each box

    return GestureDetector(
      onPanStart: (details) {
        final touchPosition = details.localPosition;
        previousAngle = atan2(
          touchPosition.dy - 25*8,
          touchPosition.dx - 25*8,
        );
      },
      onPanUpdate: (details) {
        final touchPosition = details.localPosition;
        final currentAngle = atan2(
          touchPosition.dy - 25*8,
          touchPosition.dx - 25*8,
        );
        setState(() {
          double delta = currentAngle - previousAngle;
          if (delta.abs() > pi) {
            delta -= delta > 0 ? -2 * pi : 2 * pi;
          }
          _angle -= delta;
          previousAngle = currentAngle;
        });
      },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;
            double adjustedAngle = _angle + boxAngle;

            String displayText = contentList[index];

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(adjustedAngle) -
                  (boxWidth / 2 + 5 * 4 ),
              child: Transform.rotate(
                angle: pi / 2, // Rotating the box to the 90-degree position
                child: Transform.rotate(
                  angle: adjustedAngle, // Rotating the box according to the image
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
                                contentList.length,
                                    (i) => i == index,
                              );
                            }
                          });
                        },
                        child: Image.asset(
                          isSelected[index]
                              ? 'assets/images/red_rectangle.png'
                              : 'assets/images/Rectangle_big.png',
                          width: boxWidth + 4,
                          height: boxHeight + 30,
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
                                  contentList.length,
                                      (i) => i == index,
                                );
                              }
                            });
                          },
                          child: Transform.rotate(
                            angle: -pi / 2,
                            child: Container(
                              width: boxHeight,
                              height: boxWidth,
                              alignment: Alignment.center,
                              child: Text(
                                displayText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected[index]
                                      ? Colors.white
                                      :  EColors.white,
                                      // : const Color.fromRGBO(16, 34, 130, 1),
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
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
}

/*

/// On tap color is added in this code
import 'dart:math';
import 'package:flutter/material.dart';

class LeftSideCircularScrollingBoxes extends StatefulWidget {
  const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);

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
  final double fontSize = 12.0;
  int selectedIndex = -1; // Track the selected index

  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship',
    // 'Complaints',
  ];

  List<bool> isSelected = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length;

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle -= details.delta.dx * 0.003;
          if (_angle < 0) {
            _angle += 2 * pi;
          } else if (_angle >= 2 * pi) {
            _angle -= 2 * pi;
          }
        });
      },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = 2 * pi / numberOfBoxes * index;

            String displayText = contentList[index];

            return Positioned(
              top: circleRadius * sin(_angle - boxAngle) - (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(_angle - boxAngle) - (boxWidth / 2 + 3 * 4.6),
              child: Transform.rotate(
                angle: _angle - boxAngle + pi / 2,
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
                              contentList.length,
                                  (i) => i == index,
                            );
                          }
                        });
                      },
                      child: Image.asset(
                        isSelected[index]
                            ? 'assets/images/red_rectangle.png'
                            : 'assets/images/Rectangle_big.png',
                        width: boxWidth + 4,
                        height: boxHeight + 30,
                        alignment: Alignment.center,
                      ),
                    ),
                    Transform.rotate(
                      angle: -pi / 2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = -1;
                              isSelected[index] = false;
                            } else {
                              selectedIndex = index;
                              isSelected = List.generate(
                                contentList.length,
                                    (i) => i == index,
                              );
                            }
                          });
                        },
                        child: Container(
                          width: boxHeight,
                          height: boxWidth,
                          alignment: Alignment.center,
                          child: Text(
                            displayText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected[index] ? Colors.white : const Color.fromRGBO(16, 34, 130, 1),
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
            );
          }),
        ),
      ),
    );
  }
}

 */
