import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomAnimationController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> bouncyAnimation;
  late Animation<double> curvyAnimation;

  @override
  void onInit() {
    super.onInit();
    initializeAnimation();
  }

  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    fadeAnimation = Tween<double>(begin: 3, end: 1).animate(controller);
    bouncyAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );
    curvyAnimation = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.forward();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class CustomBouncyAnimation extends GetWidget<CustomAnimationController> {
  final Widget child;

  const CustomBouncyAnimation({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: AnimatedBuilder(
        animation: controller.controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, controller.bouncyAnimation.value),
            child: Transform.scale(
              scale: controller.curvyAnimation.value,
              child: this.child,
            ),
          );
        },
      ),
    );
  }
}



/*
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomAnimationController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> bouncyAnimation;
  late Animation<double> curvyAnimation;

  @override
  void onInit() {
    super.onInit();
    initializeAnimation();
  }

  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    fadeAnimation = Tween<double>(begin: 3, end: 1).animate(controller);
    bouncyAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );
    curvyAnimation = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.forward();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class BouncyAnimation extends GetWidget<CustomAnimationController> {
  final Widget child;

  const BouncyAnimation({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: AnimatedBuilder(
        animation: controller.controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, controller.bouncyAnimation.value),
            child: Transform.scale(
              scale: controller.curvyAnimation.value,
              child: this.child,
            ),
          );
        },
      ),
    );
  }
}


 */