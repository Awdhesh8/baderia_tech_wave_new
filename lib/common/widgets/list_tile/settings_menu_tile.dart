import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class ESettingsMenuTile extends StatelessWidget {
  const ESettingsMenuTile(
      {super.key,
      this.icon,
      required this.title,
      required this.subTitle,
      this.trailing,
      this.onTap});

  final IconData? icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 0, offset: Offset(-2, -2), color: Colors.white)
            ],
            color: EColors.lightContainer1,
            borderRadius: BorderRadius.circular(14)),
        // decoration: BoxDecoration(
        //   border: Border.all(width: 2, color: Colors.white),
        //   color: EColors.backgroundColor,
        //   // color: Colors.white70,
        //   // color: const Color(0xFFFFE0E5),
        //   borderRadius: BorderRadius.circular(14),
        //   // color: const Color(0xFFFFE0E5),
        //   // boxShadow: const [
        //   //   BoxShadow(
        //   //     color: Colors.white,
        //   //     // color: Color(0xFFFFC1C5),
        //   //     offset: Offset(-2, -2),
        //   //     // offset: Offset(-2, -2),
        //   //     blurRadius: .5,
        //   //     spreadRadius: 0,
        //   //   ),
        //   //   BoxShadow(
        //   //     color: Color(0xFFFFC1C5),
        //   //     // color: Colors.white,
        //   //     offset: Offset(2, 2),
        //   //     // offset: Offset(4, 4),
        //   //     blurRadius: 2,
        //   //     spreadRadius: 0,
        //   //   ),
        //   // ],
        // ),
        child: ListTile(
          dense: true,
          leading: Icon(
            icon,
            size: 24,
            color: EColors.primary,
          ),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis),
          // title: Text(title, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis),
          subtitle: Text(subTitle,
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  // fontWeight: FontWeight.w400,
                  color: EColors.textColorPrimary1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          // subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
          // trailing: const Icon(Iconsax.arrow_right_3, size: 20),
          onTap: onTap,
        ),
      ),
    );
  }
}
