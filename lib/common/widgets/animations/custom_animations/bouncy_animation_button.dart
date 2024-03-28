import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BouncyButtonWidget extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const BouncyButtonWidget({required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BouncyController>(
      builder: (controller) {
        return ScaleTransition(
          scale: controller.animation,
          child: GestureDetector(
            onTap: () async {
              await controller.animateButton(onPressed);
            },
            child: child,
          ),
        );
      },
    );
  }
}

class BouncyController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  Future<void> animateButton(Function()? onPressed) async {
    await _controller.forward();
    await _controller.reverse();
    if (onPressed != null) {
      onPressed();
    }
  }

  Animation<double> get animation => _animation;
}
