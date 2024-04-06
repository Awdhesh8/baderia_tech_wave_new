import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Image.asset('assets/Backgrounds/feedback.png'),
            FeedbackForm(),
          ],
        ),
      ),
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
                border: const OutlineInputBorder(),
                errorText: controller.descriptionValidator.value?.text,
              ),
              controller: controller.textEditingController,
              maxLines: 5,
            )),
            const SizedBox(height: 20),
            Text('Give Ratings', style: TextStyleClass.feesSummaryText,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: controller.rating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,

                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    controller.rating.value = rating;
                  },
                ),
              ],
            ),
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

/// without ratings
/*
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
                border: const OutlineInputBorder(),
                errorText: controller.descriptionValidator.value?.text,
              ),
              controller: controller.textEditingController,
              maxLines: 5,
            )),
            const SizedBox(height: 20),
            RatingBar(
            minRating: 1,
            maxRating: 5,
            initialRating: 0,
              allowHalfRating: true,
              // onRatingUpdate: _saveRating,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: Icon(Icons.star_half, color: Colors.amber,),
                empty: Icon(Icons.star_border,color: Colors.black45,)
              ),
              onRatingUpdate: (double value) {  },
              updateOnDrag: true,
              glowRadius: 0,
              glowColor: Colors.amber,
            ),
             //
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
 */

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


/// Animated Rive Ratings
///  // RatingStarsWidget(),
/*
class RatingStarsWidget extends StatefulWidget {
  RatingStarsWidget({Key? key}) : super(key: key);

  @override
  _RatingStarsWidgetState createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
  StateMachineController? controller;
  SMIInput<double>? inputValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 60,
        decoration: BoxDecoration(
           color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),

        child: RiveAnimation.asset(
          'assets/RiveAssets/rating_animation (7).riv',
          // 'assets/RiveAssets/rating_animation.riv',
          onInit: (art) {
            controller = StateMachineController.fromArtboard(
              art,
              "State Machine 1",
            );
            if (controller != null) {
              art.addController(controller!);
              inputValue = controller!.findInput<double>("Rating");
              inputValue?.change(1);
            }
          },
        ),
      ),
    );
  }
}


 */



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
