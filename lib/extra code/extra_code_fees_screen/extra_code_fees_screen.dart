

/// ORIGINAL CODE ---->>>
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/semister_fees/semister_fees_screen.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import '../../../../../common/widgets/profile_image_name/profile_header_name_image.dart';
import '../../../../../common/widgets/texts/text_styles.dart';
import 'fees_contanier/fees_contents_contanier.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: true,
        title: Text(
          'Fees',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Column(
            children: [
              /// --- Circular Avatar User Profile Image & Edit Button ---
              const Padding(
                padding: EdgeInsets.only(right: 40),
                child: UserProfile(
                  userText2: 'Surya Pratap Singh',
                  userText: 'GN/212/ME/2024/CS',
                  imagePath: 'assets/images/user_icon.png',
                  showEditButton: false,
                  width: 80,
                  height: 80,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Divider(
                  height: 10,
                ),
              ),

              const SizedBox(
                height: ESizes.spaceBtwItemsHeadings,
              ),

              /// Heading Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF823333),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextStyle(
                          text: 'Breakdown of Student Fees by Semester',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Heading | Title Text
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: EColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        CustomTextStyle(
                          text: 'Semester',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomTextStyle(
                          text: 'Per Semester',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomTextStyle(
                          text: 'Paid Amount',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: EColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    FeesData(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeesData extends StatelessWidget {
  final List<Map<String, dynamic>> semesterDetails = [
    {
      'Semester': '1',
      'Per Semester': '15000.00',
      'Paid Amount': '20000.00',
      'View More': {
        'Admission Fee': 2000,
        'Student’s Welfare Fund': 750,
        'Modernization': 1500,
        'Library Security Deposit': 4242,
        'Tuition Fee': 45455,
        'Examination': 4242,
        'Registration': 4222
      },
      'Total': 45445
    },
    {
      'Semester': '2',
      'Per Semester': '15000.00',
      'Paid Amount': '20000.00',
      'View More': {
        'Admission Fee': 2000,
        'Student’s Welfare Fund': 750,
        'Modernization': 1500,
        'Library Security Deposit': 4242,
        'Tuition Fee': 45455,
        'Examination': 4242,
        'Registration': 4222
      },
      'Total': 45445
    },
    // Add similar entries for other semesters
  ];

  final Map<String, String> totalDetails = {
    'Total': 'Total',
    'Total Amt': '72000.00',
    'Per Semester total': '30000.00',
    'Paid Amount total': '40000.00',
    'Balance Amount': 'Balance Amount',
    'Total Balance Amount': '1,23,569.00',
  };

  FeesData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var details in semesterDetails)
          FeesDataContainer(
            semester: details['Semester'] ?? '',
            preSemester: details['Per Semester'] ?? '',
            paidAmount: details['Paid Amount'] ?? '',
            onPressed: () {
              Get.to(() => SemesterFeesScreen(data: details));
            },
          ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(height: 4),
        ),
        TotalFeesDataContainer(
          totalText: totalDetails['Total'] ?? '',
          preSemester: totalDetails['Total Amt'] ?? '',
          paidAmount: totalDetails['Paid Amount total'] ?? '',
        ),
        TotalFeesDataContainer(
          totalText: totalDetails['Balance Amount'] ?? '',
          preSemester: totalDetails['Total Balance Amount'] ?? '',
          paidAmount: '',
        ),
      ],
    );
  }
}


 */



/// ------------>>>>>>>>>>>>>>>>>>
// class FeesData extends StatelessWidget {
//   final List<Map<String, String>> semesterDetails = [
//     {'Semester': '1', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '2', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '3', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '4', 'Per Semester': '2000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '5', 'Per Semester': '10000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '6', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '7', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//     {'Semester': '8', 'Per Semester': '15000.00', 'Paid Amount': '20000.00'},
//
//     //   "Total" :
//     // 'Per Semester total': '30000.00',
//     //  'Paid Amount total': '40000.00',
//     // 'Balance Amount': 'Balance Amount',
//     // 'Total Balance Amount': '1,23,569.00',
//
//   ];
//
//   final Map<String, String> totalDetails = {
//     'Total': 'Total',
//     'Total Amt': '72000.00',
//     'Per Semester total': '30000.00',
//     'Paid Amount total': '40000.00',
//     'Balance Amount': 'Balance Amount',
//     'Total Balance Amount': '1,23,569.00',
//   };
//
//   FeesData({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (var details in semesterDetails)
//           FeesDataContainer(
//             semester: details['Semester'] ?? '',
//             preSemester: details['Per Semester'] ?? '',
//             paidAmount: details['Paid Amount'] ?? '',
//             onPressed: () => Get.to(() => const SemesterFeesScreen()),
//           ),
//
//         // FeesTotalRow(
//         //   totalPerSemesters: semesterDetails
//         //       .map((details) => double.parse(details['Per Semester']!))
//         //       .toList(),
//         //   totalPaidAmounts: semesterDetails
//         //       .map((details) => double.parse(details['Paid Amount']!))
//         //       .toList(),
//         // ),
//
//         // FeesDataContainer(
//         //   semester: totalDetails['Total'] ?? '',
//         //   preSemester: totalDetails['Per Semester total'] ?? '',
//         //   paidAmount: totalDetails['Paid Amount total'] ?? '',
//         // ),
//
//         const SizedBox(
//           height: 10,
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Divider(height: 4),
//         ),
//
//         TotalFeesDataContainer(
//           totalText: totalDetails['Total'] ?? '',
//           preSemester: totalDetails['Total Amt'] ?? '',
//           paidAmount: totalDetails['Paid Amount total'] ?? '',
//         ),
//
//         TotalFeesDataContainer(
//           totalText: totalDetails['Balance Amount'] ?? '',
//           preSemester: totalDetails['Total Balance Amount'] ?? '',
//           paidAmount: '',
//         ),
//       ],
//     );
//   }
// }
// class FeesTotalRow extends StatelessWidget {
//   final List<double> totalPerSemesters;
//   final List<double> totalPaidAmounts;
//
//   const FeesTotalRow({
//     super.key,
//     required this.totalPerSemesters,
//     required this.totalPaidAmounts,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final double totalPerSemestersSum =
//         totalPerSemesters.reduce((a, b) => a + b);
//     final double totalPaidAmountsSum = totalPaidAmounts.reduce((a, b) => a + b);
//
//     return ListTile(
//       title: const Text('Total'),
//       subtitle: Text(' ${totalPerSemestersSum.toStringAsFixed(2)}'),
//       trailing: Text(' ${totalPaidAmountsSum.toStringAsFixed(2)}'),
//     );
//   }
// }
