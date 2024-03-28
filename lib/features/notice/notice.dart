import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? EColors.black : EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Notice',
          style: TextStyle(
            fontSize: ESizes.appTitle,
            fontFamily: 'Inter',
            color: EColors.textSecondaryTitle,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/Backgrounds/sammy-remote-work.gif',
                    width: 220,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'This screen is under development,',
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: EColors.textSecondaryTitle,
                      ),
                    ),
                    TyperAnimatedText(
                      'but stay tuned for exciting updates!',
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: EColors.textSecondaryTitle,
                      ),
                    ),
                    TyperAnimatedText(
                      'We\'re working hard to bring you the best experience.',
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.green,
                      ),
                    ),
                    // WavyAnimatedText(
                    //   'On Your Marks',
                    //   textStyle: const TextStyle(
                    //     fontSize: 24.0,
                    //   ),
                    // ),
          // FlickerAnimatedText(
          //             'On Your Marks',
          //             textStyle: const TextStyle(
          //               fontSize: 24.0,
          //             ),
          //           ),
                    // FadeAnimatedText(
                    //   'Get Set',
                    //   textStyle: const TextStyle(
                    //     fontSize: 32.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // ScaleAnimatedText(
                    //   'Ready',
                    //   textStyle: const TextStyle(
                    //     fontSize: 48.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // RotateAnimatedText(
                    //   'Go!',
                    //   textStyle: const TextStyle(
                    //     fontSize: 64.0,
                    //   ),
                    //   rotateOut: true,
                    //   duration: const Duration(milliseconds: 400),
                    // )
                  ],
                  isRepeatingAnimation: false,
                  totalRepeatCount: 2,
                ),
              ],

              /*
            Container(
              decoration: ShapeDecoration(
                color:  darkMode ? EColors.black : EColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                  const BoxShadow(
                    color: Colors.white12,
                    spreadRadius: .5,
                    blurRadius: 4,
                    offset: Offset(-2, -2),
                  ),

                ],

              ),
              child:
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Notification Heading',
                                  style: TextStyle(
                                    color: EColors.textPrimaryHeading,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ESizes.spaceBtwItemsHeadings,),
                            Text(
                              'Description: Description is any type of communication that aims to make vivid a place, object, person, group, or other physical entity.',
                              style: TextStyle(
                                color: EColors.textSecondaryTitle,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '14 Jan 2024\n11:45 AM',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF686868),
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                */

              ),
            */
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../../common/widgets/appbar/appbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? EColors.black : EColors.backgroundColor,
      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent ,
        showBackArrow: false,
        title: Text(
          'Notice',
          style: TextStyle(
              fontSize: ESizes.appTitle,
              fontFamily: 'Inter',
              color: EColors.primary,
              fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              /// Notification Card For Text only

              Container(
                // width: 373,
                // height: 179,
                decoration: ShapeDecoration(
                  color:  darkMode ? EColors.black : EColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                    const BoxShadow(
                      color: Colors.white12,
                      spreadRadius: .5,
                      blurRadius: 4,
                      offset: Offset(-2, -2),
                    ),

                  ],

                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Notification Heading',
                                    style: TextStyle(
                                      color: EColors.textPrimaryHeading,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ESizes.spaceBtwItemsHeadings,),
                              Text(
                                'Description: Description is any type of communication that aims to make vivid a place, object, person, group, or other physical entity.',
                                style: TextStyle(
                                  color: EColors.textSecondaryTitle,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '14 Jan 2024\n11:45 AM',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF686868),
                          fontSize: 8,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


 */
