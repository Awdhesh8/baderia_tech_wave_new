

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../feedback.dart';
import '../widgets/sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FeedbackFormController extends GetxController {
  var selectedTopic = ''.obs;
  var description = ''.obs;
  var rating = 0.0.obs; // Added rating variable
  var isSubmitted = false.obs;
  final TextEditingController textEditingController = TextEditingController();

  final descriptionValidator = Rx<TextEditingController?>(null);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return FeedbackBottomSheet(
          onSelectTopic: (String topic) {
            selectedTopic.value = topic;
            // Clear validation error if any
            descriptionValidator.value?.text = '';
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void submitFeedback(BuildContext context) {
    if (selectedTopic.value.isEmpty) {
      // Show snack bar for topic validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a topic')),
      );
      return;
    }

    if (description.value.isEmpty) {
      // Show snack bar for description validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter description')),
      );
      return;
    }

    // Implement your feedback submission logic here
    // For demonstration purposes, I'm just setting isSubmitted to true
    isSubmitted.value = true;

    // Navigate to SuccessScreen if feedback is submitted successfully
    if (isSubmitted.value) {
      Get.to(() => SuccessScreen(onGoBack: resetForm));
    }
  }

  void resetForm() {
    selectedTopic.value = '';
    description.value = '';
    rating.value = 0.0; // Reset rating
    isSubmitted.value = false;
    textEditingController.clear();
    descriptionValidator.value?.clear();
  }
}


/// Without ratings
/*
class FeedbackFormController extends GetxController {
  var selectedTopic = ''.obs;
  var description = ''.obs;
  var isSubmitted = false.obs;
  final TextEditingController textEditingController = TextEditingController();

  final descriptionValidator = Rx<TextEditingController?>(null);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return FeedbackBottomSheet(
          onSelectTopic: (String topic) {
            selectedTopic.value = topic;
            // Clear validation error if any
            descriptionValidator.value?.text = '';
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void submitFeedback(BuildContext context) {
    if (selectedTopic.value.isEmpty) {
      // Show snack bar for topic validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a topic')),
      );
      return;
    }

    if (description.value.isEmpty) {
      // Show snack bar for description validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter description')),
      );
      return;
    }

    // Implement your feedback submission logic here
    // For demonstration purposes, I'm just setting isSubmitted to true
    isSubmitted.value = true;

    // Navigate to SuccessScreen if feedback is submitted successfully
    if (isSubmitted.value) {
      Get.to(() => SuccessScreen(onGoBack: resetForm));
    }
  }

  void resetForm() {
    selectedTopic.value = '';
    description.value = '';
    isSubmitted.value = false;
    textEditingController.clear();
    descriptionValidator.value?.clear();
  }
}


 */

/*
class FeedbackFormController extends GetxController {
  var selectedTopic = ''.obs;
  var description = ''.obs;
  var isSubmitted = false.obs;
  final TextEditingController textEditingController = TextEditingController();


  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FeedbackBottomSheet(
          onSelectTopic: (String topic) {
            selectedTopic.value = topic;
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void submitFeedback(BuildContext context) {
    // Implement your feedback submission logic here
    // For demonstration purposes, I'm just setting isSubmitted to true
    isSubmitted.value = true;

    // Navigate to SuccessScreen if feedback is submitted successfully
    if (isSubmitted.value) {
      Get.to(() => SuccessScreen(onGoBack: resetForm));
    }
  }

  void resetForm() {
    selectedTopic.value = '';
    description.value = '';
    isSubmitted.value = false;
    textEditingController.clear();
  }
}

 */