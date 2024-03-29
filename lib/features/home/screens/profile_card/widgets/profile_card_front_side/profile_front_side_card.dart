import 'package:flutter/material.dart';
import '../../../../../../common/widgets/custom_shapes/containers/circular_contanier.dart';
import '../../../../../../utils/constants/colors.dart';

class UserProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String branch;
  final String courseType;
  final String enroll;

  const UserProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.branch,
    required this.courseType,
    required this.enroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Custom Shapes
        const Positioned(
          top: -5,
          left: -50,
          width: 190,
          height: 150,
          child: ECircularContainer(
            backgroundColor: EColors.white,
          ),
        ),
        const Positioned(
          top: 18,
          right: -10,
          width: 190,
          height: 22,
          child: ECircularContainer(
            backgroundColor: EColors.circleAvatar,
          ),
        ),
        const Positioned(
          bottom: -15,
          right: 0,
          width: 55,
          height: 50,
          child: ECircularContainer(
            backgroundColor: EColors.primary,
          ),
        ),
        const Positioned(
          top: 7,
          left: -47,
          width: 170,
          height: 125,
          child: ECircularContainer(
            backgroundColor: EColors.circleAvatar,
          ),
        ),
        Positioned(
          left: 7,
          top: 20,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              )
                  : Container(), // Handle the case when imageUrl is empty
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 20,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          color: EColors.textPrimary,
                          // color: EColors.textPrimary,
                          fontFamily: 'Inter',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        enroll,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          // color: EColors.textColorPrimary1,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "Branch: $branch",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          // color: EColors.textColorPrimary1,
                          fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        'Course Type: $courseType',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          // color: EColors.textColorPrimary1,
                          fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Small container with text
        Positioned(
          bottom: 0,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(6),
            // decoration: const BoxDecoration(
            //   // color: EColors.white,
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(10),
            //     bottomRight: Radius.circular(10),
            //   ),
            // ),
            child: const Text(
              'Tap',
              style: TextStyle(
                color: EColors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



/*
import 'package:flutter/material.dart';
import '../../../../../../common/widgets/custom_shapes/containers/circular_contanier.dart';
import '../../../../../../utils/constants/colors.dart';

class UserProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String branch;
  final String courseType;
  final String enroll;

  const UserProfileWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.branch,
    required this.courseType,
    required this.enroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Custom Shapes
        const Positioned(
          top: -35,
          left: -60,
          width: 200,
          height: 200,
          child: ECircularContainer(
            backgroundColor: EColors.white,
          ),
        ),
        const Positioned(
          top: -20,
          left: -50,
          width: 170,
          height: 170,
          child: ECircularContainer(
            backgroundColor: EColors.circleAvatar,
          ),
        ),
        Positioned(
          left: 7,
          top: 12,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              )
                  : Container(), // Handle the case when imageUrl is empty
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          color: EColors.textPrimary,
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        enroll,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "Branch: $branch",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        'Course Type: $courseType',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: EColors.textColorPrimary1,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Small container with text
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: EColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Text(
              'Tap',
              style: TextStyle(
                color: EColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

 */



/// original code -->>>
// import 'package:flutter/material.dart';
// import '../../../../../../common/widgets/custom_shapes/containers/circular_contanier.dart';
// import '../../../../../../utils/constants/colors.dart';
//
// class UserProfileWidget extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String branch;
//   final String courseType;
//   final String enroll;
//
//   const UserProfileWidget({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.branch,
//     required this.courseType,
//     required this.enroll,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background Custom Shapes
//         const Positioned(
//           top: -35,
//           left: -60,
//           width: 200,
//           height: 200,
//           child: ECircularContainer(
//             backgroundColor: EColors.white,
//           ),
//         ),
//         const Positioned(
//           top: -20,
//           left: -50,
//           width: 170,
//           height: 170,
//           child: ECircularContainer(
//             backgroundColor: EColors.circleAvatar,
//           ),
//         ),
//         Positioned(
//           left: 7,
//           top: 12,
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(100),
//               border: Border.all(
//                 color: Colors.white,
//                 width: 4,
//               ),
//             ),
//             child:
//
//                 // ClipRRect(
//                 //   borderRadius: BorderRadius.circular(100),
//                 //   child: imageUrl.isNotEmpty
//                 //       ? (imageUrl.startsWith('http')
//                 //       ? Image.network(
//                 //     imageUrl,
//                 //     width: double.infinity,
//                 //     height: double.infinity,
//                 //     fit: BoxFit.cover,
//                 //   )
//                 //       : Image.asset(
//                 //     imageUrl,
//                 //     width: double.infinity,
//                 //     height: double.infinity,
//                 //     fit: BoxFit.cover,
//                 //   ))
//                 //       : Container(), // Handle the case when imageUrl is empty
//                 // ),
//                 ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(), // Handle the case when imageUrl is empty
//             ),
//           ),
//         ),
//         //       child: Image.asset(
//         //         imageUrl,
//         //         width: double.infinity,
//         //         height: double.infinity,
//         //         fit: BoxFit.cover,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             padding: const EdgeInsets.only(right: 15),
//             alignment: Alignment.centerRight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         name,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: true,
//                         style: const TextStyle(
//                           color: EColors.textColorPrimary1,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 7),
//                       Text(
//                         enroll,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: EColors.white,
//                           fontSize: 10,
//                         ),
//                       ),
//                       Text(
//                         branch,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: EColors.white,
//                           fontSize: 10,
//                         ),
//                       ),
//                       Text(
//                         'Course Type: $courseType',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: EColors.white,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // Small container with text
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: Container(
//             padding: const EdgeInsets.all(6),
//             decoration: const BoxDecoration(
//               color: EColors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10),
//               ),
//             ),
//             child: const Text(
//               'Tap',
//               style: TextStyle(
//                 color: EColors.primary,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /*
//   Widget buildFront() {
//     double containerWidth = MediaQuery.of(context).size.width * 0.9;
//
//     return Column(
//       children: [
//         Container(
//           width: containerWidth,
//           height: 125,
//           decoration: BoxDecoration(
//             color: EColors.primarySecond,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(0, 0),
//                 blurRadius: 10,
//                 color: Colors.black12,
//               )
//             ],
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             padding: const EdgeInsets.all(0),
//             child: Stack(
//               children: [
//                 // Background Custom Shapes
//                 const Positioned(
//                   top: -35,
//                   left: -60,
//                   width: 200,
//                   height: 200,
//                   child: ECircularContainer(
//                     backgroundColor: EColors.white,
//                   ),
//                 ),
//                 const Positioned(
//                   top: -20,
//                   left: -50,
//                   width: 170,
//                   height: 170,
//                   child: ECircularContainer(
//                     backgroundColor: EColors.circleAvatar,
//                   ),
//                 ),
//                 Positioned(
//                   left: 7,
//                   top: 12,
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 4,
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: Image.asset(
//                         'assets/avaters/Avatar 6.jpg',
//                         width: double.infinity,
//                         height: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     padding: const EdgeInsets.only(right: 15),
//                     alignment: Alignment.centerRight,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Surya Pratap Singh',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: true,
//                                 style: TextStyle(
//                                   color: EColors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 'Branch: Computer Science Enggerring ',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: EColors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 'Course Type: Bachelor',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: EColors.white,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Small container with text
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: EColors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: const Text(
//                       'See more',
//                       style: TextStyle(
//                         color: EColors.primary,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// */