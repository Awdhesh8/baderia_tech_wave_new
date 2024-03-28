import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../../common/widgets/feesContanier/position_contanier.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../library/e_library/book_widget/e_book_widget.dart';

class FeesCard extends StatefulWidget {
  const FeesCard({
    super.key,
  });
// check this out
  @override
  State<FeesCard> createState() => _FeesCardState();
}

class _FeesCardState extends State<FeesCard> {

  Map<String, dynamic> summaryData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Map<String, dynamic> response = await ApiService.fetchFeeSummary();
      if (response.containsKey('summary')) {
        setState(() {
          summaryData = response['summary'][0];
        });
      } else {
        throw Exception("Summary data not found in the response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child:
      summaryData.isEmpty
          ? ShimmerFeesCard()
          :
      AnimationWidget(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        animationType: 'scale',
        child: Column(
          children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                    color: EColors.backgroundColor,
                    // borderRadius: BorderRadius.circular(15),
                    shadows: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(-3, -3),
                      ),
                    ],
                  ),
                // decoration: ShapeDecoration(
                //   color: EColors.white,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(21),
                //   ),
                //   shadows: const [
                //     BoxShadow(
                //       color: Color(0x26000000),
                //       blurRadius: 10.90,
                //       offset: Offset(0, 0),
                //       spreadRadius: 0,
                //     )
                //   ],
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              // decoration: const BoxDecoration(
                              //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(0), topLeft: Radius.circular(12))
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(FontAwesomeIcons.moneyCheck, color: Colors.pinkAccent, size: 40,),
                                  Row(
                                    children: [
                                      DownloadButton(
                                        onPressed: () {},
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            shape: ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            color: EColors.backgroundColor,
                                            // borderRadius: BorderRadius.circular(15),
                                            shadows: [
                                              BoxShadow(
                                                color: Colors.red.withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 4,
                                                offset: const Offset(2, 2),
                                              ),
                                              const BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(-3, -3),
                                              ),
                                            ],
                                          ),
                                          child: Shimmer.fromColors(
                                            baseColor: EColors.primary,
                                            highlightColor: EColors.primarySecond,
                                            child: IconButton( onPressed: () =>
                                                Get.to(() =>
                                                    FeesScreen(),
                                                  transition: Transition.cupertino,
                                                  duration: const Duration(milliseconds: 500),
                                                ), icon: const Icon(Iconsax.element_equal),
                                              highlightColor: EColors.primarySecond,
                                            ),
                                            // child: const Icon(FontAwesomeIcons.ellipsisVertical, size: 20,),
                                            // child: const Icon(FontAwesomeIcons.arrowRight, size: 20,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      /// Balance Fees & Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            Text(
                              'Current Sem: ${summaryData["currentsem"]}',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: EColors.textColorPrimary1,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 00),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${summaryData["tbal"].toString()}.00",
                                  // textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: EColors.textColorPrimary1,
                                    fontSize: 32,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(FontAwesomeIcons.indianRupeeSign, color: Colors.black12, size: 50,),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    child: Shimmer.fromColors(
                                      baseColor: EColors.primary,
                                      highlightColor: EColors.primarySecond,
                                      child: Text(
                                        '${summaryData["comit_remark"]}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: EColors.primary,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            overflow:TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}


/// Shimmer Box --->>>
class ShimmerFeesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        width: double.infinity,
        height: 160, // Set the height based on your card's content
        decoration: ShapeDecoration(
          color: EColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.90,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
      ),
    );
  }
}

/// Correct Fees Card
/*
class FeesCard extends StatefulWidget {
  const FeesCard({
    super.key,
  });

  @override
  State<FeesCard> createState() => _FeesCardState();
}

class _FeesCardState extends State<FeesCard> {

  Map<String, dynamic> summaryData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Map<String, dynamic> response = await ApiService.fetchFeeSummary();
      if (response.containsKey('summary')) {
        setState(() {
          summaryData = response['summary'][0];
        });
      } else {
        throw Exception("Summary data not found in the response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child:
      summaryData.isEmpty
          ? ShimmerFeesCard()
          :
      Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: EColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.90,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: EColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 10.90,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    /// Commitment Text
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              // decoration: const BoxDecoration(
                              //     color: EColors.circleAvatar,
                              //     borderRadius: BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(FontAwesomeIcons.creditCard),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: EColors.circleAvatar,
                                          borderRadius: BorderRadius.all(Radius.circular(12))),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                        child: Row(
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: EColors.primary,
                                              highlightColor: EColors.primarySecond,
                                              child: Text(
                                                '${summaryData["comit_remark"]}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: EColors.primary,
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    overflow:TextOverflow.ellipsis
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
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Balance Fees & Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Current Sem: ${summaryData["currentsem"]}',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: EColors.textColorPrimary1,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${summaryData["tbal"].toString()}.00",
                                // textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: EColors.textColorPrimary1,
                                  fontSize: 32,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // const Text(
                              //   '(Rest Amt)',
                              //   // textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     color: EColors.textColorPrimary1,
                              //     fontSize: 8,
                              //     fontFamily: 'Inter',
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                            ],
                          ),
                          const Icon(FontAwesomeIcons.indianRupeeSign, color: Colors.amber, size: 40,),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: ESizes.spaceBtwItems,
                    ),
                  ],
                )
              ),
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        // color: EColors.circleAvatar,
                        // color: Color(0xFF9D0D11),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(0), topLeft: Radius.circular(12))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          InkWell(
                            onTap: () =>
                                Get.to(() =>
                                 FeesScreen(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(milliseconds: 500),
                                ),

                            child: Row(
                              children: [
                                /*
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child:
                                  AnimatedTextKit(
                                    totalRepeatCount: 1,
                                    animatedTexts: [
                                      TyperAnimatedText('View more?',
                                          textStyle: const TextStyle(
                                                color: EColors.textColorPrimary1,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                          )),
                                      TyperAnimatedText('Tap Here....',
                                          textStyle: const TextStyle(
                                                color: EColors.textColorPrimary1,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),

                                  // Text(
                                  //   'View Details',
                                  //   style: TextStyle(
                                  //     color: EColors.textColorPrimary1,
                                  //     fontSize: 12,
                                  //     fontFamily: 'Inter',
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),

                                ),

                                 */
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                      color: EColors.textColorPrimary1,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: EColors.primary,
                                highlightColor: EColors.primarySecond,
                                child: const Icon(FontAwesomeIcons.arrowRight, size: 20,),
                                ),

                              ],
                            ),
                          ),

                          // const Icon(Iconsax.arrow_right_14, color: Colors.black54, size: 18,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
 */

