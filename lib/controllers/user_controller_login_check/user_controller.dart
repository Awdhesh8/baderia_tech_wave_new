import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  RxBool isLoggedIn = false.obs;

  Future<void> init() async {
    // Initialize user status from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  void login(Map<String, dynamic> userData) async {
    isLoggedIn.value = true;

    // Save user information to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('user_id', userData['user_id']);
    prefs.setString('user_type', userData['user_type']);
    prefs.setString('emp_id', userData['emp_id']);
  }


  // void login() async {
  //   isLoggedIn.value = true;
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isLoggedIn', true);
  // }

  void logout() async {
    // Clear user session
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Update isLoggedIn status
    isLoggedIn.value = false;
  }

  bool checkLogin() {
    return isLoggedIn.value;
  }
}
