import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';


/// Original UI code
class CustomContainer extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CustomContainer({Key? key, required this.imageUrl,
    this.width = 165.0,
    this.height = 264.69,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}