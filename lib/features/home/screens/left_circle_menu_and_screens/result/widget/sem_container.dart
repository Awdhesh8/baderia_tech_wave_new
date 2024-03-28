// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/utils/constants/sizes.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../../common/widgets/animations/animation_class.dart';
// import '../../../../../../common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
// import '../../../../../../utils/constants/colors.dart';
// import '../model/model.dart';
// import '../sem_details.dart';
//
// class SemContainer extends StatelessWidget {
//   const SemContainer({
//     super.key,
//     required this.result,
//   });
//
//   final AcademicResult result;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: CustomDeco.decoRectangle(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ///
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 12, vertical: 3),
//                   child: Text(
//                     result.semester,
//                     style: const TextStyle(
//                         fontFamily: 'Inter',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: EColors.textColorPrimary1),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: ESizes.spaceBtwItemsHeadings),
//
//           /// Final Button
//           Padding(
//             padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: CustomAnimatedButton(
//                     onNavigate: () {
//                       Get.to(() => SemesterDetail(
//                             semester: result.semester,
//                             universitySubjects: result.universitySubjects,
//                             midtermSubjects: result.midtermSubjects,
//                             practicalSubjects: result.practicalSubjects,
//                             isUniversityTab: true,
//                           ),
//                           transition: Transition.cupertino,
//                           duration: Duration(milliseconds: 500)
//                       );
//                     },
//                     buttonColor: Colors.white,
//                     borderRadius: 50,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//                     height: 35,
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Final Exam',
//                           style: TextStyle(
//                             fontFamily: 'Inter',
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: EColors.textColorPrimary1,
//                           ),
//                         ),
//                         Icon(
//                           Iconsax.arrow_right_3,
//                           color: EColors.primary,
//                           size: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//
//           /// Mid Term Button
//           Padding(
//             padding: const EdgeInsets.only(left: 15, top: 2, right: 15),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: CustomAnimatedButton(
//                       onNavigate: () {
//                         Get.to(() => SemesterDetail(
//                               semester: result.semester,
//                               universitySubjects: result.universitySubjects,
//                               midtermSubjects: result.midtermSubjects,
//                               practicalSubjects: result.practicalSubjects,
//                               isUniversityTab: false,
//                             ),
//                           transition: Transition.cupertino,
//                           duration: Duration(milliseconds: 500)
//                         );
//                       },
//                       buttonColor: Colors.white,
//                       borderRadius: 50,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 2),
//                       height: 35,
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Mid Term',
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12,
//                               color: EColors.textColorPrimary1,
//                             ),
//                           ),
//                           Icon(
//                             Iconsax.arrow_right_3,
//                             color: EColors.primary,
//                             size: 20,
//                           ),
//                         ],
//                       )),
//                 )
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
