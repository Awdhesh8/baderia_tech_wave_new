import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_contanier.dart';

class EPrimaryHeaderContainer extends StatelessWidget {
  const EPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgeWidget(
      child: Container(
        //color: EColors.lightContainer,
         color: EColors.white,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [

            // Background Custom Shapes
            Positioned(top: 5, right: -85,child: ECircularContainer(backgroundColor: EColors.primarySecond.withOpacity(0.1), height: 40, width: 300,)),
            // Positioned(bottom: 25, right: -85,child: ECircularContainer(backgroundColor: EColors.white, height: 40, width: 240,)),
            Positioned(bottom: 25, right: -85,child: ECircularContainer(backgroundColor: EColors.white, height: 40, width: 240,)),
            // Positioned(bottom: 25, right: -85,child: ECircularContainer(backgroundColor: EColors.white, height: 40, width: 240,)),
            Positioned(top: 45, left: -85,child: ECircularContainer(backgroundColor: EColors.primarySecond.withOpacity(0.1), height: 200, width: 300,)),
            // Positioned(top: 45, left: -85,child: ECircularContainer(backgroundColor: EColors.white, height: 200, width: 300,)),
            Positioned(top: 60, left: -60,child: ECircularContainer(backgroundColor: EColors.primary.withOpacity(0.1), height: 170, width: 250,)),
            // Positioned(top: 60, left: -60,child: ECircularContainer(backgroundColor: Colors.grey.withOpacity(.1), height: 170, width: 250,)),

            // Positioned(top: 25, left: -85,child: ECircularContainer(backgroundColor: EColors.primarySecond.withOpacity(0.1), height: 200, width: 300,)),
            // Positioned(top: 40, left: -65,child: ECircularContainer(backgroundColor: EColors.primarySecond.withOpacity(0.2), height: 170, width: 250,)),


            //Positioned(top: 60, left: -40,child: ECircularContainer(backgroundColor: EColors.primarySecond.withOpacity(0.2), height: 200, width: 200,)),
            // Positioned(top: -150, right: -250,child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1),)),
            // Positioned(top: 100, right: -300,child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1),)),
            child,
          ],
        ),
      ),
    );
  }
}
