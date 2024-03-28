import 'package:get/get.dart';

class LeaveFormController extends GetxController {
  RxString fromController = ''.obs;
  RxString toController = ''.obs;
  RxString reasonController = ''.obs;
  RxBool reasonError = false.obs;
  RxBool toError = false.obs;
  RxBool fromError = false.obs;

  // RxList to store the history of leave applications
  RxList<String> leaveHistory = <String>[].obs;


}
