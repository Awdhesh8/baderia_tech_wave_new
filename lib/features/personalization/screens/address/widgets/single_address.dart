import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class ESingleAddress extends StatelessWidget {
  const ESingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return ERoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(ESizes.md),
      backgroundColor: selectedAddress ? EColors.primary.withOpacity(0.5) : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : dark ? EColors.darkGrey : EColors.grey,
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
            color: selectedAddress ? dark ? EColors.light : EColors.dark.withOpacity(0.2) : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Graduation/ Diploma',
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: ESizes.sm/2,),
              const Text('High School',maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: ESizes.sm/2,),
              const Text('82356, Timmy coves, South Liana, Maine, 87665, USA', softWrap: true,),
            ],
          ),
        ],
      ),
    );
  }
}