///
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
// import 'package:baderia_tech_wave/utils/constants/sizes.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../../utils/constants/colors.dart';
//
// class FeesCard extends StatelessWidget {
//   const FeesCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
//       child: Container(
//         width: double.infinity,
//         decoration: ShapeDecoration(
//           color: EColors.backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(21),
//           ),
//           shadows: const [
//             BoxShadow(
//               color: Color(0x26000000),
//               blurRadius: 10.90,
//               offset: Offset(0, 0),
//               spreadRadius: 0,
//             )
//           ],
//         ),
//         child: Column(
//           children: [
//             /// Commitment Text
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       // decoration: const BoxDecoration(
//                       //     color: EColors.circleAvatar,
//                       //     borderRadius: BorderRadius.all(Radius.circular(12))),
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Icon(FontAwesomeIcons.amazonPay),
//                             Container(
//                               decoration: const BoxDecoration(
//                                   color: EColors.circleAvatar,
//                                   borderRadius: BorderRadius.all(Radius.circular(12))),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Commitment : 20000+ Scholarship Per Year',
//                                   style: TextStyle(
//                                     overflow: TextOverflow.ellipsis,
//                                     color: EColors.textColorPrimary1,
//                                     fontSize: 10,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               child: Row(
//                                 children: [
//                                   // Padding(
//                                   //   padding: EdgeInsets.only(right: 5),
//                                   //   child: Text('More',
//                                   //     style: TextStyle(
//                                   //       overflow: TextOverflow.ellipsis,
//                                   //       color: EColors.textColorPrimary1,
//                                   //       fontSize: 10,
//                                   //       fontFamily: 'Inter',
//                                   //       fontWeight: FontWeight.w600,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   Icon(Iconsax.menu),
//                                 ],
//                               ),
//                             ),
//                             /*
//                             Expanded(
//                               child:
//
//                               Text(
//                                 'Commitment : 20000+ Scholarship Per Year',
//                                 style: TextStyle(
//                                   overflow: TextOverflow.ellipsis,
//                                   color: EColors.textColorPrimary1,
//                                   fontSize: 13,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                               ),
//                             ),
//                             */
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // const SizedBox(height: 4),
//             // const SizedBox(height: ESizes.spaceBtwItems,),
//
//             /// Balance Fees & Text
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Text(
//                     'Balance Fees  ( 7 Semester )',
//                     style: TextStyle(
//                       overflow: TextOverflow.ellipsis,
//                       color: EColors.textColorPrimary1,
//                       fontSize: 12,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                   ),
//                 ],
//               ),
//             ),
//
//             // const SizedBox(height: ESizes.spaceBtwItems,),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: const Row(
//                 children: [
//                   Text(
//                     '1,10,159',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: EColors.textColorPrimary1,
//                       fontSize: 32,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(
//               height: ESizes.spaceBtwItems,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         color: Color(0xFF9D0D11),
//                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12),)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () =>
//                                 Get.to(() =>
//                                 const FeesScreen(),
//                                   transition: Transition.cupertino,
//                                   duration: const Duration(milliseconds: 500),
//                                 ),
//
//                             child: const Padding(
//                               padding: EdgeInsets.all(6.0),
//                               child: Text(
//                                 'View Details',
//                                 style: TextStyle(
//                                   color: EColors.white,
//                                   fontSize: 12,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                 ),
//
//                               ),
//                             ),
//                           ),
//                           const Icon(Iconsax.arrow_right_14, color: Colors.white, size: 18,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../utils/constants/colors.dart';

class FeesCard extends StatelessWidget {
  const FeesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: EColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.90,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            /// Commitment Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // decoration: const BoxDecoration(
                      //     color: EColors.circleAvatar,
                      //     borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(FontAwesomeIcons.amazonPay),
                            Container(
                              decoration: const BoxDecoration(
                                  color: EColors.circleAvatar,
                                  borderRadius: BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Commitment : 20000+ Scholarship Per Year',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: EColors.textColorPrimary1,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: 5),
                                  //   child: Text('More',
                                  //     style: TextStyle(
                                  //       overflow: TextOverflow.ellipsis,
                                  //       color: EColors.textColorPrimary1,
                                  //       fontSize: 10,
                                  //       fontFamily: 'Inter',
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                  Icon(Iconsax.menu),
                                ],
                              ),
                            ),
                            /*
                            Expanded(
                              child:

                              Text(
                                'Commitment : 20000+ Scholarship Per Year',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: EColors.textColorPrimary1,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                            */

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 4),
            // const SizedBox(height: ESizes.spaceBtwItems,),

            /// Balance Fees & Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Balance Fees  ( 7 Semester )',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: EColors.textColorPrimary1,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            // const SizedBox(height: ESizes.spaceBtwItems,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Row(
                children: [
                  Text(
                    '1,10,159',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: EColors.textColorPrimary1,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF9D0D11),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12),)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () =>
                                Get.to(() =>
                                const FeesScreen(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(milliseconds: 500),
                                ),

                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                  color: EColors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),

                              ),
                            ),
                          ),
                          const Icon(Iconsax.arrow_right_14, color: Colors.white, size: 18,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 */

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
// import 'package:baderia_tech_wave/utils/constants/sizes.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../../utils/constants/colors.dart';
//
// class FeesCard extends StatelessWidget {
//   const FeesCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
//       child: Container(
//         width: double.infinity,
//         decoration: ShapeDecoration(
//           color: EColors.backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           shadows: const [
//             BoxShadow(
//               color: Color(0x26000000),
//               blurRadius: 10.90,
//               offset: Offset(0, 0),
//               spreadRadius: 0,
//             )
//           ],
//         ),
//         child: Column(
//           children: [
//             /// Commitment Text
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       // decoration: const BoxDecoration(
//                       //     color: EColors.circleAvatar,
//                       //     borderRadius: BorderRadius.all(Radius.circular(12))),
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Icon(FontAwesomeIcons.amazonPay),
//                             Container(
//                               decoration: const BoxDecoration(
//                                   color: EColors.circleAvatar,
//                                   borderRadius: BorderRadius.all(Radius.circular(12))),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Commitment : 20000+ Scholarship Per Year',
//                                   style: TextStyle(
//                                     overflow: TextOverflow.ellipsis,
//                                     color: EColors.textColorPrimary1,
//                                     fontSize: 10,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               child: Row(
//                                 children: [
//                                   // Padding(
//                                   //   padding: EdgeInsets.only(right: 5),
//                                   //   child: Text('More',
//                                   //     style: TextStyle(
//                                   //       overflow: TextOverflow.ellipsis,
//                                   //       color: EColors.textColorPrimary1,
//                                   //       fontSize: 10,
//                                   //       fontFamily: 'Inter',
//                                   //       fontWeight: FontWeight.w600,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                   Icon(Iconsax.menu),
//                                 ],
//                               ),
//                             ),
//                             /*
//                             Expanded(
//                               child:
//
//                               Text(
//                                 'Commitment : 20000+ Scholarship Per Year',
//                                 style: TextStyle(
//                                   overflow: TextOverflow.ellipsis,
//                                   color: EColors.textColorPrimary1,
//                                   fontSize: 13,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                               ),
//                             ),
//                             */
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // const SizedBox(height: 4),
//             // const SizedBox(height: ESizes.spaceBtwItems,),
//
//             /// Balance Fees & Text
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                    Text(
//                      'Balance Fees  ( 7 Semester )',
//                      style: TextStyle(
//                        overflow: TextOverflow.ellipsis,
//                        color: EColors.textColorPrimary1,
//                        fontSize: 12,
//                        fontFamily: 'Inter',
//                        fontWeight: FontWeight.w600,
//                      ),
//                      textAlign: TextAlign.center,
//                      maxLines: 2,
//                    ),
//                 ],
//               ),
//             ),
//
//             // const SizedBox(height: ESizes.spaceBtwItems,),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: const Row(
//                 children: [
//                   Text(
//                     '1,10,159',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: EColors.textColorPrimary1,
//                       fontSize: 32,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(
//               height: ESizes.spaceBtwItems,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         color: Color(0xFF9D0D11),
//                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12),)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: () =>
//                             Get.to(() =>
//                               const FeesScreen(),
//                               transition: Transition.cupertino,
//                               duration: const Duration(milliseconds: 500),
//                             ),
//
//                             child: const Padding(
//                               padding: EdgeInsets.all(6.0),
//                               child: Text(
//                                 'View Details',
//                                 style: TextStyle(
//                                   color: EColors.white,
//                                   fontSize: 12,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w600,
//                                 ),
//
//                               ),
//                             ),
//                           ),
//                           const Icon(Iconsax.arrow_right_14, color: Colors.white, size: 18,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Original UI
/*

/// Original UI
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/fees_screen.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../utils/constants/colors.dart';

class FeesCard extends StatelessWidget {
  const FeesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: EColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10.90,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            /// Commitment Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: EColors.circleAvatar,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Commitment : 20000+ Scholarship Per Year',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: EColors.textColorPrimary1,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ESizes.spaceBtwItems,),

            /// Balance Fees & Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: EColors.primarySecond,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Balance Fees  ( 7 Semester )',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: EColors.white,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ESizes.spaceBtwItems,),

            const Row(
              children: [
                Text(
                  'Balance : 1,10,159',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF9D0D11),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12),)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () =>
                              Get.to(
                                const FeesScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              ),

                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                  color: EColors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),

                              ),
                            ),
                          ),
                          const Icon(Iconsax.arrow_right_14, color: Colors.white, size: 18,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


 */
