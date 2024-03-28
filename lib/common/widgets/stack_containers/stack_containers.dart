
import 'package:flutter/material.dart';

class StackContainer extends StatelessWidget {
  final Widget? child;
  const StackContainer({
    super.key, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Transform.rotate(
                angle: .08,
                child: Container(
                  height: 162,
                  // width: 310,
                  decoration: ShapeDecoration(
                    // color:  EColors.white,
                    // color: Colors.white60,
                    color: Colors.red.shade100.withOpacity(.4),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),

                  // color: Colors.blue.shade50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7,),
              child: Transform.rotate(
                angle: - .08,
                child: Container(
                  height: 162,
                  decoration: ShapeDecoration(
                    //color: EColors.primarySecond,
                    // color: Colors.white60,
                    color: Colors.red.shade100.withOpacity(.4),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  // width: 310,
                  //color: Colors.orange.shade800,
                  //color: Colors.blue.shade100,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}