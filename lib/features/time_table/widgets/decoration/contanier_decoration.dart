// box_decorations.dart

import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

BoxDecoration customDecoration() {
  return BoxDecoration(
      boxShadow: [
        BoxShadow(
            blurRadius: 0,
            offset: Offset(-2, -2),
            color: Colors.white
        )
      ],
      color: EColors.lightContainer1,
      borderRadius: BorderRadius.circular(14)
  );
  // return BoxDecoration(
  //   color: Colors.white70,
  //   // color: const Color(0xFFFFE0E5),
  //   borderRadius: BorderRadius.circular(20),
  //   boxShadow: const [
  //     BoxShadow(
  //       // color: Color(0xFFFFC1C5),
  //       color: Colors.white,
  //       offset: Offset(-2, -2),
  //       blurRadius: 0,
  //       spreadRadius: 1,
  //     ),
  //     BoxShadow(
  //       color: Color(0xFFFFC1C5),
  //       offset: Offset(2, 2),
  //       blurRadius: 0,
  //       spreadRadius: 1,
  //     ),
  //   ],
  // );
}
