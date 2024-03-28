import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/animations/common_animation.dart';
import 'package:iconsax/iconsax.dart';
import '../../../device/device_utility.dart';
import '../../../features/home/screens/left_circle_menu_and_screens/library/e_library/book_widget/e_book_widget.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class GAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.backgroundColor,
    this.centerTitle,
    this.bottom,
    this.flexibleSpace,
    this.surfaceTintColor = Colors.transparent,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;
  final bool? centerTitle;
  final TabBar? bottom;
  final Widget? flexibleSpace;
  final Color? surfaceTintColor;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? AnimationWidget(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubicEmphasized,
              animationType: 'bubbly',
              child: AnimationWidget(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutCubicEmphasized,
                animationType: 'bubbly',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DownloadButton(
                    onPressed: () => Get.back(),
                    child: IconButton(
                      style: const ButtonStyle(shape: MaterialStatePropertyAll(CircleBorder(side: BorderSide(color: EColors.textSecondaryTitle)))),
                      highlightColor: EColors.grey.withOpacity(.5),
                      onPressed: () => Get.back(),
                      icon: DownloadButton(onPressed: () => Get.back(),
                      child: const Icon(Iconsax.arrow_left)),
                      color: dark ? EColors.primary : EColors.primary,
                    ),
                  ),
                ),
              ),
            )
          : leadingIcon != null
              ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: title,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      actions: actions,
      flexibleSpace: flexibleSpace,
      surfaceTintColor: surfaceTintColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
