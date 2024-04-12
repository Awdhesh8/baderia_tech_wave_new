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
      body: Obx(
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