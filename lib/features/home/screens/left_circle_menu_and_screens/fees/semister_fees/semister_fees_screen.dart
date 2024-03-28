/// correct code without Bottom sheet
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';

class ViewMoreScreen extends StatelessWidget {
  final Map<String, dynamic> viewMoreData;
  final int sem;
  final perSemFees;
  final paidAmount;
  final balanceAmount;

  ViewMoreScreen(this.viewMoreData, this.sem, this.perSemFees, this.paidAmount,
      this.balanceAmount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          "Sem ${sem.toString()}",
          style: const TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              AnimationWidget(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                animationType: 'fade',
                child: _topFeesContainer(
                  'Per Semester',
                  '₹$perSemFees' ?? '',
                ),
              ),
              // _topFeesContainer(
              //   'Balance Amt',
              //   '₹$balanceAmount' ?? '',
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10, top: 8),
                    child: AnimationWidget(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      animationType: 'fade',
                      child: const Text(
                        'Fees Summary',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: EColors.textColorPrimary1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // for (var entry in viewMoreData['fees'].entries)
              //   _buildInfoCard(entry.key, entry.value),
              // for (var fee in viewMoreData['fees'])
              //   _buildInfoCard(
              //       fee['fees_type'],
              //       'Total: ₹${fee['totalamt']}, \nMode: ${fee['mode']}, \nSlip No: ${fee['slips']}, \nEntry Date: ${fee['cash_entrydt']}'
              //   ),
              for (var fee in viewMoreData['fees'])
                AnimationWidget(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  animationType: 'fade',
                  child: _buildInfoCard(
                    fee['fees_type'],
                    fee['totalamt'],
                    fee['mode'],
                    fee['slips'],
                    fee['cash_entrydt'],
                  ),
                ),
              AnimationWidget(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                animationType: 'fade',
                child: _topFeesContainer(
                  'Balance Amt',
                  '₹$balanceAmount' ?? '',
                ),
              ),
              AnimationWidget(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                animationType: 'fade',
                child: _topFeesContainer(
                  'Total Paid',
                  '₹$paidAmount' ?? '',

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoCard(String feesType, String totalAmt, String mode, String slipNo, String entryDate) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              FontAwesomeIcons.solidCreditCard,
              color: EColors.primary,
              size: 15,
            ),
            Text(
              feesType,
              style: TextStyleClass.feesSummaryText,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text('Total: ₹$totalAmt,',style: TextStyleClass.feesText,),
      Text('Mode: $mode,',style: TextStyleClass.feesText,),
      Text('Slip No: $slipNo,',style: TextStyleClass.feesText,),
      Text('Date: $entryDate',style: TextStyleClass.feesText,),
      const Divider()
      ],
    ),
  );
}

Widget _topFeesContainer(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EColors.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(-3, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: EColors.textColorPrimary1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$value.00',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: EColors.textColorPrimary1,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pinkAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              FontAwesomeIcons.creditCard,
              color: EColors.backgroundColor,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}




