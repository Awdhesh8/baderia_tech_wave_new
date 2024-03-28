import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/applyLeave/widgets/leave_form.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/applyLeave/widgets/leave_history/leave_history.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import 'leave_controller/leave_from_controller.dart';

class ApplyLeave extends StatelessWidget {
  const ApplyLeave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeaveFormController());
    return Scaffold(
      backgroundColor: EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Apply Leave',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /// Top Heading
              const TopHeading(
                text: 'Need Time Off?\nApply Now!',
              ),

              /// Leave Form
              LeaveForm(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Shimmer.fromColors(
                  baseColor: EColors.primary,
                  highlightColor: EColors.primarySecond,
                  child: const Row(
                    children: [
                      Text(
                        'Need to backtrack? Swipe to Cancel!',
                      ),
                    ],
                  ),
                ),
              ),

              /// Divider to separate current leave application and history
              const Divider(),

              /// Leave application history
              const TopHeading(
                text: 'History',
              ),

              SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(
                      color: EColors.backgroundColor,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: LeaveApplicationHistory()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveItemWidget extends StatelessWidget {
  final Map<String, dynamic> leaveData;

  const LeaveItemWidget({required this.leaveData});

  @override
  Widget build(BuildContext context) {
    final purpose = leaveData['leav_purpose'] as String;
    final leaveItemController = Get.put(LeaveItemController());

    Color statusColor = Colors.grey.shade500;
    Color statusTextColor = Colors.grey.shade500;
    switch (leaveData['leav_status']) {
      case 'Pending':
        statusColor = Colors.amberAccent.shade400;
        statusTextColor = Colors.white;
        break;
      case 'Declined':
        statusColor = Colors.red.shade300;
        statusTextColor = Colors.white;
        break;
      case 'Approved':
        statusColor = Colors.green.shade200;
        statusTextColor = Colors.white;
        break;
      default:
        statusColor = Colors.grey.shade500;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${leaveData['stud_name']}',
                  style: const TextStyle(
                    color: EColors.textColorPrimary1,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Leave Dates: ${leaveData['leave_date']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors
                            .grey.shade400, // Text color for all status colors
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${leaveData['leav_status']}',
                          style: TextStyle(
                            color:
                                statusTextColor, // Text color for all status colors
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Add some spacing
                LeavePurposeTextWidget(purpose: purpose),
              ],
            ),
            trailing: const Icon(Icons.drag_handle), // Add icon for drag handle
          ),
        ],
      ),
    );
  }
}

class LeavePurposeTextWidget extends StatelessWidget {
  final String purpose;

  const LeavePurposeTextWidget({required this.purpose});

