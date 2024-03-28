import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final icon;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //    decoration: BoxDecoration(
        //             boxShadow: [
        //               BoxShadow(
        //                   blurRadius: 0,
        //                   offset: Offset(-2, -2),
        //                   color: Colors.white
        //               )
        //             ],
        //             color: EColors.lightContainer1,
        //             borderRadius: BorderRadius.circular(14)
        //         ),
        decoration: BoxDecoration(
          color: isSelected ? EColors.primarySecond : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(12.0),
          // border: Border.all(
          //   color: Colors.white, // Border color
          //   width: 2.0, // Border width
          // ),
          boxShadow: isSelected
              ? null
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2.0,
              spreadRadius: 1,
                offset: const Offset(2, 2)
            ),
            const BoxShadow(
                color: Colors.white,
                blurRadius: 2.0,
                spreadRadius: 0,
                offset: Offset(-2, -2)
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Adjust padding as needed
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon, size: 10, color: Colors.white,),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// import '../../../../../utils/constants/colors.dart';
//
// class RoundedButton extends StatelessWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onPressed;
//
//   const RoundedButton({
//     Key? key,
//     required this.label,
//     required this.isSelected,
//     required this.onPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(
//           isSelected ? EColors.primarySecond : Colors.grey.shade400,
//         ),
//         shape: MaterialStateProperty.all<OutlinedBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             side: const BorderSide(
//               color: Colors.white, // Border color
//               width: 2.0, // Border width
//             ),
//           ),
//         ),
//         elevation: isSelected ? null : MaterialStateProperty.all(4.0), // Elevation or shadow when selected
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
//
//
//

