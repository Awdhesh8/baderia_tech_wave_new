// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../onboding/onboding_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Set a timer to navigate to the next screen after 3 seconds
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => const OnbodingScreen()));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Your logo image
//             Image.asset(
//               'assets/logo/splash_screen_logo.png',
//               width: 220, // Adjust the width as needed
//               height: 220, // Adjust the height as needed
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/bottom_navigation_menu/navigation_menu.dart';
import 'package:baderia_tech_wave/controllers/user_controller_login_check/user_controller.dart';
import 'package:baderia_tech_wave/features/authentication/screens/onboding/onboding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkAuthentication();
    });
  }


  void checkAuthentication() async {
    // Uncomment the next line if you want to simulate a logged-in user
    // userController.login();

    // Wait for preferences to load
    WidgetsFlutterBinding.ensureInitialized();
    await userController.init();

    if (userController.checkLogin()) {
      // If logged in, navigate to NavigationMenu
      Get.off(() => NavigationMenu());
    } else {
      // If not logged in, navigate to OnbodingScreen
      Get.off(() => OnbodingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo image
            Image.asset(
              'assets/logo/splash_screen_logo.png',
              width: 220, // Adjust the width as needed
              height: 220, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}





