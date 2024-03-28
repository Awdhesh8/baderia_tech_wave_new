import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = Colors.white;
    // paint.color = Color(0xffF7F7F7);
    path = Path();
    path.lineTo(size.width * 0.03, size.height * 0.11);
    path.cubicTo(size.width * 0.03, size.height * 0.07, size.width * 0.05, size.height * 0.03, size.width * 0.07, size.height * 0.03);
    path.cubicTo(size.width * 0.07, size.height * 0.03, size.width, size.height * 0.03, size.width, size.height * 0.03);
    path.cubicTo(size.width, size.height * 0.03, size.width * 1.03, size.height * 0.07, size.width * 1.03, size.height * 0.11);
    path.cubicTo(size.width * 1.03, size.height * 0.11, size.width * 1.03, size.height * 0.96, size.width * 1.03, size.height * 0.96);
    path.cubicTo(size.width * 1.03, size.height, size.width, size.height * 1.03, size.width, size.height * 1.03);
    path.cubicTo(size.width, size.height * 1.03, size.width * 0.57, size.height * 1.03, size.width * 0.57, size.height * 1.03);
    path.cubicTo(size.width * 0.54, size.height * 1.03, size.width * 0.52, size.height, size.width * 0.52, size.height * 0.96);
    path.cubicTo(size.width * 0.52, size.height * 0.96, size.width * 0.52, size.height * 0.85, size.width * 0.52, size.height * 0.85);
    path.cubicTo(size.width * 0.52, size.height * 0.81, size.width / 2, size.height * 0.78, size.width * 0.48, size.height * 0.78);
    path.cubicTo(size.width * 0.48, size.height * 0.78, size.width * 0.07, size.height * 0.78, size.width * 0.07, size.height * 0.78);
    path.cubicTo(size.width * 0.05, size.height * 0.78, size.width * 0.03, size.height * 0.75, size.width * 0.03, size.height * 0.71);
    path.cubicTo(size.width * 0.03, size.height * 0.71, size.width * 0.03, size.height * 0.11, size.width * 0.03, size.height * 0.11);
    path.cubicTo(size.width * 0.03, size.height * 0.11, size.width * 0.03, size.height * 0.11, size.width * 0.03, size.height * 0.11);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
