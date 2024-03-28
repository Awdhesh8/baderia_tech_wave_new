

// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
//
// class ScrollingCustomShape extends StatefulWidget {
//
//   final onTap;
//
//   const ScrollingCustomShape({
//     Key? key,
//
//     this.onTap,
//
//   }) : super(key: key);
//
//   @override
//   State<ScrollingCustomShape> createState() => _ScrollingCustomShapeState();
// }
//
// class _ScrollingCustomShapeState extends State<ScrollingCustomShape> {
//   bool isTapped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isTapped = !isTapped;
//             });
//             if (widget.onTap != null) {
//               widget.onTap();
//             }
//           },
//           child: CustomPaint(
//             painter: ShapePainter(
//               topWidth: 15.0,
//               color: isTapped
//                   ? Colors.red // Change color when tapped
//                   : const Color.fromRGBO(250, 170, 147, 1), width: 30.14, height: 75.5,
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isTapped = !isTapped;
//             });
//             if (widget.onTap != null) {
//               widget.onTap();
//             }
//           },
//           // child: Text(
//           //   widget.text,
//           //   style: const TextStyle(
//           //     color: Color.fromRGBO(16, 34, 130, 1),
//           //     fontSize: 11,
//           //     fontWeight: FontWeight.w600,
//           //   ),
//           // ),
//         ),
//       ],
//     );
//   }
// }
//
// class ShapePainter extends CustomPainter {
//   final double width;
//   final double height;
//   final double topWidth;
//   final Color color;
//
//   ShapePainter({
//     required this.color,
//     this.width = 30.1,
//     this.height = 70.5,
//     this.topWidth = 15.1,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final shadowPaint = Paint()
//       ..color = Colors.black.withOpacity(0.2)
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
//
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final double curveHeight = height * 0.1;
//
//     final path = Path()
//       ..moveTo((width - topWidth) / 2.6, 0)
//       ..lineTo((width + topWidth) / 1.9, 0)
//       ..lineTo(width, height - curveHeight)
//       ..quadraticBezierTo(
//           width, height, width - topWidth / 2, height)
//       ..lineTo(topWidth / 2, height)
//       ..quadraticBezierTo(0, height, 0, height - curveHeight)
//       ..lineTo((width - topWidth) / 2.5, 0);
//
//     canvas.drawPath(path, shadowPaint);
//     canvas.drawPath(path, paint);
//
//     final borderPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2
//       ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 0);
//
//     final borderPath = Path()
//       ..addPath(path, Offset.zero);
//
//     canvas.drawPath(borderPath, borderPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }


// width: 30.14,
// height: 75.5,