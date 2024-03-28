// import 'package:flutter/material.dart';
//
// class CustomAnimatedButton extends StatefulWidget {
//   final VoidCallback? onPressed;
//   final String label;
//   final void Function()? onNavigate;
//
//   // New customizable properties
//   final double width;
//   final double height;
//   final EdgeInsetsGeometry padding;
//   final EdgeInsetsGeometry margin;
//   final double borderRadius;
//   final Color buttonColor;
//   final Color borderColor;
//   final Color textColor;
//   final TextStyle? textStyle;
//   final Widget? child; // Make this non-required
//
//   CustomAnimatedButton({
//     this.onPressed,
//     this.onNavigate,
//     this.label = 'Tap Me',
//     this.width = 120.0,
//     this.height = 50.0,
//     this.padding = const EdgeInsets.all(16.0),
//     this.margin = const EdgeInsets.all(0.0),
//     this.borderRadius = 8.0,
//     this.buttonColor = Colors.blue,
//     this.borderColor = Colors.transparent,
//     this.textColor = Colors.white,
//     this.textStyle,
//     this.child,
//   });
//
//   @override
//   _CustomAnimatedButtonState createState() => _CustomAnimatedButtonState();
// }
//
// class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _animationController.forward();
//         Future.delayed(const Duration(milliseconds: 300), () {
//           _animationController.reverse();
//           if (widget.onPressed != null) {
//             widget.onPressed!.call();
//           } else {
//             // Default navigation using GetX after the animation is complete
//             _animationController.addStatusListener((status) {
//               if (status == AnimationStatus.dismissed) {
//                 // Navigate using GetX after the animation is complete
//                 if (widget.onNavigate != null) {
//                   widget.onNavigate!.call();
//                 }
//               }
//             });
//           }
//         });
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           width: widget.width,
//           height: widget.height,
//           padding: widget.padding,
//           margin: widget.margin,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//             color: widget.buttonColor,
//             border: Border.all(
//               color: widget.borderColor,
//                width: 1.5
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: .8,
//                 blurRadius: 1,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//           ),
//           child: widget.child ?? Text(
//             widget.label,
//             style: widget.textStyle ??
//                 TextStyle(
//                   color: widget.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedTapButton extends StatefulWidget {
  final Widget child;
  final Function onTap;

  const AnimatedTapButton({required this.child, required this.onTap});

  @override
  _AnimatedTapButtonState createState() => _AnimatedTapButtonState();
}

class _AnimatedTapButtonState extends State<AnimatedTapButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        Timer(Duration(milliseconds: 600), () {
          widget.onTap();
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: GetBuilder<AnimatedTapButtonController>(
        init: AnimatedTapButtonController(),
        builder: (controller) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(_isTapped ? 0.9 : 1.0),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class AnimatedTapButtonController extends GetxController {}

