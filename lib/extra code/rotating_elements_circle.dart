/*
import 'package:flutter/material.dart';
import 'dart:math';

import 'circular rotation widget/circular_scroll_shape.dart';

class CircularScrollingBoxes extends StatefulWidget {
  const CircularScrollingBoxes({Key? key}) : super(key: key);

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 180.0; // Adjust the circle radius as needed
  final double boxWidth = 30.1; // Width of the scrolling boxes
  final double boxHeight = 70.5; // Height of the scrolling boxes
  final double spacing = 10.0; // Spacing between boxes
  late double _angle = 0.0;
9
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.02; // Adjust the sensitivity of scrolling
        });
      },
      child: Center(
        child: Stack(
          children: List.generate(24, (index) {
            double boxAngle = (pi / 2) + (pi / 12) * index;
            return Positioned(
              top: circleRadius * sin(_angle + boxAngle) - (boxHeight / 2),
              left: circleRadius * cos(_angle + boxAngle) - (boxWidth / 2),
              child: Transform.rotate(
                angle: _angle + boxAngle + (pi / 2),
                child: Image.asset(
                  'assets/images/rectangualr_shape.png',
                  width: boxWidth,
                  height: boxHeight,
                  alignment: Alignment.center,
                ),
              ),
            );
          }
          ),
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'dart:math';


class CircularScrollingBoxes extends StatefulWidget {
   CircularScrollingBoxes({Key? key}) : super(key: key);

  final List<String> items = [
    'Profile', 'Attendance', 'TimeTable', 'Comments', 'Training',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career',

  ];

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 120.0; // Adjust the circle radius as needed
  final double boxWidth = 70.0; // Width of the scrolling boxes
  final double boxHeight = 20.0; // Height of the scrolling boxes
  late double _angle = 0.0;


  @override
  Widget build(BuildContext context) {
    final double totalItems = widget.items.length.toDouble();
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.005; // Adjust the sensitivity of scrolling
        });
      },
      child: Center(
        child: Container(
          width: circleRadius * 4,
          height: circleRadius * 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          child: Stack(
            children: List.generate(widget.items.length, (index) {
              double boxAngle = (2 * pi / totalItems) * index;
              return Positioned(
                top: circleRadius + circleRadius * sin(_angle + boxAngle) - (boxHeight / 2 - 10 * 8),
                left: circleRadius + circleRadius * cos(_angle + boxAngle) - (boxWidth / 2+ 20 * 6),
                child: Transform.rotate(
                  angle: _angle + boxAngle,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      color: const Color.fromRGBO(250, 170, 147, 1),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                           spreadRadius: 1,
                          color: Colors.black12
                        ),
                      ],
                    ),
                  // CustomShape(
                  //   rotationDegree: _angle + boxAngle - 20 * 4 ,
                  //   text: widget.items[index],
                  //   translateX: _angle + boxAngle - 20 * 9,
                  //   translateY: _angle + boxAngle - 20 * 2,
                  //   textRotationDegree: _angle + boxAngle - 20 * 4,
                    width: boxWidth,
                    height: boxHeight,
                     // Change box color as needed
                    alignment: Alignment.center,
                    child: Text( widget.items[index],
                      style: const TextStyle(color: Color.fromRGBO(16, 34, 130, 1), fontWeight: FontWeight.w500,fontSize: 10),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}









/*


import 'package:flutter/material.dart';
import 'dart:math';

class CircularScrollingBoxes extends StatefulWidget {
   CircularScrollingBoxes({Key? key}) : super(key: key);

  final List<String> items = [
    'Profile', 'Attendance', 'TimeTable', 'Comments', 'Training',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints',
    'Feedback', 'Placement', 'Career', 'Internship', 'Complaints'
  ];

  @override
  _CircularScrollingBoxesState createState() => _CircularScrollingBoxesState();
}

class _CircularScrollingBoxesState extends State<CircularScrollingBoxes> {
  final double circleRadius = 150.0; // Adjust the circle radius as needed
  final double boxWidth = 40.0; // Width of the scrolling boxes
  final double boxHeight = 20.0; // Height of the scrolling boxes
  late double _angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * 0.02; // Adjust the sensitivity of scrolling
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: circleRadius * 2,
            height: circleRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Stack(
              children: List.generate(20, (index) {
                double boxAngle = (2 * pi / 20) * index;
                return Positioned(
                  top: circleRadius + circleRadius * sin(_angle + boxAngle) - (boxHeight / 2),
                  left: circleRadius + circleRadius * cos(_angle + boxAngle) - (boxWidth / 2),
                  child: Transform.rotate(
                    angle: _angle + boxAngle,
                    child: Container(
                      width: boxWidth,
                      height: boxHeight,
                      color: Colors.blue, // Change box color as needed
                      alignment: Alignment.center,
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

 */