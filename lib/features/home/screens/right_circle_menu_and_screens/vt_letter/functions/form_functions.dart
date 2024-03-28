// form_utils.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/api/api_services.dart';
import '../controller/form_controller.dart';

class FormUtils {
  static Future<void> selectDates(
      BuildContext context, RxString controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != currentDate) {
      controller.value = formatDate(picked);
      if (kDebugMode) {
        print("Date selected: ${controller.value}");
      }
    } else {
      if (kDebugMode) {
        print("Date selection canceled");
      }
    }
  }

  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static bool isValidForm(VTLetterFormController controller) {
    if (controller.fromController.value.isEmpty ||
        controller.toController.value.isEmpty ||
        controller.totalDayController.value.isEmpty) {
      controller.totalDayError.value =
          controller.totalDayController.value.isEmpty;
      controller.toError.value = controller.toController.value.isEmpty;
      controller.fromError.value = controller.fromController.value.isEmpty;

      if (kDebugMode) {
        print("Form validation failed");
      }
      return false;
    }
    if (kDebugMode) {
      print("Form validation successful");
    }
    return true;
  }

  static String calculateDays(String fromDate, String toDate) {
    final controller = Get.put(VTLetterFormController());
    try {
      if(fromDate=="" || toDate =="" ){
        controller.totalDayController = ''.obs;
        return '';
      }else {
        DateTime from = DateTime.parse(fromDate);
        DateTime to = DateTime.parse(toDate);
        Duration duration = to.difference(from);
        String val = duration.inDays.toString();
        controller.totalDayController = val.obs;
        return duration.inDays.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing dates: $e");
      }
      return 'Invalid date format';
    }
  }

  static Future<void> submitForm(
      BuildContext context, VTLetterFormController controller) async {
    if (isValidForm(controller)) {
      // Perform form submission logic here

      // Show circular progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // Call the API to apply leave
        String apiResponse = await ApiService.applyVtLetter(
          applyFrom: controller.fromController.toString(),
          applyTo: controller.toController.toString(),
          totalDay: controller.totalDayController.toString(),
          locationIds: controller.vtLocationIds,
        );

        // Dismiss the circular progress indicator
        Navigator.of(context).pop();

        // Show a GetX snackbar with the API response message
        Get.snackbar(
          'Vt Letter Apply..',
          apiResponse,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear the form fields after successful submission
        controller.fromController.value = '';
        controller.toController.value = '';
        controller.totalDayController.value = '';
        controller.vtLocationIds = '';
        // Navigate to a new screen upon successful submission
        Navigator.of(context).pop();
      } catch (error) {
        // Handle error if API call fails
        print("API Error: $error");

        // Dismiss the circular progress indicator
        Navigator.of(context).pop();

        // Show an error snackbar
        Get.snackbar(
          'Error',
          'Failed to submit Vt Letter. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}


/// Without snack bar
/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/api/api_services.dart';
import '../controller/form_controller.dart';

class FormUtils {
  static Future<void> selectDates(
      BuildContext context, RxString controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != currentDate) {
      controller.value = formatDate(picked);
      if (kDebugMode) {
        print("Date selected: ${controller.value}");
      }
    } else {
      if (kDebugMode) {
        print("Date selection canceled");
      }
    }
  }

  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static bool isValidForm(VTLetterFormController controller) {
    if (controller.fromController.value.isEmpty ||
        controller.toController.value.isEmpty ||
        controller.totalDayController.value.isEmpty) {
      controller.totalDayError.value =
          controller.totalDayController.value.isEmpty;
      controller.toError.value = controller.toController.value.isEmpty;
      controller.fromError.value = controller.fromController.value.isEmpty;

      if (kDebugMode) {
        print("Form validation failed");
      }
      return false;
    }
    if (kDebugMode) {
      print("Form validation successful");
    }
    return true;
  }

  static String calculateDays(String fromDate, String toDate) {
    final controller = Get.put(VTLetterFormController());
    try {
      if(fromDate=="" || toDate =="" ){
        controller.totalDayController = ''.obs;
        return '';
      }else {
        DateTime from = DateTime.parse(fromDate);
        DateTime to = DateTime.parse(toDate);
        Duration duration = to.difference(from);
        String val = duration.inDays.toString();
        controller.totalDayController = val.obs;
        return duration.inDays.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing dates: $e");
      }
      return 'Invalid date format';
    }
  }

  static Future<void> submitForm(
      BuildContext context, VTLetterFormController controller) async {
    if (isValidForm(controller)) {
      // Perform form submission logic here

        // Show circular progress indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        try {
          // Call the API to apply leave
          String apiResponse = await ApiService.applyVtLetter(
              applyFrom: controller.fromController.toString(),
              applyTo: controller.toController.toString(),
              totalDay: controller.totalDayController.toString(),
              locationIds: controller.vtLocationIds);

          // Dismiss the circular progress indicator
          Navigator.of(context).pop();

          // Show a GetX snackbar with the API response message
          Get.snackbar(
            'Vt Letter Apply..',
            apiResponse,
            snackPosition: SnackPosition.BOTTOM,
          );

          // Clear the form fields after successful submission
          controller.fromController.value = '';
          controller.toController.value = '';
          controller.totalDayController.value = '';
          controller.vtLocationIds = '';
          // Navigate to a new screen upon successful submission
          Navigator.of(context).pop();
        } catch (error) {
          // Handle error if API call fails
          print("API Error: $error");

          // Dismiss the circular progress indicator
          Navigator.of(context).pop();

          // Show an error snackbar
          Get.snackbar(
            'Error',
            'Failed to submit Vt Letter. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

      if (kDebugMode) {
        print("Form submitted successfully");
      }
    } else {
      if (kDebugMode) {
        print("Form submission failed");
      }
    }
  }
}


 */