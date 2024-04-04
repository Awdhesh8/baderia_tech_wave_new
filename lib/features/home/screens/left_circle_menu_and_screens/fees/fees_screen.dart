import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import 'package:baderia_tech_wave/data/api/api_services.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/fees/semister_fees/semister_fees_screen.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animated_button.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/animations/common_animation.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../library/e_library/book_widget/e_book_widget.dart';

class FeesController extends GetxController {
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> summary = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> profileData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeeSummary();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      Map<String, dynamic>? responseData = await ApiService.getProfileData();
      if (responseData!.containsKey('response')) {
        // Extracting the list of profiles from the 'response' key
        List<Map<String, dynamic>> profiles =
            List<Map<String, dynamic>>.from(responseData['response']);
        // Assigning the profiles to profileData
        profileData.assignAll(profiles);
      }
      print(profileData);
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  Future<void> fetchFeeSummary() async {
    try {
      Map<String, dynamic> result = await ApiService.fetchFeeSummary();
      print(result);
      if (result.containsKey('data')) {
        data.assignAll(List<Map<String, dynamic>>.from(result['data']));
      }
      if (result.containsKey('summary')) {
        summary.assignAll(List<Map<String, dynamic>>.from(result['summary']));
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}

class FeesScreen extends StatelessWidget {
  final FeesController feesController = Get.put(FeesController());

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? EColors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: false,
        title: Text(
          'Sem Fees',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () {
                if (feesController.profileData.isEmpty ||
                    feesController.data.isEmpty ||
                    feesController.summary.isEmpty) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        6,
                        (index) => ShimmerItem(),
                      ),
                    ),
                  );
                } else {
                  final profileData = feesController.profileData.first;
                  return Column(
                    children: [
                      AnimationWidget(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          animationType: 'fade',
                          child: ProfileDetail(profileData: profileData)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Divider(),
                      ),
                      const HeaderText(),
                      ...feesController.data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final duration = 180 * (index + 1);
                        return AnimationWidget(
                          duration: Duration(milliseconds: duration),
                          curve: Curves.easeInOut,
                          animationType: 'fade_slide',
                          child: SemesterDetailsCard(data: data),
                        );
                      }).toList(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Divider(),
                      ),
                      SummaryCard(
                        summaryData: feesController.summary.first,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
class FeesScreen extends StatelessWidget {
  final FeesController feesController = Get.put(FeesController());

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? EColors.black : EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        centerTitle: false,
        title: Text(
          'Sem Fees',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () {
                if (feesController.profileData.isEmpty ||
                    feesController.data.isEmpty ||
                    feesController.summary.isEmpty) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        6,
                        (index) => ShimmerItem(),
                      ),
                    ),
                  );
                } else {
                  final profileData = feesController.profileData.first;
                  return Column(
                    children: [
                      AnimationWidget(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          animationType: 'fade',
                          child: ProfileDetail(profileData: profileData)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Divider(),
                      ),
                      const HeaderText(),
                      ...feesController.data.map((data) {
                        return AnimationWidget(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            animationType: 'slide',
                            child: SemesterDetailsCard(data: data));
                      }).toList(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Divider(),
                      ),
                      SummaryCard(
                        summaryData: feesController.summary.first,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/
class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
    required this.profileData,
  });

  final Map<String, dynamic> profileData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          profileData['Profile_photo'] ?? '',
          fit: BoxFit.fill,
          width: 60,
          height: 60,
        ),
      ),
      // leading: Image.network(profileData['Profile_photo'] ?? ''),
      title: Row(
        children: [
          const Text(
            'Hello, ',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Colors.black45,
            ),
          ),
          Text(
            '${profileData['student_name']}',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              //style: Theme.of(context).textTheme.labelSmall!.apply(color: EColors.textColorPrimary1, fontFamily: 'Inter', ),
              color: EColors.textColorPrimary1,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'GNo: ${profileData['GNo']}',
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          color: EColors.textColorPrimary1,
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: const BoxDecoration(
            color: EColors.circleAvatar,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Text(
            'Breakdown of Student Fees by Semester',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: EColors.textColorPrimary1,
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}

class SemesterDetailsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  SemesterDetailsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return DownloadButton(
      onPressed: () {
        if (data["viewmore"] is List && (data["viewmore"] as List).isNotEmpty) {
          Get.to(
            () => ViewMoreScreen(data["viewmore"], data['sem'], data['commit'],
                data['paid'], data['balance']),
            transition: Transition.cupertino,
            duration: const Duration(
                milliseconds: 500), // Adjust the duration as needed
            curve: Curves.easeInOut, // Use a different curve if desired
          );
        } else if (data["viewmore"] is List &&
            (data["viewmore"] as List).isEmpty) {
          Get.snackbar(
            'Empty Fees',
            'Semester ${data['sem']} data is empty.',
            icon: const Icon(Icons.library_books_outlined),
          );
        } else if (data["viewmore"] is Map &&
            (data["viewmore"] as Map).isNotEmpty) {
          Get.to(
            () => ViewMoreScreen(data["viewmore"], data['sem'], data['commit'],
                data['paid'], data['balance']),
            transition: Transition.cupertino,
            duration: const Duration(
                milliseconds: 500), // Adjust the duration as needed
            curve: Curves.easeInOut, // Use a different curve if desired
          );
        } else {
          Get.snackbar('Error', 'Unable to process ViewMore data.');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: darkMode ? EColors.black : const Color(0xFFFFE0E5),
          // color: const Color(0xFFFFE0E5),
          // color: EColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFFC1C5),
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester ${data["sem"]}',
                    // 'Semester ${details['Semester']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: EColors.textColorPrimary1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.payment,
                        color: Colors.pinkAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Sem Fees: ₹${data["commit"]}',
                          // 'Per Semester: ₹${details['Per Semester']}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: EColors.textColorPrimary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.pinkAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Paid Fees: ₹${data["paid"]}',
                          // 'Per Semester: ₹${details['Per Semester']}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: EColors.textColorPrimary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.pinkAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Rest Amount: ₹${data["balance"]}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: EColors.textColorPrimary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: CustomDeco.neoDecoIconRectangle(),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: EColors.backgroundColor,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final Map<String, dynamic> summaryData;

  SummaryCard({required this.summaryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 5),
      decoration: BoxDecoration(
        color: EColors.backgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: EColors.textColorPrimary1,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.payment,
                color: Colors.pinkAccent,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                'Sem Fees: ${summaryData['tcommit']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: EColors.textColorPrimary1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.attach_money,
                color: Colors.pinkAccent,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                'Total Paid: ${summaryData['tpaid']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: EColors.textColorPrimary1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet,
                color: Colors.pinkAccent,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                'Total Balance: ${summaryData['tbal']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: EColors.textColorPrimary1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 12,
                    width: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
