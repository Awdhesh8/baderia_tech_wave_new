import 'package:flutter/material.dart';

class AnimatedSwitcherWidget extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final bool showFirst;
  final int selectedIndex;

  const AnimatedSwitcherWidget({
    required this.firstWidget,
    required this.secondWidget,
    required this.showFirst,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: shouldShowFirst()
          ? firstWidget
          : secondWidget,
    );
  }

  bool shouldShowFirst() {
    return (selectedIndex == 0 || selectedIndex == 10) && showFirst;
  }
}
