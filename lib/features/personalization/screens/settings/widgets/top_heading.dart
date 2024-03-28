import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';

class TopHeading extends StatelessWidget {
  final String text;
  final double fontSize;

  const TopHeading({Key? key, required this.text, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
        color: EColors.textColorPrimary1
      ),
    );
  }
}
