import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class ESettingsMenuTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final Icon icon;

  const ESettingsMenuTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      iconColor: EColors.primary,
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: onTap,
    );
  }
}
