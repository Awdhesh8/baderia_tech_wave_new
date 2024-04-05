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

