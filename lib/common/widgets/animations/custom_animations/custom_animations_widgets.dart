import 'package:flutter/material.dart';


class CustomAnimatedText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const CustomAnimatedText({
    this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1.0, end: 0.0), // Start from off-screen (-1.0) to original position (0.0)
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * -100, 0.0), // Translate horizontally based on value
          // offset: Offset(0.0, value * 100), // Translate vertically based on value
          child: Opacity(
            opacity: 1 + value, // Adjust opacity based on value to fade in
            child: child,
          ),
        );
      },
      child: Text(
        text!,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Inter',
          color: color,
        ),
      ),
    );
  }
}
class CustomAnimatedContainer extends StatelessWidget {
  final Widget child;

  CustomAnimatedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1.0, end: 0.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * -100, 0.0),
          child: Opacity(
            opacity: 1 + value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}