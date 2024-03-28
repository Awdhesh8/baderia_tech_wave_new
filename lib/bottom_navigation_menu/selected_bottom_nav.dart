import 'package:get/get.dart';
import '../model/menu.dart';
import '../model/rive_model.dart'; // Import the model file where Menu is defined

Rx<Menu> selectedBtmNav = Menu(
  title: "", // Initialize with a default title or choose the initial item
  rive: RiveModel(src: "", artboard: "", stateMachineName: ""),
).obs;
