import 'dart:io';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/stack_containers/stack_containers1.dart';
import '../../../../../utils/constants/teext_styles.dart';
import 'controller/training_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Training extends StatelessWidget {
  final TrainingController controller = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Background Color
      backgroundColor: EColors.backgroundColor,

      /// GApp Bar
      appBar: const GAppBar(
        title: Text(
          'Training',
          style: TextStyleClass.appBarTextStyle,
        ),
        centerTitle: false,
        showBackArrow: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Top Heading --->
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Genius Lab',
                      style: TextStyleClass.heading24,
                      children: [
                        TextSpan(text: ' Skill ',style: TextStyle(fontFamily: 'Inter')),
                        TextSpan(
                          text: '\nEnhancement Zone',
                          style: TextStyleClass.heading22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            ///
            Obx(
              () {
                if (controller.isLoading.value) {
                  return _buildLoadingIndicator();
                } else {
                  return _buildTrainingList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrainingList() {
    var currentTrainings =
        controller.trainingData.value['response']['current_training'];
    var completedTrainings =
        controller.trainingData.value['response']['completed_trainings'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(left: 20,top: 10),
        //   child: Text(
        //     'Your Current Trainings',
        //     style: TextStyle(
        //         fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Inter", color: EColors.primary),
        //   ),
        // ),
        const SizedBox(height: 0),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Your Current Training\'s',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Inter", color: EColors.primary),
                  ),
                ),
              ),
              Row(
                children: currentTrainings.map<Widget>((training) {
                  return CurrentTrainingCard(training: training);
                }).toList(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:  Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Completed Trainings',
                    style: TextStyleClass.heading22,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: completedTrainings.map<Widget>((training) {
            return CompletedTrainingCard(training: training);
          }).toList(),
        ),
      ],
    );
  }
}

class CurrentTrainingCard extends StatelessWidget {
  final Map<String, dynamic> training;

  const CurrentTrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    training['training_name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendarAlt,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                      'From: ${training['from_date']} - To: ${training['to_date']}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.lightBlueAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text('Timing: ${training['timing']}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.infoCircle,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text('Status: ${training['status']}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black54,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text('Trainer: ${training['trainer']}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _showAssignmentsBottomSheet(
                          context, training['assignment']);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 218, 218, 1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("Assignments", style: TextStyleClass.buttonStyle1,),
                          ),
                          SizedBox(width: 10),
                          Image.asset('assets/images/assign.png', width: 30),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      _showStudyMaterialsBottomSheet(
                          context, training['study_material']);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 218, 218, 1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("Study Materials", style: TextStyleClass.buttonStyle1,),
                          ),
                          SizedBox(width: 10),
                          Image.asset('assets/images/person.png', width: 20),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAssignmentsBottomSheet(
      BuildContext context, List<dynamic> assignments) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  _buildDragHandle(),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: assignments.length,
                      itemBuilder: (context, index) {
                        var assignment = assignments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                assignment['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Assign Date: ${assignment['assign_date']}'),
                                  Text('Last Date: ${assignment['last_date']}'),
                                  Text(
                                      'Description: ${assignment['description']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.link),
                                    onPressed: () =>
                                        _openLink(assignment['links'][0]),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () => _downloadFile(
                                        assignment['attachments'][0]['link']),
                                  ),
                                ],
                              ),
                            ),
                            if (assignment['attachments'] != null &&
                                assignment['attachments'].isNotEmpty) ...[
                              for (var attachment
                                  in assignment['attachments']) ...[
                                ListTile(
                                  title:
                                      Text('Attachment: ${attachment['name']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () =>
                                        _downloadFile(attachment['link']),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showStudyMaterialsBottomSheet(
      BuildContext context, List<dynamic> studyMaterials) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  _buildDragHandle(),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: studyMaterials.length,
                      itemBuilder: (context, index) {
                        var studyMaterial = studyMaterials[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                studyMaterial['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Description: ${studyMaterial['description']}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.link),
                                onPressed: () =>
                                    _openLink(studyMaterial['links'][0]),
                              ),
                            ),
                            if (studyMaterial['attachments'] != null &&
                                studyMaterial['attachments'].isNotEmpty) ...[
                              for (var attachment
                                  in studyMaterial['attachments']) ...[
                                ListTile(
                                  title:
                                      Text('Attachment: ${attachment['name']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () =>
                                        _downloadFile(attachment['link']),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 50,
        height: 6,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    );
  }

  Future<void> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final fileName = url.substring(url.lastIndexOf('/') + 1);
    final path = await _localPath;
    File file = File('$path/$fileName');
    await file.writeAsBytes(bytes);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CompletedTrainingCard extends StatelessWidget {
  final Map<String, dynamic> training;

  const CompletedTrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    training['training_name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                  'From: ${training['from_date']} - To: ${training['to_date']}'),
              const SizedBox(height: 4),
              Text('Timing: ${training['timing']}'),
              const SizedBox(height: 4),
              Text('Status: ${training['status']}'),
              const SizedBox(height: 4),
              Text('Trainer: ${training['trainer']}'),
            ],
          ),
        ),
      ),
    );
  }
}


/*
ElevatedButton(
                    onPressed: () {
                      _showAssignmentsBottomSheet(
                          context, training['assignment']);
                    },
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon(
                        //   FontAwesomeIcons.tasks,
                        //   size: 16,
                        // ),
                        const Text('Assignments'),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Image.asset('assets/images/assignment.png', width: 30),
                        ),
                      ],
                    ),

                  ),
 */


/*
class CurrentTrainingCard extends StatelessWidget {
  final Map<String, dynamic> training;

  const CurrentTrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    training['training_name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('From: ${training['from_date']} - To: ${training['to_date']}'),
              const SizedBox(height: 4),
              Text('Timing: ${training['timing']}'),
              const SizedBox(height: 4),
              Text('Status: ${training['status']}'),
              const SizedBox(height: 4),
              Text('Trainer: ${training['trainer']}'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _showAssignmentsBottomSheet(context, training['assignment']);
                },
                child: const Text('Assignments'),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  _showStudyMaterialsBottomSheet(context, training['study_material']);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Study Materials"),
                        SizedBox(width: 10,),
                        Transform.rotate(
                            angle: -0.9,
                            child: Icon(Iconsax.arrow_right_2)),
                        // Icon(FontAwesomeIcons.share),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showStudyMaterialsBottomSheet(context, training['study_material']);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Study Materials'),
                    SizedBox(width: 10,),
                    Transform.rotate(
                        angle: -0.9,
                        child: Icon(Iconsax.arrow_right_2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAssignmentsBottomSheet(BuildContext context, List<dynamic> assignments) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  //_buildDragHandle(),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: assignments.length,
                      itemBuilder: (context, index) {
                        var assignment = assignments[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDragHandle(),
                            ListTile(
                              title: Text(
                                assignment['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Assign Date: ${assignment['assign_date']}'),
                                  Text('Last Date: ${assignment['last_date']}'),
                                  Text('Description: ${assignment['description']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.link),
                                    onPressed: () => _openLink(assignment['links'][0]),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () => _downloadFile(assignment['attachments'][0]['link']),
                                  ),
                                ],
                              ),
                            ),
                            if (assignment['attachments'] != null && assignment['attachments'].isNotEmpty) ...[
                              for (var attachment in assignment['attachments']) ...[
                                ListTile(
                                  title: Text('Attachment: ${attachment['name']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () => _downloadFile(attachment['link']),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showStudyMaterialsBottomSheet(BuildContext context, List<dynamic> studyMaterials) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                 // _buildDragHandle(),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: studyMaterials.length,
                      itemBuilder: (context, index) {
                        var studyMaterial = studyMaterials[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDragHandle(),
                            ListTile(
                              title: Text(
                                studyMaterial['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description: ${studyMaterial['description']}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.link),
                                onPressed: () => _openLink(studyMaterial['links'][0]),
                              ),
                            ),
                            if (studyMaterial['attachments'] != null && studyMaterial['attachments'].isNotEmpty) ...[
                              for (var attachment in studyMaterial['attachments']) ...[
                                ListTile(
                                  title: Text('Attachment: ${attachment['name']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.download),
                                    onPressed: () => _downloadFile(attachment['link']),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 50,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
      ),
    );
  }


  Future<void> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final fileName = url.substring(url.lastIndexOf('/') + 1);
    final path = await _localPath;
    File file = File('$path/$fileName');
    await file.writeAsBytes(bytes);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
 */

/// ----
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/teext_styles.dart';
import 'controller/training_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Training extends StatelessWidget {
  final TrainingController controller = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(
        title: Text(
          'Training',
          style: TextStyleClass.appBarTextStyle,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'NFC Training Hub',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
                  () {
                if (controller.isLoading.value) {
                  return _buildLoadingIndicator();
                } else {
                  return _buildTrainingList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrainingList() {
    var currentTrainings = controller.trainingData.value['response']['current_training'];
    var completedTrainings = controller.trainingData.value['response']['completed_trainings'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Current Trainings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: currentTrainings.map<Widget>((training) {
              return CurrentTrainingCard(training: training);
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Completed Trainings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        Column(
          children: completedTrainings.map<Widget>((training) {
            return CompletedTrainingCard(training: training);
          }).toList(),
        ),
      ],
    );
  }
}

class CurrentTrainingCard extends StatelessWidget {
  final Map<String, dynamic> training;

  const CurrentTrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    training['training_name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('From: ${training['from_date']} - To: ${training['to_date']}'),
              const SizedBox(height: 4),
              Text('Timing: ${training['timing']}'),
              const SizedBox(height: 4),
              Text('Status: ${training['status']}'),
              const SizedBox(height: 4),
              Text('Trainer: ${training['trainer']}'),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedTrainingCard extends StatelessWidget {
  final Map<String, dynamic> training;

  const CompletedTrainingCard({required this.training});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    training['training_name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    FontAwesomeIcons.mobileAlt,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('From: ${training['from_date']} - To: ${training['to_date']}'),
              const SizedBox(height: 4),
              Text('Timing: ${training['timing']}'),
              const SizedBox(height: 4),
              Text('Status: ${training['status']}'),
              const SizedBox(height: 4),
              Text('Trainer: ${training['trainer']}'),
            ],
          ),
        ),
      ),
    );
  }
}


 */

/// ---->>>>
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/teext_styles.dart';
import 'controller/training_controller.dart';
import 'package:shimmer/shimmer.dart';

class Training extends StatelessWidget {
  final TrainingController controller = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: Text(
          'Training',
          style: TextStyleClass.appBarTextStyle,
        ),
        showBackArrow: true,
      ),
      body:
      Obx(
            () {
          if (controller.isLoading.value) {
            return _buildLoadingIndicator();
          } else {
            return _buildTrainingList();
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrainingList() {
    var currentTrainings = controller.trainingData.value['response']['current_training'];
    var completedTrainings = controller.trainingData.value['response']['completed_trainings'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          if (currentTrainings != null)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: currentTrainings.map<Widget>((training) {
                  return _buildTrainingCard(training);
                }).toList(),
              ),
            ),
          if (completedTrainings != null)
            Column(
              children: completedTrainings.map<Widget>((training) {
                return _buildTrainingCard(training);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildTrainingCard(Map<String, dynamic> training) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
            children: [
              Text(training['training_name'], style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('From: ${training['from_date']} - To: ${training['to_date']}'),
              SizedBox(height: 4),
              Text('Timing: ${training['timing']}'),
              SizedBox(height: 4),
              Text('Status: ${training['status']}'),
              SizedBox(height: 4),
              Text('Trainer: ${training['trainer']}'),
            ],
          ),
        ),
      ),
    );
  }

}


 */

/*
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

class Training extends StatelessWidget {

 /*
  {
  "response": {
    "current_training": [
      {
        "training_name": "Vocational Training",
        "from_date": "10/04/2024",
        "to_date": "20/04/2024",
        "timing": "11:35 AM - 11:15 AM",
        "status": "13 Days Left 13 & Hours Left: 130",
        "trainer": "Jhon Wick"
      },
      {
        "training_name": "Vocational Training",
        "from_date": "12/04/2024",
        "to_date": "20/04/2024",
        "timing": "01:35 PM - 03:15 PM",
        "status": "11 Days Left 13 & Hours Left: 130",
        "trainer": "Jack jack"
      }
    ],
    "completed_trainings": [
      {
        "training_name": "Vocational Training",
        "from_date": "10/04/2024",
        "to_date": "20/04/2024",
        "timing": "11:35 AM - 11:15 AM",
        "status": "completed",
        "trainer": "Jhon Wick"
      },
      {
        "training_name": "Vocational Training",
        "from_date": "12/04/2024",
        "to_date": "20/04/2024",
        "timing": "01:35 PM - 03:15 PM",
        "status": "Completed",
        "trainer": "Jack jack"
      }
    ]
  }
}
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: Text('Training', style: TextStyleClass.appBarTextStyle,),
        showBackArrow: true,
      ),

      /// Body --->>>
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

            /// Current Trainings --->>>
            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
              child: Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Text('data')
                            ],),
                            Row(children: [ Text('data')],),
                            Row(children: [ Text('data')],),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Text('data')],),
                            Row(children: [ Text('data')],),
                            Row(children: [ Text('data')],),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Completed Trainings
            Column(

              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Text('data')
                          ],),
                          Row(children: [ Text('data')],),
                          Row(children: [ Text('data')],),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Text('data')],),
                          Row(children: [ Text('data')],),
                          Row(children: [ Text('data')],),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}


 */

/*
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  final List<String> _items = [
    "Card 1",
    "Card 2",
    "Card 3",
    "Card 4",
    "Card 5",
  ];

  late List<double> _positions;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _positions = List.generate(_items.length, (index) => index * 50.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: Text(
          'Training',
          style: TextStyleClass.appBarTextStyle,
        ),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: _items.map((item) {
                final index = _items.indexOf(item);
                final isOnTop = index == _currentIndex;
                final itemWidget = _buildCard(item);
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: _positions[index],
                  left: 0,
                  right: 0,
                  height: 300,
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        // Swiped up
                        setState(() {
                          _currentIndex = (_currentIndex + 1).clamp(0, _items.length - 1);
                        });
                      } else if (details.primaryVelocity! > 0) {
                        // Swiped down
                        setState(() {
                          _currentIndex = (_currentIndex - 1).clamp(0, _items.length - 1);
                        });
                      }
                    },
                    child: itemWidget,
                  ),
                );
              }).toList(),
            ),
          ),
          // Add other widgets below the swipin g cards
        ],
      ),
    );
  }

  Widget _buildCard(String item) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(item),
        leading: Icon(FontAwesomeIcons.solidCircle),
      ),
    );
  }
}


 */

/*
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

class Training extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GAppBar(
        title: Text('Training', style: TextStyleClass.appBarTextStyle,),
        showBackArrow: true,
      ),

    );
  }
}



 */
