import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSemicircle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double angle;

  const CustomSemicircle({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: SemiCirclePainter(angle: angle),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  final double angle;

  SemiCirclePainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    // Drawing the semi-circle
    double radius = size.width / 2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, size.height), radius: radius),
      math.pi / 180 * angle,
      math.pi,
      true,
      paint,
    );

    // Drawing the border on the curved side
    Paint borderPaint = Paint()
      ..color = const Color(0xFFF7F7F7) // Border color
      ..style = PaintingStyle.stroke // Border style
      ..strokeWidth = 7; // Border width

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, size.height), radius: radius),
      math.pi / 180 * angle,
      math.pi,
      false, // Draw only the border
      borderPaint,
    );

    // Drawing shadow on the curved side
    Paint shadowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3.90)
      ..color = const Color(0x3F000000);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, size.height), radius: radius),
      math.pi / 180 * angle,
      math.pi,
      true,
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
