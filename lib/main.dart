import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/routes_pages_navigation/named_routes_screens.dart';
import 'controllers/user_controller_login_check/user_controller.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baderia Engineering',
       theme: lightTheme,
      // darkTheme: darkTheme,
      //themeMode: ThemeMode.system, // Use system theme mode
      initialRoute: AppRoutes.splash, // The initial route
      getPages: AppRoutes.routes,
      // home: const SplashScreen(),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Intel",
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    errorStyle: TextStyle(height: 0),
    border: defaultInputBorder,
    enabledBorder: defaultInputBorder,
    focusedBorder: defaultInputBorder,
    errorBorder: defaultInputBorder,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "Intel",
  brightness: Brightness.dark,
  // Define your dark theme properties here
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.black,
    errorStyle: TextStyle(height: 0),
    border: defaultInputBorder,
    enabledBorder: defaultInputBorder,
    focusedBorder: defaultInputBorder,
    errorBorder: defaultInputBorder,
  ),
);

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);




/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/routes_pages_navigation/named_routes_screens.dart';
import 'package:baderia_tech_wave/utils/theme/theme.dart';
import 'controllers/user_controller_login_check/user_controller.dart';
import 'features/authentication/screens/splash_screen/splash_screen.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',

      theme: ThemeData(


        useMaterial3: true,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      initialRoute: AppRoutes.splash, // The initial route
      getPages: AppRoutes.routes,
      // home: const SplashScreen(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

*/