  @override
  Widget build(BuildContext context) {
    final leaveItemController = Get.find<LeaveItemController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            purpose,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
            maxLines: leaveItemController.isExpanded.value ? null : 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (purpose.split('\n').length >
            3) // Check if text has more than 3 lines
          TextButton(
            onPressed: () {
              leaveItemController.toggleExpand();
            },
            child: Obx(
              () => Text(
                leaveItemController.isExpanded.value
                    ? 'View Less'
                    : 'View More',
                style: const TextStyle(
                  color: Colors.blue, // You can adjust the color as needed
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class LeaveItemController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}


/// Correct code
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../data/api/api_services.dart';

class ApplyLeave extends StatelessWidget {
  const ApplyLeave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeaveFormController());
    return Scaffold(
      backgroundColor: EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Apply Leave',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /// Top Heading
              const TopHeading(
                text: 'Need Time Off?\nApply Now!',
              ),

              /// Leave Form
              LeaveForm(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Shimmer.fromColors(
                  baseColor: EColors.primary,
                  highlightColor: EColors.primarySecond,
                  child: const Row(
                    children: [
                      Text(
                        'Need to backtrack? Swipe to Cancel!',
                      ),
                    ],
                  ),
                ),
              ),

              /// Divider to separate current leave application and history
              const Divider(),

              /// Leave application history
              const TopHeading(
                text: 'History',
              ),

              SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(
                      color: EColors.backgroundColor,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: LeaveApplicationHistory()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveFormController extends GetxController {
  RxString fromController = ''.obs;
  RxString toController = ''.obs;
  RxString reasonController = ''.obs;
  RxBool reasonError = false.obs;

  // RxList to store the history of leave applications
  RxList<String> leaveHistory = <String>[].obs;
}

class LeaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveFormController());

    return Form(
      child: Column(
        children: [
          Obx(() => ListTile(
                title: Text(
                    'From Date: ${controller.fromController.value.isEmpty ? 'Select From Date' : controller.fromController.value}'),
                onTap: () {
                  print("Selecting From Date");
                  _selectDate(context, true, controller.fromController);
                },
              )),
          Obx(() => ListTile(
                title: Text(
                    'To Date: ${controller.toController.value.isEmpty ? 'Select To Date' : controller.toController.value}'),
                onTap: () {
                  print("Selecting To Date");
                  _selectDate(context, false, controller.toController);
                },
              )),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(
                  // border: Border.all(
                  //   color: controller.reasonError.value
                  //       ? Colors.red
                  //       : Colors.transparent,
                  // ),
                  // borderRadius: BorderRadius.circular(8.0),
                  ),
              constraints: const BoxConstraints(
                minHeight: 50.0,
              ),
              child: TextFormField(
                onChanged: (value) {
                  controller.reasonController.value = value;
                  controller.reasonError.value = false;
                  // Reset the error state when the user starts typing
                },
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: const Icon(Iconsax.document_text),
                  labelText: 'Application',
                  errorText: controller.reasonError.value
                      ? 'Please enter a reason'
                      : null,
                ),
                maxLength: 250,
                maxLines:
                    null, // Allow the field to expand vertically as needed
              ),
            ),

            // Obx(() => TextFormField(
            //   onChanged: (value) {
            //     controller.reasonController.value = value;
            //     controller.reasonError.value =
            //     false; // Reset the error state when the user starts typing
            //   },
            //   decoration: InputDecoration(
            //     isDense: true,
            //     suffixIcon: const Icon(Iconsax.document_text),
            //     labelText: 'Application',
            //     errorText: controller.reasonError.value
            //         ? 'Please enter a reason'
            //         : null,
            //   ),
            //   maxLength: 250,
            //   maxLines: 3,
            // ),
          ),
          const SizedBox(height: 16.0),
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
              }
            },
            child: const Text('Submit'),
          ),
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
      print("Form validation failed");
      return false;
    }
    print("Form validation successful");
    return true;
  }

  String _formatLeaveApplication(LeaveFormController controller) {
    // Format leave application for display in history
    return 'From: ${controller.fromController.value}, To: ${controller.toController.value}, Reason: ${controller.reasonController.value}';
  }
}

