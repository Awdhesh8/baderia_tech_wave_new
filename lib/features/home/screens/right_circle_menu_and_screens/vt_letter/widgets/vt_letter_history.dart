import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../left_circle_menu_and_screens/applyLeave/widgets/shimmer/leave_shimmer_contanier.dart';
import '../controller/form_controller.dart';

class VtletterHistory extends StatelessWidget {
  final controller = Get.put(VTLetterFormController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ApiService.fetchVtLetterHistory(),
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
          List<Map<String, dynamic>> historyList =
          List<Map<String, dynamic>>.from(snapshot.data!);

          // Display leave application history using ListView.builder
          controller.vtLetterHistory.clear();
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: historyList.length,

            itemBuilder: (context, index) {
              final gatePassData = historyList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("From: ${gatePassData['vt_frmdt']}"),
                             Text("To: ${gatePassData['vt_tilldt']}"),
                             Text("${gatePassData['vtp_locat']}"),
                             Text("Training Day's: ${gatePassData['vt_tday']}"),
                             Text("Day's: ${gatePassData['vt_tday']}"),
                             Text("Day's: ${gatePassData['vt_tday']}"),
                           ],
                         ),
                       ),

                      ],
                    ),
                  ),

                ],
              );
            },

            /*
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
                direction: DismissDirection.endToStart,
                child: GatePassItemWidget(gatePassData: gatePassData),
              );
            },

             */
          );
        }
      },
    );
  }
}
