import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:iconsax/iconsax.dart';

class BouncyButton extends StatefulWidget {
  final String? label;
  // final String iconPath;
  final Function onPressed;

  const BouncyButton({
    Key? key,
    this.label,
    // required this.iconPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  _BouncyButtonState createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 130),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 - (_controller.value * 0.3),
            child: child,
          );
        },
        child: Container(
          // width: 200,
          // height: 60,
          decoration: BoxDecoration(
            // color: EColors.primarySecond,
            color: Colors.red.shade50,
            // color: EColors.lightContainer,
            // color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.label!,
                  style: TextStyleClass.buttonStyle1
                ),
              ),
              // Icon(Iconsax.arrow_right_2, color: Colors.white,),
              // Icon(FontAwesomeIcons.externalLink, color: Colors.white, size: 12,),
             /*
              Container(
                  decoration: BoxDecoration(
                    color: EColors.white,
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        spreadRadius: .8,
                        blurRadius: 0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(Icons.arrow_circle_right_outlined, color: Colors.red.shade400,),
              ),

              */
               Icon(Icons.arrow_right_alt_rounded, color: Colors.black,),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
// import 'package:iconsax/iconsax.dart';
//
// class BouncyButton extends StatefulWidget {
//   final String label;
//   // final String iconPath;
//   final Function onPressed;
//
//   const BouncyButton({
//     Key? key,
//     required this.label,
//     // required this.iconPath,
//     required this.onPressed,
//   }) : super(key: key);
//
//   @override
//   _BouncyButtonState createState() => _BouncyButtonState();
// }
//
// class _BouncyButtonState extends State<BouncyButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 100),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _handleTap() async {
//     await _controller.forward();
//     await _controller.reverse();
//     widget.onPressed();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _handleTap,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: 1 - (_controller.value * 0.1),
//             child: child,
//           );
//         },
//         child: Container(
//           // width: 200,
//           // height: 60,
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // SvgPicture.asset(
//               //   widget.iconPath,
//               //   width: 24,
//               //   height: 24,
//               //   color: Colors.white,
//               // ),
//               // SizedBox(width: 10),
//               Text(
//                 widget.label,
//                 style: TextStyleClass.buttonStyle1
//               ),
//               Icon(Iconsax.arrow_right_3),
//               // Icon(FontAwesomeIcons.share),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
