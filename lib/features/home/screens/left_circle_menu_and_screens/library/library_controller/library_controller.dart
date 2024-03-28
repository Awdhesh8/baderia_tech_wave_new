import 'package:get/get.dart';

class LibraryController extends GetxController {
  RxBool showScrollToTopButton = false.obs;

  void updateScrollButton(bool value) {
    showScrollToTopButton.value = value;
  }
}

final LibraryController libraryController = LibraryController();
