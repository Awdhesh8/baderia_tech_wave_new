import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'colors.dart';

class TextStyleClass {
  static const TextStyle heading28 = TextStyle(
    fontFamily: 'Inter',
    fontSize: ESizes.appTitle2,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading24 = TextStyle(
    fontFamily: 'Inter',
    fontSize: ESizes.fontSizeSm,
    fontWeight: FontWeight.w400,
    color: EColors.textSecondaryTitle,
  );

  static const TextStyle heading22 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: ESizes.fontSizeLg,
    color: EColors.textSecondaryTitle,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle captionText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle buttonStyle1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    // color: Colors.white,
    // color: Colors.black87,
    // color: EColors.textSecondaryTitle,
  );

  static const TextStyle subtleTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );


  static const TextStyle bodyText2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: EColors.textSecondaryTitle,
  );
  static const TextStyle feesText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: EColors.textSecondaryTitle,
  );

  static const TextStyle bodyText3 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: EColors.black,
    // color: EColors.textSecondaryTitle,
  );

  static const TextStyle feesSummaryText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
    color: EColors.textColorPrimary1,
  );

  static const TextStyle labelText1 = TextStyle(
    color: Colors.black54,
    fontSize: 12,
    fontFamily: 'Inter',
  );

  static const TextStyle inputText1 = TextStyle(
    color: EColors.textColorPrimary1,
    fontSize: 12,
    fontFamily: 'Inter',
  );

  static const TextStyle appBarTextStyle = TextStyle(
      color: EColors.textColorPrimary1,
      fontWeight: FontWeight.w600,
      fontSize: ESizes.appTitle,
      fontFamily: 'Inter');

// Add more styles as needed

// Example of usage:
// Text("Hello, ", style: CustomTextStyle.heading1),
}
