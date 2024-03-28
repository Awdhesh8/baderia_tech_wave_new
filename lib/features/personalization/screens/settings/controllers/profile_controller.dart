// import 'package:get/get.dart';
//
// class ProfileController extends GetxController {
//   RxString imagePath = ''.obs;
//   RxString contactNumber = ''.obs;
//   RxString email = ''.obs;
//   RxString bloodGroup = ''.obs;
//   RxString selectedBloodGroupId = ''.obs;
//   // var bloodGroup = ''.obs;
//
//   RxString samaraId = ''.obs;
//   RxString laptop = ''.obs;
//   RxString laptopBrand = ''.obs;
//   RxString laptopRam = ''.obs;
//   RxString laptopProcessor = ''.obs;
//   RxString laptopConfig = ''.obs;
//
//
// }
import 'package:get/get.dart';

import '../edit_profile/edit_Profile.dart';

class ProfileController extends GetxController {
  RxString imagePath = ''.obs;
  RxString contactNumber = ''.obs;
  RxString email = ''.obs;
  RxString bloodGroup = ''.obs;

  // Add selectedBloodGroup
  Rx<BloodGroup?> selectedBloodGroup = Rx<BloodGroup?>(null);

  RxString samaraId = ''.obs;
  RxString laptop = ''.obs;
  RxString laptopBrand = ''.obs;
  RxString laptopRam = ''.obs;
  RxString laptopProcessor = ''.obs;
  RxString laptopConfig = ''.obs;
}
