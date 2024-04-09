import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/utils/constants/sizes.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/result/widget/animation.dart';
import 'Widgets/subject_details.dart';
import 'controller/controller.dart';

class Syllabus extends StatelessWidget {
  final SyllabusController syllabusController = Get.put(SyllabusController());
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
          'Syllabus',
          style: TextStyleClass.appBarTextStyle,
        ),
      ),
      body: Obx(() {
        if (syllabusController.subjectList.value == null) {
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
                  itemCount: syllabusController.subject.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildBouncyButton(syllabusController.subject[index].id.toString(),syllabusController.subject[index].name.toString());
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }


  Widget buildBouncyButton(String subid,String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the curve as needed
        decoration: BoxDecoration(
          // borderRadius: const BorderRadius.only(
          //   topRight: Radius.circular(22.0),
          //   bottomLeft: Radius.circular(22.0),
          // ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
            //print(subid);
            syllabusController.selectedTabIndex = 0.obs;
            navigateToSyllabusDetailsScreen(subid,label,syllabusController.selectedSem);
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
                      // color: Colors.grey.shade500,
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

                Flexible(
                  child: SizedBox(
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: 'Inter', overflow: TextOverflow.fade, ),
                    ),
                  ),
                ),

                // Text(
                //   label,
                //   style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: 'Inter', overflow: TextOverflow.ellipsis, ),
                // ),

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
      value: syllabusController.currentSem.value,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: EColors.textColorPrimary1),
      ),
      hint: const Text("Select Semester's"),
      onChanged: (String? newValue) async {
        //print(newValue);
        syllabusController.fetchSubject(newValue!);
      },
        //validator: (value) {
        //return null;
        // if (value == null || value.isEmpty) {
        //   return 'Please select a VT Letter Subject';
        // }
        // return null;
        //},
      items: syllabusController.semDropDown.value
    );
  }

}

void navigateToSyllabusDetailsScreen( String SubjectId, String subjectName, String samester) {
  Get.to(() => SubjectDetailsScreen(SubjectId, subjectName, samester));
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
            const SizedBox(height: 20.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 15.0,
                mainAxisExtent: 148,


              ),
              itemCount: 6,
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
