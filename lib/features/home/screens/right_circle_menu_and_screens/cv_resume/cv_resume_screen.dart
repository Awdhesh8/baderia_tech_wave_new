import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';

class CVResumeScreen extends StatelessWidget {
  const CVResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
    );
  }
}
