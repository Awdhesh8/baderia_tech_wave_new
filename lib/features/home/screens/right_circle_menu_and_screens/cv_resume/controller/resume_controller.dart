import 'package:get/get.dart';

class CVResumeController extends GetxController {
  RxList<String> selectedChips = <String>[].obs;
  List<String> cvInputs = [
    'Name',
    'Surname',
    'Skills',
    'Certificates',
    // Add more as needed
  ];

  void addChip(String chip) {
    selectedChips.add(chip);
  }

  void removeChip(String chip) {
    selectedChips.remove(chip);
  }
  void toggleChip(String chip) {
    if (selectedChips.contains(chip)) {
      selectedChips.remove(chip);
    } else {
      selectedChips.add(chip);
    }
  }
}
