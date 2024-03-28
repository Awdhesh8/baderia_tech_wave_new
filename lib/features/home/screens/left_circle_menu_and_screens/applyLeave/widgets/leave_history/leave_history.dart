import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../../data/api/api_services.dart';
import '../../apply_leave.dart';
import '../../leave_controller/leave_from_controller.dart';
import '../shimmer/leave_shimmer_contanier.dart';

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
              bool isDeclined = leaveData['leav_status'] == 'Declined';

              return Dismissible(
                key: UniqueKey(),
                background: isApproved || isCancelled || isDeclined
                    ? null
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
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
                  if (isApproved || isCancelled || isDeclined) {
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
                  if (!isApproved && !isCancelled && !isDeclined) {
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

class LeaveStateController extends GetxController {
  RxList<String> leaveHistory = <String>[].obs;
}
