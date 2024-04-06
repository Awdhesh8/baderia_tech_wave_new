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
        if (resultController.subjectList.value == null) {
          return ShimmerLoading();
        }

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
                  itemCount: resultController.subject.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildBouncyButton(resultController.subject[index].id.toString(),resultController.subject[index].name.toString());
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

  Widget buildBouncyButton(String subid,String label) {
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
            print(subid);
            // var semester =  {"2":{2:3}};
            // navigateToExamDetailsScreen(
            //     semester , 'Final Exam');
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
      value: resultController.currentSem.value,
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
        print(newValue);
        resultController.fetchSubject(newValue!);
      },
      //validator: (value) {
        //return null;

        // if (value == null || value.isEmpty) {
        //   return 'Please select a VT Letter Subject';
        // }
        // return null;
      //},

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
