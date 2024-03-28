import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
class CustomShapeWidget extends StatelessWidget {
  final double width;
  final double height;
  final double topLeftBorderRadius;
  final double bottomLeftBorderRadius;

  const CustomShapeWidget({
    super.key,
    required this.width,
    required this.height,
    required this.topLeftBorderRadius,
    required this.bottomLeftBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftBorderRadius),
          bottomLeft: Radius.circular(bottomLeftBorderRadius),
        ),
      ),
      child: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          color: EColors.circleAvatar,
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 50.0, 0.0);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width - 50.0, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/*
class CustomRoundedRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double topRightRadius;
  final double bottomRightRadius;

  const CustomRoundedRectangle({super.key,
    required this.width,
    required this.height,
    required this.color,
    this.topRightRadius = 20.0,
    this.bottomRightRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: RoundedRectanglePainter(
          color: EColors.primarySecond,
        ),
      ),
    );
  }
}

class RoundedRectanglePainter extends CustomPainter {
  final Color color;


  RoundedRectanglePainter({
    required this.color,

  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    double width = size.width;
    double height = size.height;

    Path path = Path();
     /// (0, 0) // 1, point
     //  path.lineTo(0, height);
    path.quadraticBezierTo(height * 0.6, width -101 , 0, height);
    path.lineTo(width, height);
    // path.lineTo(width, height);
    path.lineTo(width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


 */
// class ProfileBox extends StatefulWidget {
//   const ProfileBox({super.key});
//
//   @override
//   State<ProfileBox> createState() => _ProfileBoxState();
// }
//
// class _ProfileBoxState extends State<ProfileBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.all(1),
//       color: EColors.primary,
//       shape: CircleBorder(),
//       // decoration: ShapeDecoration(
//       //   color: EColors.primary,
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.circular(20),
//       //   ),
//       //   shadows: const [
//       //     BoxShadow(
//       //       color: Color(0x26000000),
//       //       blurRadius: 10.90,
//       //       offset: Offset(0, 0),
//       //       spreadRadius: 0,
//       //     )
//       //   ],
//       // ),
//       child: const Padding(
//         padding: EdgeInsets.all(14),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 CircleAvatar(
//                   radius: 70,
//                   backgroundColor: EColors.softGrey,
//                 ),
//               ],
//             ),
//             SizedBox(width: ESizes.spaceBtwItems,),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           'Surya Pratap Singh',
//                           style: TextStyle(
//                             color: EColors.white,
//                             fontSize: 18,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w600,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: ESizes.spaceBtwItemsHeadings),
//                   Text('E no:  1201ME2024',
//                     style: TextStyle(
//                       color: EColors.white,
//                       fontSize: 13,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text('Sem: 2nd sem',
//                     style: TextStyle(
//                       color: EColors.white,
//                       fontSize: 13,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text('Branch: Computer Science',
//                     style: TextStyle(
//                       color: EColors.white,
//                       fontSize: 13,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }