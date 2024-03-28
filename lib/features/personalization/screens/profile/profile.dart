import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GAppBar(
        showBackArrow: true,
        title: Text('Personal Information'),
      ),

      // Body ---
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}