class LeaveApplicationHistory extends StatelessWidget {
  final controller = Get.find<LeaveFormController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService.getLeaveHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // API call is still in progress, show a loading indicator
          return ShimmerLeaveHistory();
        } else if (snapshot.hasError) {
          // Error occurred while fetching leave history
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          // No leave history data available
          return const Text('No leave history available');
        } else {
          // Convert dynamic list to List<Map<String, dynamic>>
          List<Map<String, dynamic>> leaveHistoryList =
              List<Map<String, dynamic>>.from(snapshot.data!);

          // Display leave application history using ListView.builder
          controller.leaveHistory.clear();
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leaveHistoryList.length,
            itemBuilder: (context, index) {
              final leaveData = leaveHistoryList[index];
              final purpose = leaveData['leav_purpose'] as String;
              final leaveItemController = Get.put(LeaveItemController());

              // Check if leav_status is Approved or Cancelled
              bool isApproved = leaveData['leav_status'] == 'Approved';
              bool isCancelled = leaveData['leav_status'] == 'Cancelled';

              return Dismissible(
                key: UniqueKey(),
                background: isApproved || isCancelled
                    ? null
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Cancel Application....   ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                confirmDismiss: (direction) async {
                  if (isApproved || isCancelled) {
                    // Show an alert dialog indicating that cancellation is not allowed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Cancellation Not Allowed'),
                          content: const Text(
                            'Cancellation is not allowed for this leave application.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return false;
                  } else {
                    // Show confirmation dialog for cancellation
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Cancellation'),
                          content: const Text(
                              'Are you sure you want to Cancel this leave application?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onDismissed: (direction) {
                  if (!isApproved && !isCancelled) {
                    // Remove the item from the list if confirmed
                    // controller.leaveHistory.removeAt(index);
                    controller.leaveHistory.remove(leaveData);
                    // Call your delete API here using leaveData['leav_id']
                    ApiService.cancelLeave(leaveData['leav_id']);
                    Get.snackbar(
                      'Leave Application',
                      'Leave application deleted.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                direction: DismissDirection.endToStart,
                child: LeaveItemWidget(leaveData: leaveData),
              );
            },
          );
        }
      },
    );
  }
}

class LeaveItemWidget extends StatelessWidget {
  final Map<String, dynamic> leaveData;

  const LeaveItemWidget({required this.leaveData});

  @override
  Widget build(BuildContext context) {
    final purpose = leaveData['leav_purpose'] as String;
    final leaveItemController = Get.put(LeaveItemController());

    Color statusColor = Colors.grey.shade500;
    Color statusTextColor = Colors.grey.shade500;
    switch (leaveData['leav_status']) {
      case 'Pending':
        statusColor = Colors.amberAccent.shade400;
        statusTextColor = Colors.white;
        break;
      case 'Cancelled':
        statusColor = Colors.red.shade300;
        statusTextColor = Colors.white;
        break;
      case 'Approved':
        statusColor = Colors.green.shade200;
        statusTextColor = Colors.white;
        break;
      default:
        statusColor = Colors.grey.shade500;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${leaveData['stud_name']}',
                  style: const TextStyle(
                    color: EColors.textColorPrimary1,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Leave Dates: ${leaveData['leave_date']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors
                            .grey.shade400, // Text color for all status colors
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${leaveData['leav_status']}',
                          style: TextStyle(
                            color:
                                statusTextColor, // Text color for all status colors
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Add some spacing
                LeavePurposeTextWidget(purpose: purpose),
              ],
            ),
            trailing: const Icon(Icons.drag_handle), // Add icon for drag handle
          ),
        ],
      ),
    );
  }
}

class LeavePurposeTextWidget extends StatelessWidget {
  final String purpose;

  const LeavePurposeTextWidget({required this.purpose});

