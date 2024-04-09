
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import '../../../../../../data/api/api_services.dart';
import '../controller/controller.dart';

final SyllabusController syllabusController = Get.put(SyllabusController());
class SubjectDetailsScreen extends StatelessWidget {
  final String subjectId;
  final String subjectName;
  final String semester;

  SubjectDetailsScreen(this.subjectId, this.subjectName,this.semester);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        title: Text('Semester: ${semester ?? "NA"}',
          style: TextStyleClass.appBarTextStyle,
        ),
        showBackArrow: true,
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Vertical tabs
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              // color: Colors.red.shade50,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),

            child: ListView.builder(
              itemCount: 5, // Changed itemCount to 5
              itemBuilder: (context, index) {
                return Obx(() {
                  return GestureDetector(
                    onTap: () {
                      syllabusController.changeTabIndex(index);
                      // Add animation here
                      Get.to(
                            () => SubjectDetailsScreen(
                          subjectId,
                          subjectName,
                          semester,
                        ),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: TabItem(
                      text: _getTabText(index), // Util function to get tab text
                      isSelected: syllabusController.selectedTabIndex.value == index,
                    ),
                  );
                });
              },
            ),
          ),
          // Details section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$subjectName',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: EColors.textSecondaryTitle,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Divider(),
                  Expanded(
                    child: Obx(() {
                      var selectedTabIndex =  syllabusController.selectedTabIndex.value;
                      var unit = '${selectedTabIndex+1}';
                      //return getContentForTab(subjectId , unit);
                      return TopicContent(subjectId , unit);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getContentForTab(
      String subjectId, String unit) {
      return TopicContent(subjectId,unit);
  }

  String _getTabText(int index) {
    switch(index) {
      case 0:
        return 'Unit-I';
      case 1:
        return 'Unit-II';
      case 2:
        return 'Unit-III';
      case 3:
        return 'Unit-IV';
      case 4:
        return 'Unit-V';
      default:
        return '';
    }
  }
}

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabItem({
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: RotatedBox(
        quarterTurns: -1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? EColors.textSecondaryTitle : Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class TopicContent extends StatelessWidget {
  final String subjectId;
  final String unit;
  TopicContent(this.subjectId, this.unit);

  @override
  Widget build(BuildContext context) {

      return FutureBuilder(
        future: ApiService.fetchTopicList(
            subjectId, unit),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<String>? topics = snapshot.data;
            return ListView.builder(
              itemCount: topics?.length,
              itemBuilder: (context, index) {
                final topic = topics?[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(FontAwesomeIcons.certificate, color: EColors.grey, size: 18,),
                      SizedBox(width: 5,),
                      Flexible(child: Text(topic!)),
                    ],
                  ),
                )
                /*
                  ListTile(
                  dense: true,
                  leading:Icon(
                    FontAwesomeIcons.fileLines,
                    size: 22.0,
                    color: Colors.grey.shade500,
                  ),
                  title: Text(topic!,
                    //style: TextStyle(height: -0.1),
                  ),
                )

                 */

                ;
              },
            );
          }
        },
      );


  }
}
