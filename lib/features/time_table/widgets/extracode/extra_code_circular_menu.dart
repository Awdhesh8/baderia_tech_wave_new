

import 'package:flutter/material.dart';
import 'dart:math';


class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxes createState() =>
      _CircularScrollingBoxes();
}

class _CircularScrollingBoxes
    extends State<CircularScrollingBoxes> {
  final double circleRadius = 128.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  final double fontSize = 12.0; // Constant font size for text
  int selectedIndex = -1; // Track the currently selected index
  late double previousAngle = 0.0; // Previous angle for continuous rotation


  late List<bool> isSelected; // List to track selection

  final List<String> contentList = [
    'Name', 'sem', 'exam', 'college', 'sports',
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
          touchPosition.dy + 25*8,
          touchPosition.dx + 25*8,
        );
      },
      onPanUpdate: (details) {
        final touchPosition = details.localPosition;
        final currentAngle = atan2(
          touchPosition.dy + 25*8,
          touchPosition.dx + 25*8,
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

            String displayText = contentList[index];

            return Positioned(
              top: circleRadius * sin(adjustedAngle) - (boxHeight),
              left: circleRadius * cos(adjustedAngle) -
                  (boxWidth),
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
                                      : const Color.fromRGBO(16, 34, 130, 1),
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
/// in this code it can rotates with animation some more minor changes in this code
class LeftSideCircularScrollingBoxes extends StatefulWidget {
  const LeftSideCircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _LeftSideCircularScrollingBoxesState createState() =>
      _LeftSideCircularScrollingBoxesState();
}

class _LeftSideCircularScrollingBoxesState
    extends State<LeftSideCircularScrollingBoxes>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final double circleRadius = 128.0;
  final double boxWidth = 50.1;
  final double boxHeight = 90.5;
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
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(contentList.length, (index) => false);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10000), // Adjust duration for smoothness
    );

    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        _angle = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int numberOfBoxes = contentList.length;

    return GestureDetector(
      onPanUpdate: (details) {
        double sensitivity = 0.003;
        _animationController.value -= details.delta.dx * sensitivity;
      },
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Stack(
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
            );
          },
        ),
      ),
    );
  }
}
*/