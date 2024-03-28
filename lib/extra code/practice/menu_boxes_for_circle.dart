// import 'dart:math';
// import 'package:flutter/material.dart';
//
//
// enum CircularDirection { clockwise, anticlockwise }
//
// class CircularBoxesWidget extends StatefulWidget {
//   final List<String> items;
//   final double circleRadius;
//   final double boxWidth;
//   final double boxHeight;
//   final double sensitivity;
//   final double topOffset;
//   final double leftOffset;
//   final bool reverseTextDirection;
//   final CircularDirection rotationDirection;
//
//   const CircularBoxesWidget({
//     Key? key,
//     required this.items,
//     this.circleRadius = 120.0,
//     this.boxWidth = 70.0,
//     this.boxHeight = 20.0,
//     this.sensitivity = 0.02,
//     this.topOffset = 10 * 6,
//     this.leftOffset = 20 * 10,
//     this.reverseTextDirection = false,
//     this.rotationDirection = CircularDirection.clockwise,
//   }) : super(key: key);
//
//   @override
//   _CircularBoxesWidgetState createState() => _CircularBoxesWidgetState();
// }
//
// class _CircularBoxesWidgetState extends State<CircularBoxesWidget>
//     with SingleTickerProviderStateMixin {
//   late double _angle = 0.0;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200), // Adjust duration as needed
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     print('Disposing widget: $this');
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CircularBoxes(
//       items: widget.items,
//       circleRadius: widget.circleRadius,
//       boxWidth: widget.boxWidth,
//       boxHeight: widget.boxHeight,
//       sensitivity: widget.sensitivity,
//       topOffset: widget.topOffset,
//       leftOffset: widget.leftOffset,
//       reverseTextDirection: widget.reverseTextDirection,
//       rotationDirection: widget.rotationDirection,
//       angle: _angle,
//       onAngleUpdate: (double newAngle) {
//         setState(() {
//           _angle = newAngle % (2 * pi); // Ensures continuous 360-degree rotation
//         });
//       },
//       animationController: _animationController,
//     );
//   }
// }
//
// class CircularBoxes extends StatelessWidget {
//   final List<String> items;
//   final double circleRadius;
//   final double boxWidth;
//   final double boxHeight;
//   final double sensitivity;
//   final double topOffset;
//   final double leftOffset;
//   final bool reverseTextDirection;
//   final CircularDirection rotationDirection;
//   final double angle;
//   final ValueChanged<double> onAngleUpdate;
//   final AnimationController animationController;
//
//   const CircularBoxes({
//     Key? key,
//     required this.items,
//     required this.circleRadius,
//     required this.boxWidth,
//     required this.boxHeight,
//     required this.sensitivity,
//     required this.topOffset,
//     required this.leftOffset,
//     required this.reverseTextDirection,
//     required this.rotationDirection,
//     required this.angle,
//     required this.onAngleUpdate,
//     required this.animationController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double totalItems = items.length.toDouble();
//
//     return GestureDetector(
//       onPanUpdate: (details) {
//         double newAngle = angle + details.delta.dx * sensitivity;
//         onAngleUpdate(newAngle);
//       },
//       // onPanUpdate: (details) {
//       //   final newAngle = angle +
//       //       (rotationDirection == CircularDirection.clockwise ? -1 : 1) *
//       //           details.delta.dx *
//       //           sensitivity;
//       //   onAngleUpdate(newAngle);
//       // },
//       child: Center(
//         child: Container(
//           width: circleRadius * 4,
//           height: circleRadius * 4,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           child: AnimatedBuilder(
//             animation: animationController,
//             builder: (context, child) {
//               return Stack(
//                 children: List.generate(items.length, (index) {
//                   double boxAngle = (2 * pi / totalItems) * index + angle;
//                   return Positioned(
//                     top: circleRadius +
//                         circleRadius * sin(boxAngle) -
//                         (boxHeight / 2 - topOffset),
//                     left: circleRadius +
//                         circleRadius * cos(boxAngle) +
//                         (boxWidth / 2 + leftOffset),
//                     child: Transform.rotate(
//                       angle: boxAngle,
//                       child: Transform(
//                         alignment: Alignment.center,
//                         transform: reverseTextDirection
//                             ? Matrix4.rotationZ(pi)
//                             : Matrix4.rotationZ(0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border:
//                             Border.all(width: 1, color: Colors.white),
//                             color: const Color.fromRGBO(
//                                 250, 170, 147, 1),
//                             borderRadius: BorderRadius.circular(4),
//                             boxShadow: const [
//                               BoxShadow(
//                                   blurRadius: 3,
//                                   spreadRadius: .5,
//                                   color: Colors.black26),
//                             ],
//                           ),
//                           width: boxWidth,
//                           height: boxHeight,
//                           alignment: Alignment.center,
//                           child: Text(
//                             items[index],
//                             style: const TextStyle(
//                               color: Color.fromRGBO(16, 34, 130, 1),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }




/*
// Correct Rectangle box

import 'dart:math';
import 'package:flutter/material.dart';


enum CircularDirection { clockwise, anticlockwise }

class CircularBoxesWidget extends StatefulWidget {
  final List<String> items;
  final double circleRadius;
  final double boxWidth;
  final double boxHeight;
  final double sensitivity;
  final double topOffset;
  final double leftOffset;
  final bool reverseTextDirection;
  final CircularDirection rotationDirection;

  const CircularBoxesWidget({
    Key? key,
    required this.items,
    this.circleRadius = 120.0,
    this.boxWidth = 70.0,
    this.boxHeight = 20.0,
    this.sensitivity = 0.02,
    this.topOffset = 10 * 6,
    this.leftOffset = 20 * 10,
    this.reverseTextDirection = false,
    this.rotationDirection = CircularDirection.clockwise,
  }) : super(key: key);

  @override
  _CircularBoxesWidgetState createState() => _CircularBoxesWidgetState();
}

class _CircularBoxesWidgetState extends State<CircularBoxesWidget>
    with SingleTickerProviderStateMixin {
  late double _angle = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Adjust duration as needed
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularBoxes(
      items: widget.items,
      circleRadius: widget.circleRadius,
      boxWidth: widget.boxWidth,
      boxHeight: widget.boxHeight,
      sensitivity: widget.sensitivity,
      topOffset: widget.topOffset,
      leftOffset: widget.leftOffset,
      reverseTextDirection: widget.reverseTextDirection,
      rotationDirection: widget.rotationDirection,
      angle: _angle,
      onAngleUpdate: (double newAngle) {
        setState(() {
          _angle = newAngle % (2 * pi); // Ensures continuous 360-degree rotation
        });
      },
      animationController: _animationController,
    );
  }
}

class CircularBoxes extends StatelessWidget {
  final List<String> items;
  final double circleRadius;
  final double boxWidth;
  final double boxHeight;
  final double sensitivity;
  final double topOffset;
  final double leftOffset;
  final bool reverseTextDirection;
  final CircularDirection rotationDirection;
  final double angle;
  final ValueChanged<double> onAngleUpdate;
  final AnimationController animationController;

  const CircularBoxes({
    Key? key,
    required this.items,
    required this.circleRadius,
    required this.boxWidth,
    required this.boxHeight,
    required this.sensitivity,
    required this.topOffset,
    required this.leftOffset,
    required this.reverseTextDirection,
    required this.rotationDirection,
    required this.angle,
    required this.onAngleUpdate,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double totalItems = items.length.toDouble();

    return GestureDetector(
      onPanUpdate: (details) {
        double newAngle = angle + details.delta.dx * sensitivity;
        onAngleUpdate(newAngle);
      },
      // onPanUpdate: (details) {
      //   final newAngle = angle +
      //       (rotationDirection == CircularDirection.clockwise ? -1 : 1) *
      //           details.delta.dx *
      //           sensitivity;
      //   onAngleUpdate(newAngle);
      // },
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
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Stack(
                children: List.generate(items.length, (index) {
                  double boxAngle = (2 * pi / totalItems) * index + angle;
                  return Positioned(
                    top: circleRadius +
                        circleRadius * sin(boxAngle) -
                        (boxHeight / 2 - topOffset),
                    left: circleRadius +
                        circleRadius * cos(boxAngle) +
                        (boxWidth / 2 + leftOffset),
                    child: Transform.rotate(
                      angle: boxAngle,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: reverseTextDirection
                            ? Matrix4.rotationZ(pi)
                            : Matrix4.rotationZ(0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                            Border.all(width: 1, color: Colors.white),
                            color: const Color.fromRGBO(
                                250, 170, 147, 1),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: .5,
                                  color: Colors.black26),
                            ],
                          ),
                          width: boxWidth,
                          height: boxHeight,
                          alignment: Alignment.center,
                          child: Text(
                            items[index],
                            style: const TextStyle(
                              color: Color.fromRGBO(16, 34, 130, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

*/










/*
class CircularBoxesWidget extends StatelessWidget {
  final List<String> items;
  final double circleRadius;
  final double boxWidth;
  final double boxHeight;
  final double sensitivity;
  final double topOffset;
  final double leftOffset;
  final bool reverseTextDirection;

  const CircularBoxesWidget({
    Key? key,
    required this.items,
    this.circleRadius = 150.0,
    this.boxWidth = 90.0,
    this.boxHeight = 26.0,
    this.sensitivity = 0.01,
    this.topOffset = 10 * 6,
    this.leftOffset = 20 * 10,
    this.reverseTextDirection = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularBoxes(
      items: items,
      circleRadius: circleRadius,
      boxWidth: boxWidth,
      boxHeight: boxHeight,
      sensitivity: sensitivity,
      topOffset: topOffset,
      leftOffset: leftOffset,
      reverseTextDirection: reverseTextDirection,
    );
  }
}

class CircularBoxes extends StatefulWidget {
  final List<String> items;
  final double circleRadius;
  final double boxWidth;
  final double boxHeight;
  final double sensitivity;
  final double topOffset;
  final double leftOffset;
  final bool reverseTextDirection;

  const CircularBoxes({
    Key? key,
    required this.items,
    required this.circleRadius,
    required this.boxWidth,
    required this.boxHeight,
    required this.sensitivity,
    required this.topOffset,
    required this.leftOffset,
    required this.reverseTextDirection,
  }) : super(key: key);

  @override
  _CircularBoxesState createState() => _CircularBoxesState();
}

class _CircularBoxesState extends State<CircularBoxes> {
  late double _angle = 0.0;

  @override
  Widget build(BuildContext context) {
    final double totalItems = widget.items.length.toDouble();
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx * widget.sensitivity;
        });
      },
      child: Center(
        child: Container(
          width: widget.circleRadius * 4,
          height: widget.circleRadius * 4,
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
                top: widget.circleRadius +
                    widget.circleRadius * sin(_angle + boxAngle) -
                    (widget.boxHeight / 2 - widget.topOffset),
                left: widget.circleRadius +
                    widget.circleRadius * cos(_angle + boxAngle) -
                    (widget.boxWidth / 2 + widget.leftOffset),
                child: Transform.rotate(
                  angle: _angle + boxAngle,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: widget.reverseTextDirection
                        ? Matrix4.rotationZ(pi)
                        : Matrix4.rotationZ(0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        color: const Color.fromRGBO(250, 170, 147, 1),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(blurRadius: 3, spreadRadius: .5, color: Colors.black26),
                        ],
                      ),
                      width: widget.boxWidth,
                      height: widget.boxHeight,
                      alignment: Alignment.center,
                      child: Text(
                        widget.items[index],
                        style: const TextStyle(
                          color: Color.fromRGBO(16, 34, 130, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
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

*/


// class CircularBoxesWidget extends StatelessWidget {
//   final List<String> items;
//   final double circleRadius;
//   final double boxWidth;
//   final double boxHeight;
//   final double sensitivity;
//   final double topOffset;
//   final double leftOffset;
//
//   const CircularBoxesWidget({
//     Key? key,
//     required this.items,
//     this.circleRadius = 150.0,
//     this.boxWidth = 90.0,
//     this.boxHeight = 26.0,
//     this.sensitivity = 0.01,
//     this.topOffset = 10 * 8,
//     this.leftOffset = 20 * 10,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CircularBoxes(
//       items: items,
//       circleRadius: circleRadius,
//       boxWidth: boxWidth,
//       boxHeight: boxHeight,
//       sensitivity: sensitivity,
//       topOffset: topOffset,
//       leftOffset: leftOffset,
//     );
//   }
// }
//
// class CircularBoxes extends StatefulWidget {
//   final List<String> items;
//   final double circleRadius;
//   final double boxWidth;
//   final double boxHeight;
//   final double sensitivity;
//   final double topOffset;
//   final double leftOffset;
//
//   const CircularBoxes({
//     Key? key,
//     required this.items,
//     required this.circleRadius,
//     required this.boxWidth,
//     required this.boxHeight,
//     required this.sensitivity,
//     required this.topOffset,
//     required this.leftOffset,
//   }) : super(key: key);
//
//   @override
//   _CircularBoxesState createState() => _CircularBoxesState();
// }
//
// class _CircularBoxesState extends State<CircularBoxes> {
//   late double _angle = 0.0;
//
//   @override
//   Widget build(BuildContext context) {
//     final double totalItems = widget.items.length.toDouble();
//     return GestureDetector(
//       onPanUpdate: (details) {
//         setState(() {
//           _angle += details.delta.dx * widget.sensitivity;
//         });
//       },
//       child: Center(
//         child: Container(
//           width: widget.circleRadius * 4,
//           height: widget.circleRadius * 4,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Colors.transparent,
//               width: 0,
//             ),
//           ),
//           child: Stack(
//             children: List.generate(widget.items.length, (index) {
//               double boxAngle = (2 * pi / totalItems) * index;
//               return Positioned(
//                 top: widget.circleRadius +
//                     widget.circleRadius * sin(_angle + boxAngle) -
//                     (widget.boxHeight / 2 - widget.topOffset),
//                 left: widget.circleRadius +
//                     widget.circleRadius * cos(_angle + boxAngle) -
//                     (widget.boxWidth / 2 + widget.leftOffset),
//                 child: Transform.rotate(
//                   angle: _angle + boxAngle,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.white),
//                       color: const Color.fromRGBO(250, 170, 147, 1),
//                       borderRadius: BorderRadius.circular(4),
//                       boxShadow: const [
//                         BoxShadow(blurRadius: 3, spreadRadius: .5, color: Colors.black26),
//                       ],
//                     ),
//                     width: widget.boxWidth,
//                     height: widget.boxHeight,
//                     alignment: Alignment.center,
//                     child: Text(
//                       widget.items[index],
//                       style: const TextStyle(
//                         color: Color.fromRGBO(16, 34, 130, 1),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
