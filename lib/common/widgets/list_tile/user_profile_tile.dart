import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/e_circular_image.dart';

class EUserProfileTile extends StatelessWidget {
  const EUserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius:BorderRadius.circular(100),
        child: Image.asset(
          EImages.userIcon,
          fit: BoxFit.cover,
          width: 60,
          height: 60,
        ),
      ),
      title: Text('Elon Musk', style: Theme.of(context).textTheme.headlineSmall!.apply(color: EColors.white),),
      subtitle: Text('G/2023/Engg/CS/56', style: Theme.of(context).textTheme.headlineSmall!.apply(color: EColors.white),),
      // trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: EColors.white,), ),
    );
  }
}

