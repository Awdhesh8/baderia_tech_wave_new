import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/data/api/api_services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../gate_pass_controller/gate_pass_from_controller.dart';
import '../BottomSheetContainerDecoration/bottom_sheet_container.dart';

class GatePassForm extends StatelessWidget {
  final GatePassFormController controller = Get.put(GatePassFormController());
  final String initialValue = '';

  // List of reasons for the gate pass
  /*
  List<String> reasons = [
    'Meeting',
    'Personal',
    'Emergency',
    'Official Business',
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Pick From Time
              InkWell(
                onTap: () async {
                  _selectTime(context, false, controller.fromTimeController);
                },
                child: Obx(
                  () => AnimatedContainer(
                    width: 165,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: const BoxDecoration(),
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: controller.fromTimeController.value),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EColors.textColorPrimary1,
                      ),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.timer_outlined),
                          onPressed: () async {
                            _selectTime(
                                context, false, controller.fromTimeController);
                          },
                        ),
                        labelText: 'From Time',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontFamily: 'Inter',
                        ),
                        errorText: controller.fromError.value
                            ? 'Please Select From Time'
                            : null,
                      ),
                    ),
                  ),
                ),
              ),

              /// Pick To Time
              InkWell(
                onTap: () async {
                  _selectTime(context, false, controller.toTimeController);
                },
                child: Obx(
                  () => AnimatedContainer(
                    width: 165,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: const BoxDecoration(),
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: controller.toTimeController.value),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EColors.textColorPrimary1,
                      ),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.timer_outlined),
                          onPressed: () async {
                            _selectTime(
                                context, false, controller.toTimeController);
                          },
                        ),
                        labelText: 'To Time',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontFamily: 'Inter',
                        ),
                        errorText: controller.toError.value
                            ? 'Please Select To Time'
                            : null,
                      ),
                    ),
                  ),
                ),
              ),

              /// Reasons (In Bottom Sheet)
              /*
              InkWell(
                onTap: () {
                  _showReasonBottomSheet(context);
                },
                child: Obx(
                  () => AnimatedContainer(
                    width: 180,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: const BoxDecoration(),
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: TextFormField(
                      controller: TextEditingController(
                          text: controller.selectedReason.value),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EColors.textColorPrimary1,
                      ),
                      onChanged: (value) {
                        controller.selectedReason.value;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showReasonBottomSheet(context);
                          },
                          icon: Icon(
                            Iconsax.document_text,
                          ),
                        ),
                        labelText: 'Reasons',
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

               */
            ],
          ),

          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          ///Gate Pass Reasons
          //Obx(() =>
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: const BoxDecoration(),
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            child: FutureBuilder<List<GatePassReason>>(
              future:
                  ApiService.fetchGatePassReasons(), // Fetch Gate Pass Reasons
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // If data is fetched successfully
                  return _buildGatePassReasonDropdown(snapshot.data!);
                } else {
                  return const Text(
                      'No data available'); // Handle the case when there is no data
                }
              },
            ),
          ),
          //),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          /// Student gow With (Text Field)
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
                  controller.goWithController.value = value;
                },
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: const Icon(Iconsax.text_block),
                  labelText: 'Go with (Person Name)',
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                  errorText: controller.goWithError.value
                      ? 'Please write Go with Person Name'
                      : null,
                ),
                minLines: 1,
                // maxLength: 250,
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          /// Application
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
                  controller.remarkController.value = value;
                },
                decoration: InputDecoration(
                  isDense: true,
                   suffixIcon: const Icon(Iconsax.document_text_1),
                  labelText: 'Gate Pass Remark',
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                  errorText: controller.remarkError.value
                      ? 'Please write a Remark'
                      : null,
                ),
                minLines: 3,
                maxLength: 250,
                maxLines: null,
              ),
            ),
          ),

          /// Submit button
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
                  String apiResponse = await ApiService.applyGatePass(
                    applyFrom: controller.fromTimeController.value,
                    applyTo: controller.toTimeController.value,
                    reason: controller.reasonController.value?.id ?? '',
                    goWith: controller.goWithController.value,
                    applyRemark: controller.remarkController.value,
                  );

                  // Dismiss the circular progress indicator
                  Navigator.of(context).pop();

                  // Show a GetX snackbar with the API response message
                  Get.snackbar(
                    'Gate Pass Apply',
                    apiResponse,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // Clear the form fields after successful submission
                  controller.fromTimeController.value = '';
                  controller.toTimeController.value = '';
                  //controller.reasonController.value?.id = '';
                  controller.goWithController.value = '';
                  controller.remarkController.value = '';
                  // Fetch and update leave history
                  //await ApiService.getLeaveHistory();

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
        ],
      ),
    );
  }

  Widget _buildGatePassReasonDropdown(List<GatePassReason> gatePassReasons) {
    String initialValue = controller.reasonController.value?.id ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Gate Pass Reasons'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      isDense: true,
      value: initialValue, // Set initial value here
      decoration: InputDecoration(
        //labelText: 'Gate Pass Reasons',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        errorText: controller.reasonError.value
            ? 'Please Select Gate Pass Reason'
            : '',
        // : gatePassReasons.firstWhere((group) => group.id == null,
      ),
      onChanged: (String? newValue) {
        controller.reasonController.value =
            gatePassReasons.firstWhere((group) => group.id == newValue);
      },
      // validator:(reasonController) {
      //   if(reasonController == null || reasonController.isEmpty) {
      //     return "Please Select any Reasons";
      //   }else {
      //     return null;
      //   }
      // },
      items: [
         const DropdownMenuItem<String>(
          value: 'Select Your Gate Pass Reasons',
          child: Text('Select Your Gate Pass Reasons',
              style: TextStyle(fontSize: 12)),
        ),
        ...gatePassReasons
            .map<DropdownMenuItem<String>>((GatePassReason group) {
          return DropdownMenuItem<String>(
            value: group.id,
            child: Text(group.name, style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ],
    );
  }

/*
  void _showReasonBottomSheet(BuildContext context) {
    Get.bottomSheet(
      elevation: 8,
      BottomSheetContainer(
        child: ListView.builder(
          itemCount: reasons.length,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              title: Text(
                "${reasons[index]}",
              ),
              onTap: () {
                controller.selectedReason.value =
                    reasons[index]; // Update using the controller
                Get.back(); // Close the bottom sheet
              },
            );
          },
        ),
      ),
    );
  }

 */

  Future<void> _selectTime(
      BuildContext context, bool isFromTime, RxString controller1) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      controller1.value = pickedTime.format(context);
      //controller1.value = _formatTime(pickedTime);
      print("Time selected: ${controller1.value}");
    } else {
      print("Time selection canceled");
    }
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString()}:${time.minute.toString()}';
  }

  bool _isValidForm(GatePassFormController controller) {
    if (controller.fromTimeController.value.isEmpty ||
        controller.toTimeController.value.isEmpty ||
        //controller.reasonController.value!.id.isEmpty||
        controller.goWithController.value.isEmpty ||
        controller.remarkController.value.isEmpty) {
      controller.fromError.value = controller.fromTimeController.value.isEmpty;
      controller.toError.value = controller.toTimeController.value.isEmpty;
      //controller.reasonError.value = controller.reasonController.value;
      controller.goWithError.value = controller.goWithController.value.isEmpty;
      controller.remarkError.value = controller.remarkController.value.isEmpty;

      print("Form validation failed");
      return false;
    }
    print("Form validation successful");
    return true;
  }
}

class GatePassReason {
  final String id;
  final String name;

  GatePassReason({required this.id, required this.name});

  factory GatePassReason.fromJson(Map<String, dynamic> json) {
    return GatePassReason(
      id: json['reason_id'] ?? '',
      name: json['reason_title'] ?? '',
    );
  }
}
