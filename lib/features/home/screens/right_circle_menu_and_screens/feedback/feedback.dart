import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import 'controller/feedback_controller.dart';


class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(
        showBackArrow: true,
        title: Text("Feedback", style: TextStyleClass.appBarTextStyle,),
      ),
      body: FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatelessWidget {
  final FeedbackFormController controller = Get.put(FeedbackFormController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => controller.showBottomSheet(context),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.selectedTopic.value.isEmpty
                      ? 'Select Topic'
                      : controller.selectedTopic.value),
                  const Icon(Icons.arrow_drop_down)
                ],
              )),
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
              onChanged: (value) {
                controller.description.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
                errorText: controller.descriptionValidator.value?.text,
              ),
              controller: controller.textEditingController,
              maxLines: 5,
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.submitFeedback(context),
              child: const Text('Submit Feedback'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// Define the FeedbackBottomSheet widget
class FeedbackBottomSheet extends StatelessWidget {
  final Function(String) onSelectTopic;

  FeedbackBottomSheet({required this.onSelectTopic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index]),
            onTap: () {
              onSelectTopic(topics[index]);
            },
          );
        },
      ),
    );
  }
}

// Dummy list of topics
List<String> topics = ['Teachers', 'About', 'Study', 'Timings', 'Other'];



/*
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/right_circle_menu_and_screens/feedback/widgets/bottom_sheet.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';


class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        title: Text("Feedback", style: TextStyleClass.appBarTextStyle),
        showBackArrow: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}


 */
