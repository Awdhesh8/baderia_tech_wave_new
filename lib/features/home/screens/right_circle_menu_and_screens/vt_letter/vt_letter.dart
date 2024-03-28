import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_history.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class VTLetter extends StatelessWidget {
  const VTLetter({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? Colors.black : EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Vocational Training',
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              /// Top heading
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Ignite Your Journey',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' with '),
                        TextSpan(
                          text: '\nVocational Excellence!',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: ESizes.spaceBtwSections),

              /// VT Letter Form
              VTLetterForm(),
              const SizedBox(height: ESizes.spaceBtwSections),
              const Divider(),

              /// history heading
              /*Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Check History Status',
                      style: TextStyleClass.inputText1,
                      children: [
                        TextSpan(text: ' for '),
                        TextSpan(
                          text: '\nVT Application',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),


                ],
              ),

               */

              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: EColors.backgroundColor,
                  ),
                  child: VtletterHistory(),
                ),
              ),

              ///
              // MyApp()
            ],
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize your controller
//     final ToggleController controller = Get.put(ToggleController());
//
//     return
//
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Obx widget listens to changes in the toggle state
//             Obx(
//                   () => controller.isContainerVisible.value
//                   ? Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container is visible!',
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                 ),
//               )
//                   : Container(), // Empty container when not visible
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Toggle the container visibility
//                 controller.toggleContainerVisibility();
//               },
//               child: Text('Toggle Container'),
//             ),
//           ],
//         )
//
//     ;
//   }
// }
//
// // Define a controller class extending GetxController
// class ToggleController extends GetxController {
//   // Define the state variable for toggle
//   var isContainerVisible = false.obs;
//
//   // Method to toggle the container visibility
//   void toggleContainerVisibility() {
//     isContainerVisible.value = !isContainerVisible.value;
//   }
//
// }