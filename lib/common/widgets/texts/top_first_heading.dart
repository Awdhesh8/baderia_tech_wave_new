import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TopHeading extends StatelessWidget {
  const TopHeading({
    Key? key,
    required this.text,
    this.fontSize = ESizes.fontSizeXl, // Add default value for fontSize
    this.fontWeight = FontWeight.w500, // Add default value for fontWeight
    this.textColor = EColors.textSecondaryTitle, // Add default value for textColor
  }) : super(key: key);

  final String text;
  final double fontSize; // Specify the type of 'fontSize'
  final FontWeight fontWeight; // Specify the type of 'fontWeight'
  final Color textColor; // Specify the type of 'textColor'

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              fontFamily: 'Inter',
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
