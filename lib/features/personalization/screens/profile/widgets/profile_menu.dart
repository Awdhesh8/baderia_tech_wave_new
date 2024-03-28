import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';

class EProfileMenu extends StatelessWidget {
  const EProfileMenu({
    super.key,
    required this.onPressed,
    required this.value,
    required this.title,
    this.icon,
  });

  final IconData? icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  textAlign: TextAlign.end,
                  value,
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                )),
            // Expanded(
            //   child: Icon(
            //     icon,
            //     size: 18,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
