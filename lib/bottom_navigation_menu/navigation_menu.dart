import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../features/home/screens/home_page.dart';
import '../features/home/screens/left_circle_menu_and_screens/attendance/attendance_screen.dart';
import '../features/notice/notice.dart';
import '../features/personalization/screens/settings/settings.dart';
import '../features/time_table/time_table.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        Color getIconColor(int index) {
          return controller.selectedIndex.value == index
              ? const Color(0xFFFE0037) // Selected icon color
              :  darkMode ?  Colors.white70 : EColors.white; // Unselected icon color
        }

        return WillPopScope(
          onWillPop: () async {
            return await _onBackPressed(context);
          },
          child: Scaffold(
            bottomNavigationBar: Obx(
              () => CurvedNavigationBar(
                height: 60,
                index: controller.selectedIndex.value,
                onTap: (index) => controller.selectedIndex.value = index,
                // backgroundColor: EColors.lightContainer1,
                backgroundColor: Colors.transparent,
                // color:  darkMode ? EColors.black : EColors.primarySecond,
                color:  darkMode ? EColors.black : EColors.primary,
                buttonBackgroundColor: Colors.transparent ,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 500),
                items: [
                  Icon(Iconsax.home, color: getIconColor(0)),
                  Icon(Iconsax.calendar_1, color: getIconColor(1)),
                  // Image.asset('assets/icons/attendance.png', width: 20),
                  // ImageIcon(AssetImage('assets/icons/attendance.png' ), ),
                   Icon(Iconsax.calendar_tick, color: getIconColor(2)),
                  // Icon(Iconsax.notification_favorite, color: getIconColor(2)),
                  Icon(Iconsax.user, color: getIconColor(3)),
                ],
              ),
            ),
            body: Obx(() => controller.screens[controller.selectedIndex.value]),
          ),
        );
      },
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Do you really want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);

              // Close the app using exit(0)
              exit(0);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const MyHomePage(),
    TimeTable(),
    AttendanceScreen(status: false,),
    // const Notice(),
    SettingsScreen(),
  ];
}


