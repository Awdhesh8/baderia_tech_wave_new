import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class CustomContainerButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const CustomContainerButton({
    Key? key,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomContainerButtonState createState() => _CustomContainerButtonState();
}

class _CustomContainerButtonState extends State<CustomContainerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
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
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 - (_controller.value * 0.22),
            child: child,
          );
        },
        child: Container(
          width: 108,
          height: 50,
          decoration: BoxDecoration(
            // color: Colors.white,
              //color: Color(0xFF4E2120),
              // color: Color(0xFF6e3b39),
              // color: Color(0xFF4E2928),
             // color: Colors.brown,
              color: Colors.brown.shade700,
           // color: EColors.primarySecond,
            borderRadius: BorderRadius.circular(22),
             border: Border.all(color: Colors.white, width: .1),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.shade200,
                // color: Colors.black.withOpacity(0.1),
                spreadRadius: .8,
                blurRadius: 0,
                offset: const Offset(0, 1.4),
              ),
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
              ),
            ],
              // BoxShadow(
              //   color: Colors.black.withOpacity(0.1),
              //   spreadRadius: 2,
              //   blurRadius: 4,
              //   offset: const Offset(0, 2),
              // ),
            // ],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.buttonText,
              style: const TextStyle(
                 color: EColors.white,
                //color: EColors.textColorPrimary1,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// without animation
/*

import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class CustomContainerButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const CustomContainerButton({
    Key? key,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 110,
        height: 52,
        decoration: BoxDecoration(
          color: EColors.primarySecond,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Adjust opacity and color as needed
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2), // Adjust the position of the shadow
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: EColors.textColorPrimary1,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}



 */
