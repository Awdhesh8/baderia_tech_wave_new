import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CustomTextStyle extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const CustomTextStyle({super.key,
    required this.text,
    this.fontSize = 13.0,
    this.fontWeight = FontWeight.w500,
    this.color = EColors.textSecondaryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter', // Assuming 'Inter' is the font family name
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
