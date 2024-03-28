import 'package:flutter/material.dart';

class HeadingContainerTexts extends StatelessWidget {
  const HeadingContainerTexts({
    super.key,
    required this.titleOne,
    required this.titleSecond,
    required this.titleThird,
    this.width = 40,
    this.width2,
    this.width3,
  });
  final String? titleOne;
  final String? titleSecond;
  final String? titleThird;
  final double? width;
  final double? width2;
  final double? width3;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleOne!,
                    // 'Period',
                    style: const TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: width3,),
                  Text(
                    titleSecond!,
                    style: const TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      // height: 0,
                    ),
                  ),
                  SizedBox(width: width,),
                  Text(
                    titleThird!,
                    style: const TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: width2,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
