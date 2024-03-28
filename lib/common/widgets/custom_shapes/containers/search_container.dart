import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: EDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(ESizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? EColors.dark
                      : EColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
              border: showBorder
                  ? Border.all(color: EColors.searchContainerBorder)
                  : null),
          child: Row(
            children: [
              const Icon(
                Iconsax.search_normal,
                color: EColors.primary,
              ),
              const SizedBox(
                width: ESizes.spaceBtwSections,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchContainer extends StatelessWidget {
  final TextEditingController? controller;
  final bool showBackground;
  final bool dark;
  final bool showBorder;
  final EdgeInsetsGeometry padding;
  final void Function(String)? onChanged;

  const CustomSearchContainer({
    Key? key,
    this.controller,
    required this.showBackground,
    required this.dark,
    required this.showBorder,
    this.padding = const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurredGlassContainer(
      blurSigma: 10.0, // You can adjust the blur intensity
      child: Padding(
        padding: padding,
        child: Container(
          width: EDeviceUtils.getScreenWidth(context),
          // padding: const EdgeInsets.all(ESizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? EColors.dark
                    : EColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
            border: showBorder
                ? Border.all(color: EColors.searchContainerBorder)
                : null,
          ),
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal, color: EColors.primary),
              hintText: 'Search',
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}


class BlurredGlassContainer extends StatelessWidget {
  final double blurSigma;
  final Widget child;

  const BlurredGlassContainer({
    Key? key,
    this.blurSigma = 10.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: const EdgeInsets.all(6), // Adjust padding as needed
            color: Colors.white.withOpacity(0.1), // Adjust opacity and color as needed
            child: child,
          ),
        ),
      ),
    );
  }
}
