//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../screens/login/login.dart';
//
// class OnBoardingController extends GetxController {
//   static OnBoardingController get instance => Get.find();
//
//   // variables
//   final pageController = PageController();
//   Rx<int> currentPageIndex = 0.obs;
//
//   // Update current Index when page Scroll
//   void updatePageIndicator(index) => currentPageIndex.value = index;
//
//   // Jump to the specific dot selected page
//   void dotNavigationClick(index) {
//     currentPageIndex.value = index;
//     pageController.jumpTo(index);
//   }
//
//   // Update current Index & Jump to next page
//   void nextPage() {
//     if (currentPageIndex.value == 2){
//        Get.to(const LoginScreen());
//     } else {
//       int page = currentPageIndex.value + 1;
//       pageController.jumpToPage(page);
//     }
//   }
//
//   // Update Current Index & Jump to the last page
//   void skipPage() {
//     currentPageIndex.value = 2;
//     pageController.jumpToPage(2);
//   }
//
// }


/*
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current Index when page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current Index & Jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2){
      Get.to(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Update Current Index & Jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

}

 */