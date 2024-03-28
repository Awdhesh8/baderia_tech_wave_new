import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/user_controller_login_check/user_controller.dart';
import '../../../../routes_pages_navigation/named_routes_screens.dart';

class CheckLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    // Simulate a delay for login status check (replace with actual logic)
    Future.delayed(Duration(seconds: 2), () {
      // Redirect based on the user's login status
      userController.isLoggedIn.value
          ? Get.offAllNamed(AppRoutes.defaultScreen)
          : Get.offAllNamed(AppRoutes.splash);
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
