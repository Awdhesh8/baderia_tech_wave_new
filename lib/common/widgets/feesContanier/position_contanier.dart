import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../custom_shapes/containers/circular_contanier.dart';
import '../custom_shapes/curved_edges/curved_edges_widget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgeWidget(
      child: Container(
        // color: EColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            // Background Custom Shapes
            Positioned(top: -150, right: -250,child: ECircularContainer(backgroundColor: Colors.pink.shade100.withOpacity(.5),)),
            Positioned(top: 100, right: -300,child: ECircularContainer(backgroundColor: Colors.pinkAccent.shade100.withOpacity(.5),)),
            // Positioned(top: -150, right: -250,child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1),)),
            // Positioned(top: 100, right: -300,child: ECircularContainer(backgroundColor: EColors.textWhite.withOpacity(0.1),)),
            child,
          ],
        ),
      ),
    );
  }
}
