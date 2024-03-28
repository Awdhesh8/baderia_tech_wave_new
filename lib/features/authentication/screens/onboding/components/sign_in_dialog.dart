import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'sign_in_form.dart';

void showCustomDialog(BuildContext context, {required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 30),
                      blurRadius: 60,
                    ),
                    const BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 30),
                      blurRadius: 60,
                    ),
                  ],
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  // backgroundColor: Colors.transparent,
                  body: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const SingleChildScrollView(
                        child: Column(
                          children: [

                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 34,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Explore diverse courses, and shape your academic journey with Global College. Let's embark on this educational adventure together!.",
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SignInForm(),
                          ],
                        ),
                      ),
                      Positioned(
                        // top: 20,
                        bottom: -68,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              // color: Colors.purpleAccent,
                              width: MediaQuery.of(context).size. width/1.3,
                              alignment: Alignment.bottomCenter,
                              // padding: const EdgeInsets.only(bottom: 48),
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      }

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
        // child: child,
      );
    },
  ).then(onValue);
}
