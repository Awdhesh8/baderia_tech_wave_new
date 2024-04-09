import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class CVResumeScreen extends StatelessWidget {
  final List<FortuneItem> menuItems = [
    FortuneItem(child: Text('Screen 1')),
    FortuneItem(child: Text('Screen 2')),
    FortuneItem(child: Text('Screen 3')),
    FortuneItem(child: Text('Screen 3')),
    FortuneItem(child: Text('Screen 3')),
    FortuneItem(child: Text('Screen 3')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Handle tap action here
          },
          child: FortuneWheel(
            items: menuItems,
            selected: Stream<int>.empty(), // Placeholder stream
            onFling: () {
              // Add any finishing logic here if needed
            },
          ),
        ),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: Text('Welcome to Screen 1'),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Welcome to Screen 2'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text('Welcome to Screen 3'),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import 'controller/resume_controller.dart';

class CVResumeScreen extends StatelessWidget {
  final CVResumeController controller = Get.put(CVResumeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'CV & Resume',
          style: TextStyle(
            color: EColors.textColorPrimary1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // Button to open bottom sheet
            ElevatedButton(
              onPressed: () {
                _openBottomSheet(context);
              },
              child: Text('Select Inputs'),
            ),
            SizedBox(height: 20),
            // Show selected chips
            Obx(() => Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: controller.selectedChips.map((chip) {
                return Chip(
                  label: Text(chip),
                  onDeleted: () {
                    controller.removeChip(chip);
                  },
                );
              }).toList(),
            )),
            SizedBox(height: 20),
            // Resume Text Fields
            // Generate TextFormField based on selected chips
            Obx(() => Column(
              children: controller.selectedChips.map((chip) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: chip,
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
         // height: 200,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cvInputs.length,
                  itemBuilder: (context, index) {
                    final input = controller.cvInputs[index];
                    return Obx(() => CheckboxListTile(
                      title: Text(input),
                      value: controller.selectedChips.contains(input),
                      onChanged: (value) {
                        if (value != null) {
                          controller.toggleChip(input);
                        }
                      },
                    ));
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }


 */



// Function to open bottom sheet
  // void _openBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Container(
  //             height: 200,
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: ListView.builder(
  //                     itemCount: controller.cvInputs.length,
  //                     itemBuilder: (context, index) {
  //                       final input = controller.cvInputs[index];
  //                       return CheckboxListTile(
  //                         title: Text(input),
  //                         value: controller.selectedChips.contains(input),
  //                         onChanged: (value) {
  //                           if (value != null && value) {
  //                             controller.addChip(input);
  //                           } else {
  //                             controller.removeChip(input);
  //                           }
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('OK'),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }




/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';

class CVResumeScreen extends StatelessWidget {
  const CVResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        title: Text(
          'CV & Resume',
          style: TextStyle(
              color: EColors.textColorPrimary1,
              fontWeight: FontWeight.bold
          ),

        ),
      ),

      /// Body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [

            /// Open Bottom sheet to select multiple chips for the build the text fields below

            /// Resume Text Fields
           TextFormField(
             // decoration: InputDecoration(hintText: '', labelText: '', isDense: true, suffixIcon: Icon(), ),
            // keyboardType: TextInputType.,

           ),

          ],
        ),
      ),

    );
  }
}


 */
