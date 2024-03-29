// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
// import 'package:baderia_tech_wave/features/home/screens/profile_card/profile_box.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
// import '../../../Circular Menus/circular_menus_with_circle.dart';
// import 'left_circle_menu_and_screens/fees/fees_contanier/fees_container.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: GAppBar(
//         showBackArrow: false,
//         title: Image.asset(
//           'assets/logo/global_college_logo.png',
//           width: 105,
//         ),
//         backgroundColor: EColors.primary,
//         centerTitle: true,
//       ),
//       body:  SingleChildScrollView(
//         child: Column(
//           children: [
//             const CircularMenuWithCircle(),
//             const ProfileBox(),
//             // FeesContainer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/profile_box.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../../Circular Menus/circular_menus_with_circle.dart';
import '../../../data/api/api_services.dart';
import '../widgets/animation_switcher/hide_show_animation.dart';
import 'left_circle_menu_and_screens/fees/fees_card/fees_card_contanier.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = -1;
  bool showFeesCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        showBackArrow: false,
        title: Image.asset(
          'assets/logo/global_college_logo.png',
          width: 105,
        ),
        backgroundColor: EColors.primary,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Backgrounds/back11.png"),
            fit: BoxFit.contain,
            opacity: .1,
            alignment: FractionalOffset(0, 1.4),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircularMenuWithCircle(
                onIndexChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                    toggleFeesCardAndProfileBox();
                  });
                },
              ),
              AnimatedSwitcherWidget(
                firstWidget: FeesCard(),
                secondWidget: const ProfileBox(),
                showFirst: showFeesCard,
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );

  }

  void toggleFeesCardAndProfileBox() {
    setState(() {
      // Toggle between FeesCard and ProfileBox for index 0 or 10, hide for others
      if (selectedIndex == 0 || selectedIndex == 10) {
        showFeesCard = !showFeesCard;
      }
    });
  }
}


/// Correct Code
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/profile_box.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import '../../../Circular Menus/circular_menus_with_circle.dart';
import '../../../data/api/api_services.dart';
import '../widgets/animation_switcher/hide_show_animation.dart';
import 'left_circle_menu_and_screens/fees/fees_card/fees_card_contanier.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = -1;
  bool showFeesCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFFE0E5),

       // backgroundColor: EColors.backgroundColor,
      appBar: GAppBar(
        showBackArrow: false,
        title: Image.asset(
          'assets/logo/global_college_logo.png',
          width: 105,
        ),
        backgroundColor: EColors.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircularMenuWithCircle(
              onIndexChanged: (index) {
                setState(() {
                  selectedIndex = index;
                  toggleFeesCardAndProfileBox();
                });
              },
            ),
            AnimatedSwitcherWidget(
              firstWidget: FeesCard(),
              secondWidget: const ProfileBox(),
              showFirst: showFeesCard,
              selectedIndex: selectedIndex,
            ),
          ],
        ),
      ),
    );
  }

  void toggleFeesCardAndProfileBox() {
    setState(() {
      // Toggle between FeesCard and ProfileBox for index 0 or 10, hide for others
      if (selectedIndex == 0 || selectedIndex == 10) {
        showFeesCard = !showFeesCard;
      }
    });
  }
}


 */


