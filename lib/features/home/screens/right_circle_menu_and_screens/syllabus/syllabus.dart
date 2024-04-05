import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/stack_containers/stack_containers.dart';
import '../../../../../common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/sem_details.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animation.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animated_button.dart';
import 'controller/controller.dart';

class Syllabus extends StatelessWidget {
  final SyllabusController resultController = Get.put(SyllabusController());
  final CustomAnimationController animationController =
  Get.put(CustomAnimationController());

  List<String> items = [
    'Applied Mathematics – I',
    'Applied Physics – I',
    'Applied Chemistry – I',
    'Manufacturing Process',
    'Introduction to Computers and Auto CAD',
    'Communication Skills – I',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        showBackArrow: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: EColors.backgroundColor,
        title: Text(
          'Syllabus',
          style: TextStyleClass.appBarTextStyle,
        ),
      ),
      body: Obx(() {
        if (resultController.apiResponse.value == null) {
          return ShimmerLoading();
        }

        var apiResponse = resultController.apiResponse.value!;
        // print(apiResponse);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Top heading
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Academic Syllabus',
                      style: TextStyleClass.heading22,
                      children: [
                        TextSpan(
                          text: '\nExplore Your Self',
                          style: TextStyleClass.subtleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),

            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            /// Sem heading
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Select Semester's",
                      style: TextStyleClass.heading24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: const BoxDecoration(),
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                ),
                child: _buildSemesterDropdown(),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 2.0,
                    mainAxisExtent: 148,
                    //childAspectRatio: 1
                  ),
                  //itemCount: 1,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildBouncyButton(items[index]);
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void navigateToExamDetailsScreen(
      Map<String, dynamic> semester, String examType) {
    Get.to(() => ExamDetailsScreen(semester, examType));
  }

  Widget buildBouncyButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(22.0),
            bottomLeft: Radius.circular(22.0),
          ),
          //borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            var semester =  {"2":{2:3}};
            navigateToExamDetailsScreen(
                semester , 'Final Exam');
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.bookOpenReader,
                      size: 48.0,
                      color: Colors.red.shade100,
                    ),
                    Icon(
                      FontAwesomeIcons.shareFromSquare,
                      size: 28.0,
                      color: Colors.red.shade200,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15, // Adjusted space between the icon and the text
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSemesterDropdown() {

    return DropdownButtonFormField<String>(
      isDense: true,
      value: resultController.CurrentSem.value,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: EColors.textColorPrimary1),
        //errorText:
        //controller.subjectError.value ? 'Select VT Letter Subject' : null,
      ),
      hint: const Text("Select Semester's"),
      onChanged: (String? newValue) async {
        // if (newValue != null) {
        //   controller.subjectController.value =
        //       vtLetterSubject.firstWhere((group) => group.id == newValue);
        //   String selectedSubject = controller.subjectController.value?.id ?? '';
        //   controller.vtSubjectId = selectedSubject.obs;
        //   await controller
        //       .getCompany(); // Wait for the data fetching process to complete
        //   _showMultiSelect(); // Show the bottom sheet after the data is loaded
        // }
      },
      validator: (value) {
        return null;

        // if (value == null || value.isEmpty) {
        //   return 'Please select a VT Letter Subject';
        // }
        // return null;
      },

      items: resultController.semDropDown.value,
    );
  }

}

void navigateToExamDetailsScreen(
    Map<String, dynamic> semester, String examType) {
  Get.to(() => ExamDetailsScreen(semester, examType));
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            const SizedBox(height: 60.0),

            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 15.0),


            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// This Below code is working fine but too many comments in between the codes --->>>
