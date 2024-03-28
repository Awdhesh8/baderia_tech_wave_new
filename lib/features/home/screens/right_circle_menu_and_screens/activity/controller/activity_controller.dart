import 'package:get/get.dart';

class ActivityController extends GetxController {
  final selectedIndex = 0.obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
