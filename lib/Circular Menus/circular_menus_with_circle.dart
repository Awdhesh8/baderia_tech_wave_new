/*
import 'package:flutter/cupertino.dart';
import '../extra code/extra_codes/circle.dart';
import '../features/home/screens/left_circle_menu_and_screens/left_circle_menus.dart';
import '../features/home/screens/right_circle_menu_and_screens/right_circular_menus.dart';

// class CircularMenuWithCircle extends StatelessWidget {
//   const CircularMenuWithCircle({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Stack(
//           children: [
//
//             Positioned(
//               top: 110.4,
//               right: 95,
//               child: CustomCircle(
//                 width: 168.0,
//                 height: 168.0,
//               ),
//             ),
//             SizedBox(
//               width: 180,
//               height: 400,
//               // color: Colors.grey,
//               child: LeftSideCircularScrollingBoxes(),
//             ),
//           ],
//         ),
//
//         Stack(
//           children: [
//             Positioned(
//               top: 110.4,
//               right: -78,
//               child: CustomCircle2(
//                 width: 168.0,
//                 height: 168.0,
//               ),
//             ),
//             SizedBox(
//               width: 180,
//               height: 400,
//               // color: Colors.grey,
//               child: RightSideCircularScrollingBoxes(),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


class CircularMenuWithCircle extends StatelessWidget {
  const CircularMenuWithCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            LeftSideCircularScrollingBoxes(),
            Positioned(
              top: 110.4,
              right: 95,
              child: CustomCircle(
                width: 168.0,
                height: 168.0,
              ),
            ),
          ],
        ),

        Stack(
          children: [
            Positioned(
              top: 110.4,
              right: -78,
              child: CustomCircle2(
                width: 168.0,
                height: 168.0,
              ),
            ),
            SizedBox(
              width: 180,
              height: 400,
              child: RightSideCircularScrollingBoxes(),
            ),
          ],
        ),
      ],
    );
  }
}


 */


import 'package:flutter/cupertino.dart';
import '../extra code/extra_codes/circle.dart';
import '../features/home/screens/left_circle_menu_and_screens/left_circle_menus.dart';
import '../features/home/screens/right_circle_menu_and_screens/right_circular_menus.dart';

class CircularMenuWithCircle extends StatelessWidget {
  final Function(int) onIndexChanged;

  const CircularMenuWithCircle({
    Key? key,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            LeftSideCircularScrollingBoxes(
              onIndexChanged: onIndexChanged,
            ),
            Positioned(
              top: 110.4,
              right: 95,
              child: RankingCircleText(
                width: 168.0,
                height: 168.0,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Positioned(
              top: 110.4,
              right: -78,
              child: AttendanceCircleText(
                width: 168.0,
                height: 168.0,
              ),
            ),
            SizedBox(
              width: 180,
              height: 400,
              child: RightSideCircularScrollingBoxes(
              ),
            ),
          ],
        ),
      ],
    );
  }
}
