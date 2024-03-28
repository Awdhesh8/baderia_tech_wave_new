

/* /// Thi is working fine
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = false; // Replace with your dark mode logic

    return Scaffold(
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBar(
            height: 60,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            indicatorColor: EColors.primary, // No indicator
            backgroundColor: Colors.white,
            destinations: [
              NavigationDestination(
                icon: _buildIcon(Iconsax.home, 'Home', controller, 0),
                label: 'Home',
              ),
              NavigationDestination(
                icon: _buildIcon(
                    Iconsax.calendar_add, 'Time Table', controller, 1),
                label: 'Time Table',
              ),
              NavigationDestination(
                icon: _buildIcon(
                    Iconsax.notification_favorite4, 'Notice', controller, 2),
                label: 'Notice',
              ),
              NavigationDestination(
                icon: _buildIcon(Iconsax.user_edit, 'You', controller, 3),
                label: 'You',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  Widget _buildIcon(
      IconData icon, String label, NavigationController controller, int index) {
    return Stack(
      children: [
        Icon(icon, color: const Color(0xFFFABEC0)), // Unselected color
        Positioned(
          top: -4,
          left: 0,
          child: Container(
            width: 4,
            height: 2,
            color: controller.selectedIndex.value == index
                ? const Color(0xFFFE0037) // Selected color
                : Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const MyHomePage(),
    const TimeTable(),
    const Notice(),
    const SettingsScreen(),
  ];
}
*/

//
// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//      final darkMode = EHelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//           height: 60,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) =>
//               controller.selectedIndex.value = index,
//           indicatorColor: EColors.primary,
//           // indicatorColor: const Color.fromRGBO(250, 170, 147, 100),
//           backgroundColor: Colors.white,
//           // backgroundColor: const Color.fromRGBO(250, 170, 147, 100),
//
//           // backgroundColor: darkMode ? EColors.black : EColors.white,
//           // indicatorColor: darkMode
//           //     ? EColors.white.withOpacity(0.1)
//           //     : EColors.bottomNavigationBar.withOpacity(0.8),
//
//           destinations: const [
//             NavigationDestination(icon: Icon(Iconsax.home,), label: 'Home'),
//             NavigationDestination(icon: Icon(Iconsax.calendar_add), label: 'Time Table'),
//             NavigationDestination(icon: Icon(Iconsax.notification_favorite4), label: 'Notice'),
//             NavigationDestination(icon: Icon(Iconsax.user_edit), label: 'You'),
//           ],
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }
//
// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;
//
//   final screens = [
//     const MyHomePage(),
//     const TimeTable(),
//     const Notice(),
//    const SettingsScreen(),
//   ];
// }