// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../fee_controller/fees_controller.dart';
// import '../fees_screen.dart';
//
// class FeesContainer extends StatelessWidget {
//   final FeesController feesController = Get.put(FeesController());
//
//   FeesContainer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Visibility(
//         visible: feesController.isFeesVisible.value,
//         child: Container(
//           color: Colors.pinkAccent,
//           width: double.infinity,
//           height: double.infinity,
//         )
//       ),
//     );
//   }
// }
