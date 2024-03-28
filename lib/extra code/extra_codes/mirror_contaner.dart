import 'package:flutter/material.dart';
import 'circle.dart';
import 'custom_shape.dart';

class MirrorContainer extends StatefulWidget {
  const MirrorContainer({Key? key,}) : super(key: key);

  @override
  State<MirrorContainer> createState() => _MirrorContainerState();
}

class _MirrorContainerState extends State<MirrorContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 180,
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
           const Positioned(
            top: 94.4,
            right: -84, // Change 'left' to 'right' for mirroring
            child: RankingCircleText(
              width: 180.0,
              height: 192.27,
            ),
          ),
          // Mirrored CustomShape widgets
          Positioned(
            top: 20,
            right: -34, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 176,
               text: 'CV / Resume',
              translateX: -15, // Provide translateX value
              translateY: 30,
                // textTransform: Matrix4.identity()..translate(22, 5)..rotateZ(1.50),
              onTap: (){}, textRotationDegree: 85,
            ),
          ),


          Positioned(
            top: 28,
            right: 8, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 158, text: 'Assessment',
              // textTransform: Matrix4.identity()..translate(12, 4)..rotateZ(1.20),
              onTap: (){},
              translateX: -16, translateY: 29, textRotationDegree: 68,
            ),
          ),

          Positioned(
            top: 48,
            right: 44, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 140, text: 'Assignment', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(2, 8)..rotateZ(0.90),
              onTap: (){},
              translateX: -16, translateY: 29, textRotationDegree: 52,
            ),
          ),

          Positioned(
            top: 76,
            right: 101, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 124,
              text: 'Fees', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(5, 20)..rotateZ(0.6),
              onTap: (){},
              translateX: -6, translateY: 22, textRotationDegree: 35,
            ),
          ),

          Positioned(
            top: 108.5,
            right: 98, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 109, text: 'Mid Term', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(-4, 22)..rotateZ(0.35),
              onTap: (){},
              translateX: -6, translateY: 30, textRotationDegree: 20,
            ),
          ),


          Positioned(
            top: 146,
            right: 100, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 91,
             text: 'Certificate',
              // textTransform: Matrix4.identity()..translate(-10, 29)..rotateZ(-0.0),
              onTap: (){},
              translateX: -10, translateY: 30, textRotationDegree: 0,
            ),
          ),


          Positioned(
            top: 185,
            right: 103, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree: 74,
              text: 'VT Letter', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(-8, 36)..rotateZ(-0.3),
              onTap: (){},
              translateX: -10, translateY: 30, textRotationDegree: -20,
            ),
          ),


          Positioned(
            top: 221,
            right: 98, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree:58,
              text: 'Activity', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(-3, 42)..rotateZ(-0.6),
              onTap: (){},
              translateX: -5, translateY: 30, textRotationDegree: -35,
            ),
          ),


          Positioned(
            top: 252,
            right: 60, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree:42,
              text: 'Gate Pass', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(-9, 54)..rotateZ(-0.9),
              onTap: (){},
              translateX: -12, translateY: 30, textRotationDegree: -52,
            ),
          ),


          Positioned(
            top: 274,
            right: 19, // Change 'left' to 'right' for mirroring
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree:24,
              text: 'Apply Leave', // Adjust this value for the mirrored effect
              // textTransform: Matrix4.identity()..translate(-1, 60)..rotateZ(-1.2),
              onTap: (){},
              translateX: -17, translateY: 30, textRotationDegree: -68,
            ),
          ),

          Positioned(
            top: 286,
            right: -22,
            child: CustomShape(
              topWidth: 15.0,
              rotationDegree:6, text: 'Marksheets',
              // textTransform: Matrix4.identity()..translate(2, 65)..rotateZ(-1.45),
              onTap: (){},
              translateX: -15, translateY: 30, textRotationDegree: -85,
            ),
          ),
        ],
      ),
    );
  }
}
