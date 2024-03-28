import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../../../utils/constants/colors.dart';

class TextRightSideCircularScrollingBoxes extends StatefulWidget {
  const TextRightSideCircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _TextRightSideCircularScrollingBoxesState createState() =>
      _TextRightSideCircularScrollingBoxesState();
}

class _TextRightSideCircularScrollingBoxesState
    extends State<TextRightSideCircularScrollingBoxes> {
  final double circleRadius = 128.0; // Adjust the circle radius as needed
  final double boxWidth = 50.1; // Width of the scrolling boxes
  final double boxHeight = 90.5; // Height of the scrolling boxes
  late double _angle = 0.0; // Angle for box positioning and rotation
  late double _startAngle = 0.0; // Initial angle for panning
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
    double boxSeparationAngle =
        2 * pi / numberOfBoxes; // Angle between each box

    return Container(
      width: 180,
      height: 400,
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
            child:

            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.blue, // Change this to the desired color
              ),
              child: Stack(
                children: [
                  ...List.generate(numberOfBoxes, (index) {
                    double boxAngle = boxSeparationAngle * index;
                    double adjustedAngle = _angle - boxAngle;

                    String displayText = contentList[index];

                    return Positioned(
                      top: circleRadius * sin(adjustedAngle) -
                          (boxHeight / 2 - 20 * 9),
                      left: circleRadius * cos(adjustedAngle) -
                          (boxWidth / 2 + 5 * 4),
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Transform.rotate(
                          angle: adjustedAngle,
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
                                              : EColors.white,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

