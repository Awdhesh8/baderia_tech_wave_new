import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';

class FeesDataContainer extends StatelessWidget {
  final String semester;
  final String preSemester;
  final String paidAmount;
  final String? time;
  final VoidCallback onPressed;

  const FeesDataContainer({
    required this.semester,
    required this.preSemester,
    required this.paidAmount,
    this.time,
    Key? key, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    semester,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    preSemester,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      // height: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    paidAmount,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Color(0xFFE31E24),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      // height: 1.2,
                                    ),
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  IconButton(onPressed: onPressed, icon: const Icon(Iconsax.arrow_circle_right5, color: EColors.textColorPrimary1, size: 20,))

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TotalFeesDataContainer extends StatelessWidget {
  final String totalText;
  final String preSemester;
  final String paidAmount;


  const TotalFeesDataContainer({
    required this.totalText,
    required this.preSemester,
    required this.paidAmount,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    totalText,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    preSemester,
                                    style: const TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      // height: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    paidAmount,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Color(0xFFE31E24),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      // height: 1.2,
                                    ),
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}