  @override
  Widget build(BuildContext context) {
    final leaveItemController = Get.find<LeaveItemController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            purpose,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
            maxLines: leaveItemController.isExpanded.value ? null : 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (purpose.split('\n').length >
            3) // Check if text has more than 3 lines
          TextButton(
            onPressed: () {
              leaveItemController.toggleExpand();
            },
            child: Obx(
              () => Text(
                leaveItemController.isExpanded.value
                    ? 'View Less'
                    : 'View More',
                style: const TextStyle(
                  color: Colors.blue, // You can adjust the color as needed
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class LeaveItemController extends GetxController {
  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}

// Shimmer effect widget for Leave Application History
class ShimmerLeaveHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5, // You can adjust the count based on how many shimmer placeholders you want
        (index) => ListTile(
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 */

// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
// import 'package:get/get.dart';
// import '../../../../../common/widgets/texts/top_first_heading.dart';
//
// class ApplyLeave extends StatelessWidget {
//   const ApplyLeave({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: GAppBar(
//         backgroundColor: Colors.transparent,
//         showBackArrow: true,
//         title: Text(
//           'Apply Leave',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontFamily: 'Inter',
//             color: EColors.textColorPrimary1,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               /// Top Heading
//               TopHeading(
//                 text: 'Need Time Off?\nApply Now!',
//               ),
//
//               /// Leave Form
//               LeaveForm(),
//
//               // Divider to separate current leave application and history
//               Divider(),
//
//               // Leave application history
//               SingleChildScrollView(
//                 child: Container(
//                     decoration: BoxDecoration(
//                         color: EColors.backgroundColor,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: LeaveApplicationHistory()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LeaveFormController extends GetxController {
//   RxString fromController = ''.obs;
//   RxString toController = ''.obs;
//   RxString reasonController = ''.obs;
//   RxBool reasonError = false.obs;
//
//   // RxList to store the history of leave applications
//   RxList<String> leaveHistory = <String>[].obs;
// }
//
// class LeaveForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LeaveFormController());
//
//     return Form(
//       child: Column(
//         children: [
//           Obx(() => ListTile(
//                 title: Text(
//                     'From Date: ${controller.fromController.value.isEmpty ? 'Select From Date' : controller.fromController.value}'),
//                 onTap: () {
//                   print("Selecting From Date");
//                   _selectDate(context, true, controller.fromController);
//                 },
//               )),
//           Obx(() => ListTile(
//                 title: Text(
//                     'To Date: ${controller.toController.value.isEmpty ? 'Select To Date' : controller.toController.value}'),
//                 onTap: () {
//                   print("Selecting To Date");
//                   _selectDate(context, false, controller.toController);
//                 },
//               )),
//           Obx(() => TextFormField(
//                 onChanged: (value) {
//                   controller.reasonController.value = value;
//                   controller.reasonError.value =
//                       false; // Reset the error state when the user starts typing
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Reason',
//                   errorText: controller.reasonError.value
//                       ? 'Please enter a reason'
//                       : null,
//                 ),
//               )),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               if (_isValidForm(controller)) {
//                 // Save current leave application to history
//                 controller.leaveHistory
//                     .insert(0, _formatLeaveApplication(controller));
//                 print("Form is valid. Submitting...");
//
//                 // Clear the form fields after submission
//                 controller.fromController.value = '';
//                 controller.toController.value = '';
//                 controller.reasonController.value = '';
//               }
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _selectDate(
//       BuildContext context, bool isFromDate, RxString controller) async {
//     DateTime currentDate = DateTime.now();
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: currentDate,
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != currentDate) {
//       controller.value = _formatDate(picked);
//       print("Date selected: ${controller.value}");
//     } else {
//       print("Date selection canceled");
//     }
//   }
//
//   String _formatDate(DateTime date) {
//     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//   }
//
//   bool _isValidForm(LeaveFormController controller) {
//     if (controller.fromController.value.isEmpty ||
//         controller.toController.value.isEmpty ||
//         controller.reasonController.value.isEmpty) {
//       controller.reasonError.value = controller.reasonController.value.isEmpty;
//       print("Form validation failed");
//       return false;
//     }
//     print("Form validation successful");
//     return true;
//   }
//
//   String _formatLeaveApplication(LeaveFormController controller) {
//     // Format leave application for display in history
//     return 'From: ${controller.fromController.value}, To: ${controller.toController.value}, Reason: ${controller.reasonController.value}';
//   }
// }
//
// class LeaveApplicationHistory extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<LeaveFormController>();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Leave Application History',
//           style: TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8.0),
//         // Display leave application history using ListView.builder
//         Obx(
//           () => ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: controller.leaveHistory.length,
//             itemBuilder: (context, index) {
//               final leaveApplication = controller.leaveHistory[index];
//               return ListTile(
//                 title: Text(leaveApplication),
//                 trailing: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     // Delete the leave application
//                     controller.leaveHistory.removeAt(index);
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
