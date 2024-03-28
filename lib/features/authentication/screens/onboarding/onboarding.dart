// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../utils/constants/image_strings.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../controllers/onboarding_controller.dart';
// import 'onboardingwidgets/onboarding_dot_navigation.dart';
// import 'onboardingwidgets/onboarding_next_button.dart';
// import 'onboardingwidgets/onboarding_page.dart';
// import 'onboardingwidgets/onboarding_skip.dart';
//
//
//
// class OnBoardingScreen extends StatelessWidget {
//   const OnBoardingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OnBoardingController());
//
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Horizontal scrollable pages
//
//           PageView(
//             controller: controller.pageController,
//             onPageChanged: controller.updatePageIndicator,
//             children:  const [
//               OnBoardingPage(
//                   image: EImages.delivery,
//                   title: ETexts.onBoardingTitle1,
//                   subTitle: ETexts.onBoardingSubTitle1
//               ),
//               OnBoardingPage(
//                   image: EImages.shopping,
//                   title: ETexts.onBoardingTitle2,
//                   subTitle: ETexts.onBoardingSubTitle2,
//               ),
//               OnBoardingPage(
//                   image: EImages.workflowSearch,
//                   title: ETexts.onBoardingTitle3,
//                   subTitle: ETexts.onBoardingSubTitle3,
//               ),
//             ],
//           ),
//
//
//           // Skip Button
//           const OnBoardingSkipButton(),
//
//
//           // Dot Navigation SmoothPage Indicator
//           const OnBoardingDotNavigation(),
//
//
//           // Circular Button
//           const OnBoardingNextButton(),
//
//
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
