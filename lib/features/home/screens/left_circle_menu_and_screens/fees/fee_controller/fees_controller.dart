import 'package:get/get.dart';

class FeesController extends GetxController {
  var isFeesVisible = false.obs;

  void showFees() {
    isFeesVisible.value = true;
  }

  void hideFees() {
    isFeesVisible.value = false;
  }
}
