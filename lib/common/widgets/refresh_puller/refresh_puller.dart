import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationWidget extends StatefulWidget {
  const RiveAnimationWidget({Key? key}) : super(key: key);

  @override
  _RiveAnimationWidgetState createState() => _RiveAnimationWidgetState();
}

class _RiveAnimationWidgetState extends State<RiveAnimationWidget> {
  late RiveAnimationController _riveController;

  @override
  void initState() {
    super.initState();
    _riveController = SimpleAnimation("idle");
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      "assets/RiveAssets/help! (2).riv",
      fit: BoxFit.cover,
      animations: const ['Motion'],
      stateMachines: const ['Motion'],
      controllers: [_riveController],
    );
  }
}






/*
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class RefreshScreen extends StatelessWidget {
  final Widget body;
  final double offsetToArmed;
  final Future<void> Function() onRefresh;
  final Widget? child; // Optional child parameter

  const RefreshScreen({
    Key? key,
    required this.body,
    this.offsetToArmed = 200.0,
    required this.onRefresh,
    this.child, // Accept child as optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: onRefresh,
        offsetToArmed: offsetToArmed,
        builder: (context, child, controller) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: offsetToArmed * controller.value,
                  child: const RiveAnimation.asset(
                    "assets/RiveAssets/help!.riv",
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: Offset(
                    0.0,
                    offsetToArmed * controller.value,
                  ),
                  child: this.child ?? Container(), // Use provided child or default to Container
                )
              ],
            );
          },
          child: child, // Pass child to AnimatedBuilder
        ),
        child: body, // Pass body to CustomRefreshIndicator
      ),
    );
  }
}

 */

/*
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RefreshPuller extends StatelessWidget {
  const RefreshPuller({super.key});

  final _offsetToArmed = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffCFEFF8),
        body: CustomRefreshIndicator(
          onRefresh: () => Future.delayed(const Duration(seconds: 2)),
          offsetToArmed: _offsetToArmed,
          builder: (context, child, controller) => AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    child: const RiveAnimation.asset(
                      "assets/RiveAssets/help!.riv",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                      offset: Offset(
                    0.0,
                    _offsetToArmed * controller.value,
                  ))
                ],
              );
            },
          ),
          child: Container(
            color: Colors.black,
            width: 200,
            height: 200,
          ),
        ));
  }
}


 */