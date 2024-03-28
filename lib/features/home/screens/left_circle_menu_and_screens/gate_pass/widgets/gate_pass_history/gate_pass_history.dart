import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/gate_pass/gate_pass_controller/gate_pass_from_controller.dart';
import '../../../../../../../data/api/api_services.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../applyLeave/widgets/shimmer/leave_shimmer_contanier.dart';

class GatePassHistory extends StatelessWidget {
  final controller = Get.find<GatePassFormController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService.getGatePassHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // API call is still in progress, show a loading indicator
          return ShimmerLeaveHistory();
        } else if (snapshot.hasError) {
          // Error occurred while fetching leave history
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          // No Gate Pass history data available
          return const Text('No Gate Pass history available');
        } else {
          // Convert dynamic list to List<Map<String, dynamic>>
          List<Map<String, dynamic>> gatePassHistoryList =
              List<Map<String, dynamic>>.from(snapshot.data!);

          // Display leave application history using ListView.builder
          controller.gatePassHistory.clear();
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gatePassHistoryList.length,
            /*
            itemBuilder: (context, index) {
              final gatePassData = gatePassHistoryList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Column(
                      children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Text("Date: ${gatePassData['gpass_date']}"),
                           Text(gatePassData['gpass_time']),
                           Text(gatePassData['status']),
                         ],
                       ),
                      ],
                    ),
                  ),

                ],
              );
            },
             */
            itemBuilder: (context, index) {
              final gatePassData = gatePassHistoryList[index];
              final purpose = gatePassData['remark'] as String;
              //final leaveItemController = Get.put(LeaveItemController());

              // Check if leav_status is Approved or Cancelled
              bool isApproved = gatePassData['status'] == 'Approved';
              bool isCancelled = gatePassData['status'] == 'Cancelled';
              bool isVerify = gatePassData['status'] == 'Verify';

              return Dismissible(
                key: UniqueKey(),
                background: isApproved || isCancelled || isVerify
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
                  if (isApproved || isCancelled || isVerify) {
                    // Show an alert dialog indicating that cancellation is not allowed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Cancellation Not Allowed'),
                          content: const Text(
                            'Cancellation is not allowed for this Gate Pass application.',
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
                              'Are you sure you want to Cancel this Gate Pass Application?'),
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
                  if (!isApproved && !isCancelled && !isVerify) {
                    // Remove the item from the list if confirmed
                    // controller.leaveHistory.removeAt(index);
                    controller.gatePassHistory.remove(gatePassData);
                    // Call your delete API here using leaveData['leav_id']
                    ApiService.cancelGatePass(gatePassData['gpas_id']);
                    Get.snackbar(
                      'Gate Pass Application',
                      'Gate Pass application deleted.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                direction: DismissDirection.endToStart,
                child: GatePassItemWidget(gatePassData: gatePassData),
              );
            },
          );
        }
      },
    );
  }
}

class GatePassItemWidget extends StatelessWidget {
  final Map<String, dynamic> gatePassData;

  const GatePassItemWidget({required this.gatePassData});

  @override
  Widget build(BuildContext context) {
    final purpose = gatePassData['category'] as String;
    final gPassController = Get.find<GatePassFormController>();

    Color statusColor = Colors.grey.shade500;
    Color statusTextColor = Colors.grey.shade500;
    switch (gatePassData['status']) {
      case 'Pending':
        statusColor = Colors.amberAccent.shade400;
        statusTextColor = Colors.white;
        break;
      case 'Verify':
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
                  'Gate Pass Dates: ${gatePassData['gpass_date']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8), // Add some spacing
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Text(
                      'Out: ${gatePassData['gpass_outtime']}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: ESizes.spaceBtwSections,),
                    Text(
                      'In: ${gatePassData['gpass_intime']}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                          '${gatePassData['status']}',
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
                Text(
                  'Go With: ${gatePassData['gpas_gowith']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8), // Add some spacing
                Text(
                  '${gatePassData['remark']}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.drag_handle), // Add icon for drag handle
          ),
        ],
      ),
    );
  }
}
