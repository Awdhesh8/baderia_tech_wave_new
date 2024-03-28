


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'circle.dart';
import 'custom_shape.dart';


class FirstCircleSelection extends StatefulWidget {

  final bool isProfileBoxVisible;
  final Function toggleProfileBox;

  const FirstCircleSelection({

    super.key, required this.isProfileBoxVisible, required this.toggleProfileBox,
  });

  @override
  State<FirstCircleSelection> createState() => _FirstCircleSelectionState();
}

class _FirstCircleSelectionState extends State<FirstCircleSelection> {
  bool isProfileBoxVisible = false;


  void toggleProfileBox() {
    setState(() {
      isProfileBoxVisible = !isProfileBoxVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      width: 180.0,
      padding: const EdgeInsets.all(0),
      child:  Stack(
        children: [
          const Positioned(
            top: 94.4,
            left: -84,
            child: RankingCircleText(
              width: 180.0,
              height: 192.0,
            ),
          ),
          Positioned(
            top: 23,
            left: 5,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 185,
              text: 'Profile',
              translateX: -3, // Provide translateX value
              translateY: 30,
              // textTransform: Matrix4.identity()..translate(5, 50)..rotateZ(-1.48),
              onTap: () {
                // Toggle visibility on tap
                widget.toggleProfileBox();
              }, textRotationDegree: -86,
            ),
          ),

          Positioned(
            top: 32.2,
            left: 42,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 205,
              text: 'Attendance',
              // textTransform: Matrix4.identity()..translate(-2, 60)..rotateZ(-1.18),
              onTap: (){}, translateX: -17, translateY: 30, textRotationDegree: -66,
            ),
          ),

          Positioned(
            top: 52,
            left: 76,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 222, text: 'Time Table',
              // textTransform: Matrix4.identity()..translate(-8, 53)..rotateZ(-0.88),
              onTap: (){}, translateX: -10, translateY: 28, textRotationDegree: -48,
            ),
          ),

          Positioned(
            top: 82,
            left: 102,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 240,
              text: 'Comments',
              // textTransform: Matrix4.identity()..translate(-10, 43)..rotateZ(-0.54),
              onTap: (){},
              translateX: -10, translateY: 28, textRotationDegree: -30,
            ),
          ),

          Positioned(
            top: 116,
            left: 118,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 254,
              text: 'Result',
              // textTransform: Matrix4.identity()..translate(-5, 35)..rotateZ(-0.28),
              onTap: () {
                    // Get.to(()=> const AcademicResult());
          },
              translateX: -4, translateY: 31, textRotationDegree: -16,
            ),
          ),


          Positioned(
            top: 151,
            left: 122,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 269,
              text: 'Training',
              // textTransform: Matrix4.identity()..translate(-10, 30)..rotateZ(0.0),
              onTap: (){},
              translateX: -4, translateY: 31, textRotationDegree: -1,
            ),
          ),


          Positioned(
            top: 186,
            left: 119,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 284,
              // textTransform: Matrix4.identity()..translate(-6, 22)..rotateZ(0.28),
              onTap: (){},
              text: 'Feedback',
              translateX: -6, translateY: 31, textRotationDegree: 15,
            ),
          ),


          Positioned(
            top: 220,
            left: 105.5,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 304, text: 'Placement',
              // textTransform: Matrix4.identity()..translate(-1, 15)..rotateZ(0.64),
              onTap: (){},
              translateX: -8, translateY: 33, textRotationDegree: 35,
            ),
          ),


          Positioned(
            top: 248,
            left: 81,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 319,
              // textTransform: Matrix4.identity()..translate(12, 18)..rotateZ(0.9),
              onTap: (){}, text: 'Career',
              translateX: 0, translateY: 33, textRotationDegree: 54,
            ),
          ),


          Positioned(
            top: 270,
            left: 47,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 334,
              // textTransform: Matrix4.identity()..translate(14, 14)..rotateZ(1.14),
              onTap: (){}, text: 'Internship',
              translateX: -10, translateY: 33, textRotationDegree: 64,
            ),
          ),


          Positioned(
            top: 282,
            left: 6,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 355,
              // textTransform: Matrix4.identity()..translate(22, 10)..rotateZ(1.55),
              onTap: (){}, text: 'Complains',
              translateX: -10, translateY: 33, textRotationDegree: 84,
            ),
          ),
        ],
      ),
    );
  }
}
