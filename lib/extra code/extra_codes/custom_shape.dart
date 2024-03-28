import 'package:flutter/material.dart';
import 'dart:math' as math;
//
// class CustomShape extends StatefulWidget {
//   final double topWidth;
//   final double rotationDegree;
//   final String text;
//   final Matrix4 textTransform;
//   final onTap;
//
//   const CustomShape({
//     Key? key,
//     required this.topWidth,
//     required this.rotationDegree,
//     required this.text,
//     required this.textTransform,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   State<CustomShape> createState() => _CustomShapeState();
// }
//
// class _CustomShapeState extends State<CustomShape> {
//   bool isTapped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Transform.rotate(
//           angle: widget.rotationDegree * math.pi / 180,
//           child: SizedBox(
//             width: 30.14,
//             height: 75.5,
//             child: GestureDetector(
//               onTap: () {
//                 // setState(() {
//                 //   isTapped = !isTapped;
//                 // });
//                 // if (widget.onTap != null) {
//                 //   widget.onTap();
//                 // }
//               },
//               child: CustomPaint(
//                 painter: ShapePainter(
//                   topWidth: widget.topWidth,
//                   color:
//                   // isTapped
//                   //     ? Colors.red // Change color when tapped
//                   //     :
//                   const Color.fromRGBO(250, 170, 147, 1),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Transform(
//           transform: widget.textTransform,
//           child: Text(
//             textAlign: TextAlign.right,
//             widget.text,
//             style: const TextStyle(
//               color: Color.fromRGBO(16, 34, 130, 100),
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


class CustomShape extends StatefulWidget {
  final double topWidth ;
  final double rotationDegree;
  final String text;
  final double translateX; // New property for X translation
  final double translateY; // New property for Y translation
  final onTap;
  final double textRotationDegree;

  const CustomShape({
    Key? key,
    this.topWidth = 15.1,
    required this.rotationDegree,
    required this.text,
    required this.translateX,
    required this.translateY,
    this.onTap,
    required this.textRotationDegree,
  }) : super(key: key);

  @override
  State<CustomShape> createState() => _CustomShapeState();
}

class _CustomShapeState extends State<CustomShape> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: widget.rotationDegree * math.pi / 180,
          child: SizedBox(
            width: 30.14,
            height: 75.5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
                if (widget.onTap != null) {
                  widget.onTap();
                }
              },
              child: CustomPaint(
                painter: ShapePainter(
                  topWidth: widget.topWidth,
                  color: isTapped
                      ? Colors.red // Change color when tapped
                      : const Color.fromRGBO(250, 170, 147, 1),
                ),
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(widget.translateX, widget.translateY),
          child: Transform.rotate(
            angle: widget.textRotationDegree * math.pi / 180,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
                if (widget.onTap != null) {
                  widget.onTap();
                }
              },
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color.fromRGBO(16, 34, 130, 1),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class ShapePainter extends CustomPainter {
  final double topWidth;
  final Color color;

  ShapePainter({required this.color, required this.topWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2) // Shadow color and opacity
      ..maskFilter =
          const MaskFilter.blur(BlurStyle.normal, 4); // Shadow settings

    final paint = Paint()
      ..color = color // Fill color
      ..style = PaintingStyle.fill; // Fill style

    final double curveHeight =
        size.height * 0.1; // Adjust the curve height here

    final path = Path()
      ..moveTo((size.width - topWidth) / 2.6, 0) // Move to the top left point
      ..lineTo(
          (size.width + topWidth) / 1.9, 0) // Draw line to the top right point
      ..lineTo(size.width,
          size.height - curveHeight) // Draw line to the bottom right curve
      ..quadraticBezierTo(size.width, size.height, size.width - topWidth / 2,
          size.height) // Draw bottom right curve
      ..lineTo(topWidth / 2, size.height) // Draw line to the bottom left curve
      ..quadraticBezierTo(0, size.height, 0,
          size.height - curveHeight) // Draw bottom left curve
      ..lineTo((size.width - topWidth) / 2.5,
          0); // Draw line back to the top left point

    canvas.drawPath(path, shadowPaint); // Draw shadow first
    canvas.drawPath(path, paint); // Then draw the shape

    final borderPaint = Paint()
      ..color = Colors.white // Border color
      ..style = PaintingStyle.stroke // Border style
      ..strokeWidth = 2 // Border width
      ..maskFilter =
          const MaskFilter.blur(BlurStyle.outer, 0); // Border shadow settings

    final borderPath = Path()
      ..addPath(
          path, Offset.zero); // Create border path based on the shape path

    canvas.drawPath(borderPath, borderPaint); // Draw the border
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Prevent unnecessary repaints
  }
}
