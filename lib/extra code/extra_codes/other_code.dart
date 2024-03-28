import 'package:flutter/material.dart';
import 'dart:math';


class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 140.0;
  final double boxWidth = 30.1;
  final double boxHeight = 70.5;
  late double _angle = 0.0;

  final List<String> firstCircle = [
    'Profile', 'Attendance', 'TimeTable', 'Comments', 'Training',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints'
  ];

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = firstCircle.length;
    double boxSeparationAngle = 2 * pi / firstCircle.length;

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.01;

          // Implement infinite looping between 0 and 180 degrees
          if (_angle >= pi) {
            _angle -= 2 * pi;
          } else if (_angle < -pi) {
            _angle += 2 * pi;
          }
        });
      },

      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;

            // Calculate adjusted angle for continuous looping between 0 and 180 degrees
            double adjustedAngle = (_angle + boxAngle);

            // Adjust angle to be within the range of 0 to 180 degrees
            if (adjustedAngle > pi) {
              adjustedAngle -= 2 * pi;
            } else if (adjustedAngle < 0) {
              adjustedAngle += 2 * pi;
            }

            // Calculate the position of the box
            double xPosition = circleRadius * cos(adjustedAngle);
            double yPosition = circleRadius * sin(adjustedAngle);

            return Positioned(
              top: yPosition - (boxHeight / 2 - 24 * 8),
              left: xPosition - (boxWidth / 2 - 5*4),
              child: Transform.rotate(
                angle: adjustedAngle + (pi / 2),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // const CustomPaint(
                    //
                    // ),

                    Image.asset(
                      'assets/images/rectangualr_shape.png',
                      width: boxWidth,
                      height: boxHeight,
                      alignment: Alignment.center,
                    ),
                    Transform.rotate(
                      angle: -240.3,
                      child: Text(
                        firstCircle[index],
                        style: const TextStyle(color: Colors.deepPurple, fontSize: 11,fontWeight: FontWeight.bold),
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


/*
import 'package:flutter/material.dart';
import 'dart:math';

class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 160.0; // Adjust the circle radius as needed
  final double boxWidth = 30.1; // Width of the scrolling boxes
  final double boxHeight = 70.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = 8; // Number of boxes to be displayed
    double boxSeparationAngle = 2 * pi / numberOfBoxes; // Angle between each box

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.01; // Adjust the sensitivity of scrolling
        });
      },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;

            // Calculate the adjusted angle to reposition boxes from above 180 degrees to 0 degrees
            double adjustedAngle = _angle + boxAngle;
            if (adjustedAngle > pi) {
              adjustedAngle -= 2 * pi;
            }

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 24 * 8),
              left: circleRadius * cos(adjustedAngle) - (boxWidth / 2 + 5),
              child: Transform.rotate(
                angle: adjustedAngle + (pi / 2),
                child: Image.asset(
                  'assets/images/rectangualr_shape.png',
                  width: boxWidth,
                  height: boxHeight,
                  alignment: Alignment.center,
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

// ------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'dart:math';
//
// class CircularScrollingBoxes extends StatefulWidget {
//   const CircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
// }
//
// class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
//   // Define variables for circle radius, box width, box height, and initial angle
//   final double circleRadius = 160.0; // Adjust the circle radius as needed
//   final double boxWidth = 30.1; // Width of the scrolling boxes
//   final double boxHeight = 70.5; // Height of the scrolling boxes
//   late double _angle = 0.0; // Angle for box positioning and rotation
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes = 11; // Number of boxes to be displayed
//     double boxSeparationAngle = 2* pi / numberOfBoxes; // Angle between each box
//
//     return GestureDetector(
//       // Gesture detection for scrolling interaction
//       onPanUpdate: (details) {
//         setState(() {
//           // Update angle based on horizontal pan movement for scrolling effect
//           _angle += details.delta.dx * 0.01; // Adjust the sensitivity of scrolling
//         });
//       },
//       child: Center(
//         child: Stack(
//           children: List.generate(numberOfBoxes, (index) {
//             // Calculate the angle for each box position around the circle
//             double boxAngle = boxSeparationAngle * index;
//
//             return Positioned(
//               // Calculate top position for the box based on sine of angle
//               top: circleRadius * sin(_angle + boxAngle) - (boxHeight / 2  - 24 * 8),
//               // Calculate left position for the box based on cosine of angle
//               left: circleRadius * cos(_angle + boxAngle) - (boxWidth / 2 + 5),
//               child: Transform.rotate(
//                 // Rotate the box based on its position angle and adjust orientation
//                 angle: _angle + boxAngle + (pi / 2),
//                 child: Image.asset(
//                   'assets/images/rectangualr_shape.png',
//                   width: boxWidth,
//                   height: boxHeight,
//                   alignment: Alignment.center,
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//








// import 'package:flutter/material.dart';
// import 'dart:math';
//
// class CircularScrollingBoxes extends StatefulWidget {
//   const CircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
// }
//
// class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
//   // Define variables for circle radius, box width, box height, and initial angle
//   final double circleRadius = 160.0; // Adjust the circle radius as needed
//   final double boxWidth = 30.1; // Width of the scrolling boxes
//   final double boxHeight = 70.5; // Height of the scrolling boxes
//   late double _angle = 0.0; // Angle for box positioning and rotation
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // Gesture detection for scrolling interaction
//       onPanUpdate: (details) {
//         setState(() {
//           // Update angle based on horizontal pan movement for scrolling effect
//           _angle += details.delta.dx * 0.02; // Adjust the sensitivity of scrolling
//         });
//       },
//       child: Center(
//         child: Stack(
//           children: List.generate(12, (index) {
//             // Calculate the angle for each box position around the circle
//             double boxAngle = (pi / 12) * index;
//
//             return Positioned(
//               // Calculate top position for the box based on sine of angle
//               top: circleRadius * sin(_angle + boxAngle) - (boxHeight / 2)  + 19.0 * 11,
//               // Calculate left position for the box based on cosine of angle
//               left: circleRadius * cos(_angle + boxAngle) - (boxWidth / 2 + 5 * 5),
//               child: Transform.rotate(
//                 // Rotate the box based on its position angle and adjust orientation
//                 angle: _angle + boxAngle + (pi / 2),
//                 child: Image.asset(
//                   'assets/images/rectangualr_shape.png',
//                   width: boxWidth,
//                   height: boxHeight,
//                   alignment: Alignment.center,
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
//






