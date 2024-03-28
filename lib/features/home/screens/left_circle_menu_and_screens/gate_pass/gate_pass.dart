import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/gate_pass/widgets/gate_pass_form_widget/gate_pass_form.dart';
import 'package:baderia_tech_wave/features/home/screens/left_circle_menu_and_screens/gate_pass/widgets/gate_pass_history/gate_pass_history.dart';
import '../../../../../common/widgets/texts/top_first_heading.dart';
import '../../../../../utils/constants/colors.dart';

class GatePass extends StatelessWidget {
  const GatePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: EColors.backgroundColor,

        /// App Bar
        appBar: const GAppBar(
          backgroundColor: Colors.transparent,
          showBackArrow: true,
          title: Text(
            'Gate Pass',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter',
              color: EColors.textColorPrimary1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [

                /// Top Heading
                const TopHeading(
                  fontSize: 20,
                  text: 'Wanderlust Approved:\nGet Your Exit Pass Now!',
                ),

                /// Form
                GatePassForm(),

                /// Divider to separate current Gate Pass application and history
                const Divider(),

                /// Leave application history
                const TopHeading(
                  text: 'Gate Pass History',
                ),

                SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: EColors.backgroundColor,
                    ),
                    child: GatePassHistory(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }




}
