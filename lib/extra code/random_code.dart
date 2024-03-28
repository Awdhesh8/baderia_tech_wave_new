// Notice screen code ----

// code is perfect
// class CircularScrollingBoxes extends StatefulWidget {
//   const CircularScrollingBoxes({Key? key}) : super(key: key);
//
//   @override
//   _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
// }
//
// class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
//   final double circleRadius = 120.0; // Adjust the circle radius as needed
//   final double boxWidth = 35.1; // Width of the scrolling boxes
//   final double boxHeight = 90.5; // Height of the scrolling boxes
//   late double _angle = 0.0; // Angle for box positioning and rotation
//
//   @override
//   Widget build(BuildContext context) {
//     int numberOfBoxes = 14; // Number of boxes to be displayed
//     double boxSeparationAngle = 2 * pi / numberOfBoxes; // Angle between each box
//
//     return GestureDetector(
//       onPanUpdate: (details) {
//         setState(() {
//           _angle += details.delta.dx * 0.01; // Adjust the sensitivity of scrolling
//         });
//       },
//       child: Center(
//         child: Stack(
//           children: List.generate(numberOfBoxes, (index) {
//             double boxAngle = boxSeparationAngle * index;
//
//             // Calculate the adjusted angle to reposition boxes from above 180 degrees to 0 degrees
//             double adjustedAngle = _angle + boxAngle;
//             if (adjustedAngle > pi) {
//               adjustedAngle -= 2 * pi;
//             }
//
//             return Positioned(
//               top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 12),
//               left: circleRadius * cos(adjustedAngle) - (boxWidth / 2 + 5),
//               child: Transform.rotate(
//                 angle: adjustedAngle + (pi / 2),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/rectangualr_shape.png',
//                       width: boxWidth,
//                       height: boxHeight,
//                       alignment: Alignment.center,
//                     ),
//                     Transform.rotate(
//                       angle: -pi / 2,
//                       child: InkWell(
//                         onTap: () {},
//                         child: FittedBox(
//                           fit: BoxFit.contain,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                             child: Text(
//                               'Image $index',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
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
//


/*
class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 140.0; // Adjust the circle radius as needed
  final double boxWidth = 35.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = 14; // Number of boxes to be displayed
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
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 12),
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


/*
class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 115.0;
  final double boxWidth = 48.1;
  final double boxHeight = 90.5;
  late double _angle = 0.0;
  final double fontSize = 10.0;
  int selectedIndex = -1; // Initially no index is selected

  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
  ];

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length;
    double boxSeparationAngle = 2 * pi / numberOfBoxes;

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.01;
        });
      },
      onPanEnd: (_) {
        // Logic to update the selected index based on the angle
        int newSelectedIndex = (_angle / (2 * pi / numberOfBoxes)).round();
        if (newSelectedIndex >= 0 && newSelectedIndex < numberOfBoxes) {
          selectedIndex = newSelectedIndex;
        }
      },
      child: Center(
        child: Stack(
          children: List.generate(numberOfBoxes, (index) {
            double boxAngle = boxSeparationAngle * index;
            double adjustedAngle = _angle + boxAngle;
            if (adjustedAngle > pi) {
              adjustedAngle -= 2 * pi;
            }

            String displayText = contentList[index];
            bool isSelected = index == selectedIndex;

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight / 2 - 20 * 9),
              left: circleRadius * cos(adjustedAngle) - (boxWidth / 2 + 3 * 4.5),
              child: Transform.rotate(
                angle: pi / 2,
                child: Transform.rotate(
                  angle: adjustedAngle,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Rectangle1.3.png',
                        width: boxWidth,
                        height: boxHeight,
                        alignment: Alignment.center,
                      ),
                      if (isSelected)
                        ScaleTransition(
                          scale: Tween(begin: 1.0, end: 1.3).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: Transform.rotate(
                            angle: -pi / 2,
                            child: InkWell(
                              onTap: () {
                                // Handle onTap for selected index if needed
                              },
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


// ---------+++++++++---------------************************

// Attendance screen code ----


/*

// This code is perfectly working don't edit any thing on it
class CircularScrollingBoxesLeftCircle extends StatefulWidget {
  const CircularScrollingBoxesLeftCircle({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesLeftCircleState createState() => _CircularScrollingBoxesLeftCircleState();
}

class _CircularScrollingBoxesLeftCircleState extends State<CircularScrollingBoxesLeftCircle> {
  final double circleRadius = 124.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  final double fontSize = 10.0; // Constant font size for text

  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
    '1 sem', 'a', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
     'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
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
              left: circleRadius * cos(adjustedAngle) - (boxWidth /  2 - 10* 15.2),
              child: Transform.rotate(
                angle: pi / 2, // Rotating the box to the 90-degree position
                child: Transform.rotate(
                  angle: adjustedAngle, // Rotating the box according to the image
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Rectangle1.5.png',
                        width: boxWidth,
                        height: boxHeight,
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



/*
class CirclePainter extends CustomPainter {
  final double angle;
  final List<String> boxTexts;

  CirclePainter({required this.angle, required this.boxTexts});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double boxRadius = 20;

    // Draw circle
    canvas.drawCircle(center, radius, Paint()..color = Colors.blue);

    // Draw boxes at different angles along the circle
    final int numberOfBoxes = boxTexts.length;
    final double boxAngle = 2 * pi / numberOfBoxes;

    for (int i = 0; i < numberOfBoxes; i++) {
      double currentAngle = angle + (i * boxAngle);
      double x = center.dx + radius * cos(currentAngle);
      double y = center.dy + radius * sin(currentAngle);

      // Draw rectangle box
      canvas.drawRect(
        Rect.fromCircle(center: Offset(x, y), radius: boxRadius),
        Paint()..color = Colors.red,
      );

      // Draw text inside the box
      TextSpan span = TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 12),
        text: boxTexts[i],
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x - (boxRadius / 2), y - (boxRadius / 2)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class CircleWithBoxes extends StatefulWidget {
  const CircleWithBoxes({super.key});

  @override
  _CircleWithBoxesState createState() => _CircleWithBoxesState();
}

class _CircleWithBoxesState extends State<CircleWithBoxes> {
  double angle = 0.0;
  List<String> boxTexts = [
    'Box 1',
    'Box 2',
    'Box 3',
    'Box 4',
    'Box 5',
    'Box 6',
    'Box 7',
    'Box 8',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          angle += details.delta.dx / 100;
        });
      },
      child: Center(
        child: Stack(
          children: [
            // Circle
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),

            // Boxes around the circle
            for (int i = 0; i < boxTexts.length; i++)
              Positioned(
                top: 100 + 80 * cos(pi / 4 * i + angle),
                left: 100 + 80 * sin(pi / 4 * i + angle),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      boxTexts[i],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



/// another code

class CircleRotationPage extends StatefulWidget {
  @override
  _CircleRotationPageState createState() => _CircleRotationPageState();
}

class _CircleRotationPageState extends State<CircleRotationPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance screen'),
      ),
      body: const Center(
        child: Text(
          'Attendance screen'
        ),
      ),
    );
  }
}

 */