/*
import 'package:get/get.dart';
import 'controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/stack_containers/stack_containers.dart';
import '../../../../../common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/sem_details.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animation.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animated_button.dart';

class Result extends StatelessWidget {
  final ResultController resultController = Get.put(ResultController());
  final CustomAnimationController animationController =
      Get.put(CustomAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        showBackArrow: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: EColors.backgroundColor,
        title: Text(
          'Result',
          style: TextStyleClass.appBarTextStyle,
        ),
      ),
      body: Obx(() {
        if (resultController.apiResponse.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        var apiResponse = resultController.apiResponse.value!;
        // print(apiResponse);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Top heading
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Academic Achievements',
                      style: TextStyleClass.heading22,
                      children: [
                        TextSpan(
                          text: '\nExplore Your Grades',
                          style: TextStyleClass.subtleTextStyle,
                        ),
                        // TextSpan(
                        //   text: '\nResults &',
                        //   style: TextStyleClass.heading22,
                        // ),
                        //  TextSpan(
                        //   text: '\nGrades',
                        //   style: TextStyleClass.heading22,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomBouncyAnimation(
              child: StackContainer(
                child: Container(
                  decoration: CustomDeco.decoRectangle6(),
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(
                      top: 6, right: 4, bottom: 4, left: 4),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons
                                    .graduationCap, // Use Font Awesome icon for graduation cap
                                color: Colors.black, // Icon color
                                size: 20, // Icon size
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Current Semester: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester"] ?? "NA" : "NA"}',
                                style: TextStyleClass.heading24.copyWith(
                                    color: EColors.textSecondaryTitle,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              text: 'CGPA: ',
                              style: TextStyleClass.bodyText3
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      '${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                                  style: TextStyleClass.bodyText3
                                      .copyWith(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons
                                    .infoCircle, // Use Font Awesome icon for info circle
                                color: Colors.grey, // Icon color
                                size: 16, // Icon size
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Text(
                                'Current CGPA: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                                style: TextStyleClass.bodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons
                                    .circleCheck, // Use Font Awesome icon for check circle
                                color: Colors.green, // Icon color
                                size: 16, // Icon size
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Text(
                                'Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_status"] ?? "NA" : "NA"}',
                                style: TextStyleClass.bodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons
                                    .solidBookmark, // Use Font Awesome icon for bookmark
                                color: Colors.yellow, // Icon color
                                size: 16, // Icon size
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Text(
                                'Mid-Term Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["mid_term_status"] ?? "NA" : "NA"}',
                                style: TextStyleClass.bodyText3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons
                                    .flagCheckered, // Use Font Awesome icon for flag checkered
                                color: Colors.blue, // Icon color
                                size: 16, // Icon size
                              ),
                              const SizedBox(
                                  width:
                                      8), // Add some spacing between icon and text
                              Text(
                                'Final Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["final_status"] ?? "NA" : "NA"}',
                                style: TextStyleClass.bodyText3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Icon(
                            FontAwesomeIcons.fileInvoice,
                            color: Colors.black38,
                            // color: Colors.grey.shade200,
                            size: 80,
                          )
                        ],
                      ),
                    ],
                  ),
                  // color: Colors.blue,
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //
                  //     Text(
                  //       'Current Sem: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester"] ?? "NA" : "NA"}',
                  //       style: TextStyleClass.bodyText3,
                  //     ),
                  //     RichText(
                  //       text: TextSpan(
                  //         text: 'CGPA: ',
                  //         style: TextStyleClass.heading24,
                  //         children: [
                  //           // TextSpan(text: ' with '),
                  //           TextSpan(
                  //             text:
                  //             '${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                  //             style: TextStyleClass.bodyText3,
                  //             // style: CustomTextStyle.heading22,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Text(
                  //       'Current CGPA: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                  //       style: TextStyleClass.bodyText3,
                  //     ),
                  //     Text(
                  //       'Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_status"] ?? "NA" : "NA"}',
                  //       style: TextStyleClass.bodyText3,
                  //     ),
                  //     Text(
                  //       'Mid-Term Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["mid_term_status"] ?? "NA" : "NA"}',
                  //       style: TextStyleClass.bodyText3,
                  //     ),
                  //     Text(
                  //       'Final Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["final_status"] ?? "NA" : "NA"}',
                  //       style: TextStyleClass.bodyText3,
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
            /*
            BouncyAnimation(
              child: Container(
                decoration: CustomDeco.decoRectangle(),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16),
                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopHeading(
                      fontSize: 26,
                      text: 'Overall Performance',
                    ),
                    Text(
                      'Current Sem: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester"] ?? "NA" : "NA"}',
                      style: TextStyleClass.bodyText3,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'CGPA: ',
                        style: TextStyleClass.heading24,
                        children: [
                          // TextSpan(text: ' with '),
                          TextSpan(
                            text:
                                '${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                            style: TextStyleClass.bodyText3,
                            // style: CustomTextStyle.heading22,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Current CGPA: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                      style: TextStyleClass.bodyText3,
                    ),
                    Text(
                      'Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["current_semester_status"] ?? "NA" : "NA"}',
                      style: TextStyleClass.bodyText3,
                    ),
                    Text(
                      'Mid-Term Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["mid_term_status"] ?? "NA" : "NA"}',
                      style: TextStyleClass.bodyText3,
                    ),
                    Text(
                      'Final Status: ${apiResponse['overallStatus'].isNotEmpty ? apiResponse['overallStatus'][0]["final_status"] ?? "NA" : "NA"}',
                      style: TextStyleClass.bodyText3,
                    ),
                  ],
                ),
              ),
            ),
             */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),

            /// Sem heading
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Semester's",
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(
                          text: "\nCheck your Grades",
                          style: TextStyleClass.subtleTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: apiResponse['semesters'].length,
                  itemBuilder: (context, index) {
                    var semester = apiResponse['semesters'][index];
                    return CustomBouncyAnimation(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: CustomDeco.decoRectangle5(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Semester ${semester["semester_number"] ?? "NA"}',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                      color: EColors.black),
                                ),
                                const SizedBox(height: 15.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     navigateToExamDetailsScreen(
                                          //         semester, 'Final Exam');
                                          //   },
                                          //   child: const Text('Final Exam'),
                                          // ),

                                          // BouncyElevatedButton(
                                          //   text: 'Final Exam', onPressed: () {
                                          //      navigateToExamDetailsScreen(
                                          //        semester, 'Final Exam');
                                          // },
                                          // ),

                                          BouncyButton(
                                        label: 'Final Exam',
                                        // iconPath: 'assets/icons/navigation.svg',
                                        onPressed: () {
                                          navigateToExamDetailsScreen(
                                              semester, 'Final Exam');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: ESizes.spaceBtwItems,
                                ),
                                // AnimatedButton(text: '', onPressed: (){},),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BouncyButton(
                                        label: 'Mid-Sem   ',
                                        // iconPath: 'assets/icons/navigation.svg',
                                        onPressed: () {
                                          navigateToExamDetailsScreen(
                                              semester, 'Mid-Sem   ');
                                        },
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     navigateToExamDetailsScreen(
                                      //         semester, 'Mid-Term Exam');
                                      //   },
                                      //   child: const Text('Mid-Term Exam'),
                                      // ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void navigateToExamDetailsScreen(
      Map<String, dynamic> semester, String examType) {
    Get.to(() => ExamDetailsScreen(semester, examType));
  }
}
*/

/// Correct Code ----- for Exam details screen
/*
class ExamDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> semester;
  final String examType;
  final CustomAnimationController animationController =
      Get.put(CustomAnimationController());

  ExamDetailsScreen(this.semester, this.examType);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> examData;

    if (examType == 'Final Exam') {
      examData = semester['final_exam'];
    } else {
      examData = semester['mid_term_exam'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$examType Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text('Result: ${examData["result"] ?? "NA"}',
               style: TextStyle(fontSize: 18.0)),
           SizedBox(height: 8.0),
           Text(
               'SGPA: ${examData["theoretical_result"]["current_semester_sgpa"] ?? "NA"}',
               style: TextStyle(fontSize: 18.0)),
           SizedBox(height: 8.0),
           Text('Subjects:',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
           for (var subject
           in examData["theoretical_result"]["subjects"] ?? [])
             Text(
               '${subject["name"]}: ${subject["grade"]} (${subject["status"]})',
               style: TextStyle(fontSize: 16.0),
             ),
            SizedBox(height: 16),
            Text(
                'Practical Result: ${examData["practical_result"]["result"] ?? "NA"}',
                style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text(
                'SGPA: ${examData["practical_result"]["current_semester_sgpa"] ?? "NA"}',
                style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Practical Subjects:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            for (var subject in examData["practical_result"]["subjects"] ?? [])
              Text(
                '${subject["name"]}: ${subject["status"]}',
                style: TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
 */

/*
import 'package:flutter/material.dart';
import '../../../../../data/api/api_services.dart';
import 'dart:convert';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, dynamic>? _apiResponse;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      String result = await ApiService.getAllResults();
      Map<String, dynamic> jsonResponse = json.decode(result);
      setState(() {
        _apiResponse = jsonResponse['response'];
      });
    } catch (error) {
      print("Error fetching results: $error");
      // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: _apiResponse == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text(
                        'Overall Status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester"] ?? "NA" : "NA"}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Overall Status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'current sem status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester_status"] ?? "NA" : "NA"}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Mid Term status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["mid_term_status"] ?? "NA" : "NA"}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Final status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["final_status"] ?? "NA" : "NA"}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: _apiResponse!['semesters'].length,
                    itemBuilder: (context, index) {
                      var semester = _apiResponse!['semesters'][index];
                      return Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'Semester ${semester["semester_number"] ?? "NA"}',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  navigateToExamDetailsScreen(
                                      semester, 'Final Exam');
                                },
                                child: const Text('Final Exam'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  navigateToExamDetailsScreen(
                                      semester, 'Mid-Term Exam');
                                },
                                child: const Text('Mid-Term Exam'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void navigateToExamDetailsScreen(
      Map<String, dynamic> semester, String examType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamDetailsScreen(semester, examType),
      ),
    );
  }
}

class ExamDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> semester;
  final String examType;

  ExamDetailsScreen(this.semester, this.examType);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> examData;

    if (examType == 'Final Exam') {
      examData = semester['final_exam'];
    } else {
      examData = semester['mid_term_exam'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$examType Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[
            Text('Result: ${examData["result"] ?? "NA"}'),
            Text(
                'SGPA: ${examData["theoretical_result"]["current_semester_sgpa"] ?? "NA"}'),
            const Text('Subjects:'),
            for (var subject
                in examData["theoretical_result"]["subjects"] ?? [])
              Text(
                '${subject["name"]}: ${subject["grade"]} (${subject["status"]})',
              ),
            const SizedBox(height: 16),
            Text(
                'Practical Result: ${examData["practical_result"]["result"] ?? "NA"}'),
            Text(
                'SGPA: ${examData["practical_result"]["current_semester_sgpa"] ?? "NA"}'),
            const Text('Practical Subjects:'),
            for (var subject in examData["practical_result"]["subjects"] ?? [])
              Text(
                '${subject["name"]}: ${subject["status"]}',
              ),
          ],
        ],
      ),
    );
  }
}
*/

// import 'package:flutter/material.dart';
// import '../../../../../data/api/api_services.dart';
// import 'dart:convert';
//
// class Result extends StatefulWidget {
//   @override
//   _ResultState createState() => _ResultState();
// }
//
// class _ResultState extends State<Result> {
//   Map<String, dynamic>? _apiResponse;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchResults();
//   }
//
//   Future<void> fetchResults() async {
//     try {
//       String result =
//           await ApiService.getAllResults();
//       Map<String, dynamic> jsonResponse = json.decode(result);
//       setState(() {
//         _apiResponse = jsonResponse['response'];
//       });
//     } catch (error) {
//       print("Error fetching results: $error");
//       // Handle error gracefully
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Result Screen'),
//       ),
//       body: _apiResponse == null
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: EdgeInsets.all(16.0),
//             color: Colors.blue,
//             child: Column(
//               children: [
//                 Text(
//                   'Overall Status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester"] ?? "NA" : "NA"}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                  Text(
//                   'Overall Status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester_cgpa"] ?? "NA" : "NA"}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                  Text(
//                   'current sem status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["current_semester_status"] ?? "NA" : "NA"}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   'Mid Term status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["mid_term_status"] ?? "NA" : "NA"}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   'Final status: ${_apiResponse!["overallStatus"].isNotEmpty ? _apiResponse!["overallStatus"][0]["final_status"] ?? "NA" : "NA"}',
//                   style: TextStyle(color: Colors.white),
//                 ),
//
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: _apiResponse!['semesters'].length,
//               itemBuilder: (context, index) {
//                 if (_apiResponse!['semesters'].isNotEmpty) {
//                   var semester = _apiResponse!['semesters'][index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SemesterDetailsScreen(semester),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       color: Colors.grey[200],
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: Text(
//                           'Semester ${semester["semester_number"] ?? "NA"}',
//                           style: TextStyle(fontSize: 18.0),
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Container(); // Return an empty container if the list is empty
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SemesterDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> semesterData;
//
//   SemesterDetailsScreen(this.semesterData);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Semester ${semesterData["semester_number"]} Details'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Final Exam Details'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Result: ${semesterData["final_exam"]["result"]}'),
//                         Text(
//                             'SGPA: ${semesterData["final_exam"]["theoretical_result"]["current_semester_sgpa"]}'),
//                         Text('Subjects:'),
//                         // Display details for each subject
//                         for (var subject in semesterData["final_exam"]["theoretical_result"]["subjects"])
//                           Text(
//                             '${subject["name"]}: ${subject["grade"]} (${subject["status"]})',
//                           ),
//                         SizedBox(height: 16),
//                         Text('Practical Result: ${semesterData["final_exam"]["practical_result"]["result"]}'),
//                         Text(
//                             'SGPA: ${semesterData["final_exam"]["practical_result"]["current_semester_sgpa"]}'),
//                         Text('Practical Subjects:'),
//                         // Display details for each practical subject
//                         for (var subject in semesterData["final_exam"]["practical_result"]["subjects"])
//                           Text(
//                             '${subject["name"]}: ${subject["status"]}',
//                           ),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text('Close'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text('Final Exam'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Mid-Term Exam Details'),
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                             'Result: ${semesterData["mid_term_exam"]["result"]}'),
//                         Text(
//                             'SGPA: ${semesterData["mid_term_exam"]["theoretical_result"]["current_semester_sgpa"]}'),
//                         Text('Subjects:'),
//                         // Display details for each subject
//                         for (var subject in semesterData["mid_term_exam"]["theoretical_result"])
//                           Text(
//                             '${subject["name"]}: ${subject["grade"]} (${subject["status"]})',
//                           ),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text('Close'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text('Mid-Term Exam'),
//           ),
//         ],
//       ),
//     );
//   }
// }

/*
import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';

class Result extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Your Results',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            /// Display overallStatus


          ],
        ),
      ),
    );
  }
}

 */

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/exam_result.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import 'controller/controller.dart';
import 'model/model.dart';

class Result extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Your Results',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () {
                final List<OverallStatus> overallStatusList =
                    studentController.studentModel.value.overallStatus;

                OverallStatus overallStatus = OverallStatus(
                  currentSemester: '',
                  currentSemesterCgpa: 0,
                  currentSemesterStatus: '',
                  midTermStatus: '',
                  finalStatus: '',
                );

                if (overallStatusList.isNotEmpty) {
                  overallStatus = overallStatusList.first;
                }

                return Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Semester: ${overallStatus.currentSemester}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text('SGPA: ${overallStatus.currentSemesterCgpa}'),
                      const SizedBox(height: 10.0),
                      Text(
                          'Current Semester Status: ${overallStatus.currentSemesterStatus}'),
                      const SizedBox(height: 10.0),
                      Text('Mid Term Status: ${overallStatus.midTermStatus}'),
                      const SizedBox(height: 10.0),
                      Text('Final Status: ${overallStatus.finalStatus}'),
                    ],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Semesters',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () {
                final List<Semester> semesters =
                    studentController.studentModel.value.semesters;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .98,
                  ),
                  itemCount: semesters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the semester result screen passing the semester data
                        // Get.to(() => SemesterResultScreen(semester: semesters[index]));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Semester ${semesters[index].semesterNumber}',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to the final exam result screen passing the final exam data
                                          Get.to(
                                            () => ExamResultScreen(
                                              exam: semesters[index].finalExam,
                                              semester: semesters[index],
                                              examType: 'Final Exam',
                                              sgpa: 'fdff',
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Final',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to the mid term exam result screen passing the mid term exam data
                                          Get.to(() => ExamResultScreen(
                                                exam: semesters[index]
                                                    .finalExam,
                                                semester: semesters[index],
                                                examType: 'Mid Term Exam',
                                                sgpa: '',
                                              ));
                                        },
                                        child: const Text(
                                          'Mid Sem',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


 */

// https://jsonlint.com

///
// class ExamResultScreen extends StatelessWidget {
//   final Exam exam;
//   final Semester semester;
//   final String examType;
//
//   ExamResultScreen({required this.exam, required this.semester, required this.examType});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GAppBar(
//         title: Text(examType),
//         showBackArrow: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Semester ${semester.semesterNumber} Results'),
//             Text('Result: ${exam.result}'),
//             Text('Theoretical Result: ${exam.theoreticalResult.result}'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: exam.theoreticalResult.subjects.map((subject) {
//                 return Text('${subject.name}: ${subject.grade}');
//               }).toList(),
//             ),
//             Text('Practical Result: ${exam.practicalResult.result}'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: exam.practicalResult.subjects.map((subject) {
//                 return Text('${subject.name}: ${subject.status}');
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///
/*
// class SemesterResultScreen extends StatelessWidget {
//   final Semester semester;
//
//   SemesterResultScreen({required this.semester});
//
//   @override
//   Widget build(BuildContext context) {
//     // Implement your UI to display semester results using the 'semester' object
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Semester ${semester.semesterNumber} Results'),
//       ),
//       body: Center(
//         child: Text('Semester ${semester.semesterNumber} Results'),
//       ),
//     );
//   }
// }
 */

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animation.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/sem_container.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../utils/constants/colors.dart';
import 'controller/controller.dart';

class Result extends StatelessWidget {
  const Result({Key? key});

  @override
  Widget build(BuildContext context) {
    final ResultController resultController = Get.put(ResultController());
    final CustomAnimationController animationController =
        Get.put(CustomAnimationController());

    return Scaffold(
      backgroundColor: EColors.backgroundColor,

      /// App Bar
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'Your Results',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      /// Body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Overall Status Card
              CustomAnimation(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: CustomDeco.decoRectangle(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopHeading(
                        fontSize: 26,
                        text: 'Overall Performance',
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              color: EColors.textColorPrimary1,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Semester-wise Results
              Obx(
                () => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 170,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: resultController.results.length,
                  itemBuilder: (context, index) {
                    final result = resultController.results[index];
                    return CustomAnimation(
                      child: SemContainer(result: result),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
 */

///========
/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SyllabusScreen extends StatelessWidget {
  final List<String> subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Computer Science',
    'English',
    // Add more subjects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syllabus'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigate to syllabus details screen for the selected subject
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SyllabusDetailsScreen(subject: subjects[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.bookOpen,
                      size: 48.0,
                      color: Colors.blue,
                    ),
                    Text(
                      subjects[index],
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Units: 10',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SyllabusDetailsScreen extends StatelessWidget {
  final String subject;

  SyllabusDetailsScreen({required this.subject});

  // Dummy syllabus content
  final String syllabusContent = """
  This is a dummy syllabus content for .
  You can replace it with the actual syllabus content.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              syllabusContent.replaceAll('subject', subject),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

 */