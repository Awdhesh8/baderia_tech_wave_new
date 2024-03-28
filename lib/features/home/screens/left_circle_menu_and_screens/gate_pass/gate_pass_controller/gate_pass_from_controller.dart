
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/gate_pass_form_widget/gate_pass_form.dart';

class GatePassFormController extends GetxController {
  RxString fromTimeController = ''.obs;
  RxString toTimeController = ''.obs;
  Rx<GatePassReason?> reasonController = Rx<GatePassReason?>(null);
  RxString goWithController = ''.obs;
  RxString remarkController = ''.obs;

  RxBool reasonError = false.obs;
  RxBool toError = false.obs;
  RxBool fromError = false.obs;
  RxBool goWithError = false.obs;
  RxBool remarkError = false.obs;

  var applicationText = ''.obs;
  //final TextEditingController reasonController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString selectedReason = ''.obs;

  // RxList to store the history of leave applications
  RxList<String> gatePassHistory = <String>[].obs;


  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

}
