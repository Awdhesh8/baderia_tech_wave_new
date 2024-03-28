// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../controllers/profile_controller.dart';
//
// class _LaptopSwitch extends StatefulWidget {
//   @override
//   _LaptopSwitchState createState() => _LaptopSwitchState();
// }
//
// class _LaptopSwitchState extends State<_LaptopSwitch> {
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: Get.find<ProfileController>().hasLaptop.value,
//       onChanged: (value) {
//         Get.find<ProfileController>().toggleLaptop(value);
//         setState(() {}); // Trigger a rebuild
//       },
//     );
//   }
// }
//
// Widget _buildLaptopSection() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           const Text('Do you have a Laptop?'),
//           const SizedBox(width: 16),
//           _LaptopSwitch(),
//         ],
//       ),
//       if (Get.find<ProfileController>().hasLaptop.value) ...[
//         _buildTextField('Laptop Brand', Get.find<ProfileController>().laptopBrand),
//         _buildTextField('Laptop RAM', Get.find<ProfileController>().laptopRam),
//         _buildTextField('Laptop Processor', Get.find<ProfileController>().laptopProcessor),
//         _buildTextField('Laptop Configuration', Get.find<ProfileController>().laptopConfig),
//       ],
//     ],
//   );
// }
