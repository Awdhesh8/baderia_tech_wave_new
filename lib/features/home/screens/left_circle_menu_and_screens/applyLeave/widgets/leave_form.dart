import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../leave_controller/leave_from_controller.dart';

class LeaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveFormController());

    return Form(
      child: Column(
        children: [
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => AnimatedContainer(
                    width: 150,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: const BoxDecoration(),
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: controller.fromController.value),
                      // controller: TextEditingController(text: controller.fromController.value.isEmpty ? 'From' : controller.fromController.value),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EColors.textColorPrimary1,
                      ),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Iconsax.calendar_add),
                          onPressed: () {
                            _selectDate(
                                context, false, controller.fromController);
                          },
                        ),
                        labelText: 'From',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontFamily: 'Inter',
                        ),
                        errorText: controller.fromError.value
                            ? 'Please Select From Date'
                            : null,
                      ),
                    ),
                  ),
              ),
              const SizedBox(
                width: ESizes.spaceBtwItems,
              ),
              Obx(() => InkWell(
                    onTap: () {
                      _selectDate(context, false, controller.toController);
                    },
                    child: AnimatedContainer(
                      width: 150,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: const BoxDecoration(),
                      constraints: const BoxConstraints(
                        minHeight: 50.0,
                      ),
                      child: TextFormField(
                        controller: TextEditingController(
                            text: controller.toController.value),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: EColors.textColorPrimary1,
                        ),
                        onChanged: (value) {
                          // controller.toController.value.isEmpty
                          //     ? 'To'
                          //     : controller.toController.value;
                          // controller.reasonError.value = false;
                          // Reset the error state when the user starts typing
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Iconsax.calendar_add),
                            onPressed: () {
                              _selectDate(
                                  context, false, controller.toController);
                            },
                          ),
                          labelText: 'To',
                          labelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                          errorText: controller.toError.value
                              ? 'Please Select to date'
                              : null,
                        ),
                        // maxLength: 250,
                        // maxLines:
                        //     null, // Allow the field to expand vertically as needed
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(),
              constraints: const BoxConstraints(
                minHeight: 50.0,
              ),
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: EColors.textColorPrimary1,
                ),
                onChanged: (value) {
                  controller.reasonController.value = value;
                  controller.reasonError.value = false;
                  // Reset the error state when the user starts typing
                },
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: const Icon(Iconsax.document_text),
                  labelText: 'Application',
                  labelStyle: const TextStyle(
                      color: Colors.black54, fontSize: 13, fontFamily: 'Inter'),
                  errorText: controller.reasonError.value
                      ? 'Please write a short Application'
                      : null,
                ),
                minLines: 3,
                maxLength: 250,
                maxLines:
                    null, // Allow the field to expand vertically as needed
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_isValidForm(controller)) {
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
                  String apiResponse = await ApiService.applyLeave(
                    applyFrom: controller.fromController.value,
                    applyTo: controller.toController.value,
                    reason: controller.reasonController.value,
                  );

                  // Dismiss the circular progress indicator
                  Navigator.of(context).pop();

                  // Show a GetX snackbar with the API response message
                  Get.snackbar(
                    'Leave Application',
                    apiResponse,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // Clear the form fields after successful submission
                  controller.fromController.value = '';
                  controller.toController.value = '';
                  controller.reasonController.value = '';

                  // Fetch and update leave history
                  await ApiService.getLeaveHistory();

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
                    'Failed to submit leave application. Please try again.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }
            },
            child: const Text('Submit'),
          ),

/*
          ElevatedButton(
            onPressed: () async {
              if (_isValidForm(controller)) {
                // Save current leave application to history
                controller.leaveHistory
                    .insert(0, _formatLeaveApplication(controller));
                print("Form is valid. Submitting...");

                // Call the API to apply leave
                String apiResponse = await ApiService.applyLeave(
                  applyFrom: controller.fromController.value,
                  applyTo: controller.toController.value,
                  reason: controller.reasonController.value,
                );

                // Show a GetX snackbar with the API response message
                Get.snackbar(
                  'Leave Application',
                  apiResponse,
                  snackPosition: SnackPosition.BOTTOM,
                );

                // Clear the form fields after submission
                controller.fromController.value = '';
                controller.toController.value = '';
                controller.reasonController.value = '';

                // await ApiService.getLeaveHistory();



              }
            },
            child: const Text('Submit'),
          ),

 */
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, bool isFromDate, RxString controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != currentDate) {
      controller.value = _formatDate(picked);
      print("Date selected: ${controller.value}");
    } else {
      print("Date selection canceled");
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isValidForm(LeaveFormController controller) {
    if (controller.fromController.value.isEmpty ||
        controller.toController.value.isEmpty ||
        controller.reasonController.value.isEmpty) {
      controller.reasonError.value = controller.reasonController.value.isEmpty;
      controller.toError.value = controller.toController.value.isEmpty;
      controller.fromError.value = controller.fromController.value.isEmpty;

      print("Form validation failed");
      return false;
    }
    print("Form validation successful");
    return true;
  }
}

/// pop back
/*
ElevatedButton(
  onPressed: () async {
    if (_isValidForm(controller)) {
      // Show circular progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // Call the API to apply leave
        String apiResponse = await ApiService.applyLeave(
          applyFrom: controller.fromController.value,
          applyTo: controller.toController.value,
          reason: controller.reasonController.value,
        );

        // Dismiss the circular progress indicator
        Navigator.of(context).pop();

        // Show a GetX snackbar with the API response message
        Get.snackbar(
          'Leave Application',
          apiResponse,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear the form fields after successful submission
        controller.fromController.value = '';
        controller.toController.value = '';
        controller.reasonController.value = '';

        // Fetch and update leave history
        await ApiService.getLeaveHistory();

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
          'Failed to submit leave application. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  },
  child: const Text('Submit'),
),

 */
