/*
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //       // --- Header ---
      //       EPrimaryHeaderContainer(
      //         child: Column(
      //         children: [
      //           GAppBar(title: Text('Profile Details', style: Theme.of(context).textTheme.headlineMedium!.apply(color: EColors.white),),),
      //        const SizedBox(height: ESizes.spaceBtwItems,),
      body: ProfileScreenTest()

      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //
      //       // --- Header ---
      //       EPrimaryHeaderContainer(
      //         child: Column(
      //         children: [
      //           GAppBar(title: Text('Profile Details', style: Theme.of(context).textTheme.headlineMedium!.apply(color: EColors.white),),),
      //        const SizedBox(height: ESizes.spaceBtwItems,),
      //
      //           // User Profile Card
      //           const EUserProfileTile(
      //             // onPressed: () => Get.to(() => const ProfileScreen()),
      //           ),
      //           const SizedBox(height: ESizes.spaceBtwSections,),
      //
      //         ],
      //       ),
      //       ),
      //
      //       // Body ---
      //       Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
      //       child: Column(
      //         children: [
      //
      //           // --- Account Settings ---
      //            const ESectionHeading(title: 'Personal Details', showActionButton: false,),
      //            const SizedBox(height: ESizes.spaceBtwItems,),
      //
      //           const ESettingsMenuTile(icon: Iconsax.clipboard_text, title: 'G No', subTitle: 'G/2023/POLY/CS/56',
      //             // onTap: () => Get.to(() => const UserAddressScreen()),
      //           ),
      //           ESettingsMenuTile(icon: Iconsax.clipboard_text, title: 'Enrollment No', subTitle: '2023CS45PO565', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.profile_2user, title: 'Father Name', subTitle: 'Your Father Name', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.profile_2user, title: 'Mothers Name', subTitle: 'Your Mother Name', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.cake, title: 'Date Of Birth', subTitle: '01/01/2024', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.call, title: 'Contact Number', subTitle: '+91 9998887770', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.call_calling, title: 'Parent Contact', subTitle: '+91 9898987744', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.book_1, title: 'Course', subTitle: 'Polytechnic Diploma', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.hierarchy_2, title: 'Branch', subTitle: 'Computer Science', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.card, title: 'Email', subTitle: '482001, Jabalpur,Madhya Pradesh', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.location, title: 'Address', subTitle: '482001, Jabalpur,Madhya Pradesh', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.location, title: 'Address', subTitle: '482001, Jabalpur,Madhya Pradesh', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.location, title: 'Address', subTitle: '482001, Jabalpur,Madhya Pradesh', onTap: () {},),
      //           ESettingsMenuTile(icon: Iconsax.location, title: 'Address', subTitle: '482001, Jabalpur,Madhya Pradesh', onTap: () {},),
      //
      //
      //           // -- App Settings ---
      //           const SizedBox(height: ESizes.spaceBtwSections,),
      //           const ESectionHeading(title: 'App Settings', showActionButton: false,),
      //           const SizedBox(height: ESizes.spaceBtwItems,),
      //           const ESettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase'),
      //
      //           // Switch's --
      //           ESettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subTitle: 'Set recommendation based on location',trailing: Switch(value: true, onChanged: (value){},),),
      //           ESettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is safe for all ages',trailing: Switch(value: false, onChanged: (value){},),),
      //           ESettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be seen',trailing: Switch(value: false, onChanged: (value){},),),
      //
      //
      //         // --- Logout Button ---
      //           const SizedBox(height: ESizes.spaceBtwSections,),
      //           SizedBox(
      //             width: double.infinity,
      //             child: OutlinedButton(onPressed: (){},child: const Text('Logout'),),
      //           ),
      //           const SizedBox(height: ESizes.spaceBtwSections * 2.5,),
      //         ],
      //       ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}



class ProfileScreenTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user_image.png'), // Replace with user image
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        showBackArrow: false, // Or set as needed
        backgroundColor: Colors.blue, // Change color as needed
        bottom: TabBar(
          tabs: [
            Tab(text: 'Profile'),
            Tab(text: 'Educational Details'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ProfileDetailsTab(),
          EducationalDetailsTab(),
        ],
      ),
    );
  }
}

class ProfileDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add profile details here
          Text('Profile Details'),
        ],
      ),
    );
  }
}

class EducationalDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add educational details here
          Text('Educational Details'),
        ],
      ),
    );
  }
}


*/



// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/common/widgets/custom_shapes/containers/primary_header_container.dart';
// import '../../../../common/widgets/appbar/appbar.dart';
// import '../../../../common/widgets/appbar/tabbar.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/helpers/helper_functions.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (_, innerBoxScrolled) {
//             return [
//               SliverAppBar(
//                 automaticallyImplyLeading: false,
//                 pinned: true,
//                 floating: true,
//                 backgroundColor: EHelperFunctions.isDarkMode(context)
//                     ? EColors.black
//                     : EColors.white,
//                 expandedHeight: 240,
//                 flexibleSpace: ListView(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//
//                     // --- Header ---
//                     EPrimaryHeaderContainer(
//                       child: Column(
//                         children: [
//                           GAppBar(
//                             title: Text(
//                               'Profile Details',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineMedium!
//                                   .apply(color: EColors.white),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: ESizes.spaceBtwItems,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 // Tabs --- >
//                 bottom: const ETabBar(
//                   tabs: [
//                     Tab(
//                       child: Text('Personal Details'),
//                     ),
//                     Tab(
//                       child: Text('Educational Details'),
//                     ),
//                   ],
//                 ),
//               ),
//             ];
//
//             // --- Body ---
//           },
//           body: const TabBarView(
//             children: [
//               ProfileDetailsTab(),
//               EducationalDetailsTab(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProfileDetailsTab extends StatelessWidget {
//   const ProfileDetailsTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Add profile details here
//           Text('Profile Details'),
//         ],
//       ),
//     );
//   }
// }
//
// class EducationalDetailsTab extends StatelessWidget {
//   const EducationalDetailsTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Add educational details here
//           Text('Educational Details'),
//         ],
//       ),
//     );
//   }
// }

/*

import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileScreenTest(),
    );
  }
}

class ProfileScreenTest extends StatefulWidget {
  const ProfileScreenTest({super.key});

  @override
  _ProfileScreenTestState createState() => _ProfileScreenTestState();
}

class _ProfileScreenTestState extends State<ProfileScreenTest>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GAppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user_image.png'), // Replace with user image
              radius: 20,
            ),
            SizedBox(width: 10),
            Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        showBackArrow: false,
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Educational Details'),
          ],
          onTap: (index) {
            _tabController.animateTo(index);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProfileDetailsTab(),
          EducationalDetailsTab(),
        ],
      ),
    );
  }
}

class ProfileDetailsTab extends StatelessWidget {
  const ProfileDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Profile Details'),
          // Add profile details here
        ],
      ),
    );
  }
}

class EducationalDetailsTab extends StatelessWidget {
  const EducationalDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Educational Details'),
          // Add educational details here
        ],
      ),
    );
  }
}

*/


/// ------> New

// import 'package:flutter/material.dart';
//
// import '../../../../common/widgets/appbar/appbar.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: GAppBar(
//         showBackArrow: false,
//         title: Text(
//           'Account',
//           style: TextStyle(
//               fontSize: ESizes.appTitle,
//               color: EColors.white,
//               fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: EColors.primary,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }

/// --->

//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const GAppBar(
//         showBackArrow: false,
//         title: Text(
//           'Account',
//           style: TextStyle(
//               fontSize: ESizes.appTitle,
//               color: EColors.white,
//               fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: EColors.primary,
//         centerTitle: true,
//       ),
//
//       // Body ---
//       body: Column(
//         children: [
//           Expanded(child: TimetableScreen()),
//         ],
//       )
//     );
//   }
// }

/*
class SettingsController extends GetxController {
  RxList<bool> isExpandedList = RxList<bool>();

  @override
  void onInit() {
    super.onInit();
    // Initialize isExpandedList with false for each item
    isExpandedList.assignAll(List.generate(educationalDetails.length, (index) => false));
  }

  void toggleExpansion(int panelIndex, bool isExpanded) {
    isExpandedList[panelIndex] = !isExpanded;
    update(); // Trigger UI update
  }
}

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

   SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        showBackArrow: false,
        title: Text(
          'Account',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: EColors.primary,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                children: [
                  TopHeading(
                    text: 'Hello,',
                    fontSize: 20,
                  ),
                  Text(' Surya Pratap Singh', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      EImages.userIcon,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            // Add the TabBar here
            const TabBar(
              tabs: [
                Tab(text: 'Profile Details'),
                Tab(text: 'Educational Details'),
              ],
            ),
            // Add the TabBarView here
            Expanded(
              child: TabBarView(
                children: [
                  UserDetails(data: personalDetails),
                  GetBuilder<SettingsController>(
                    builder: (_) => EducationDetailsPanel(
                      educationalDetails: educationalDetails,
                      isExpandedList: controller.isExpandedList,
                      onExpansionChanged: (index, isExpanded) =>
                          controller.toggleExpansion(index, isExpanded),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class UserDetails extends StatelessWidget {
//   final Map<String, String> data;
//
//   const UserDetails({Key? key, required this.data, })
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       child: ListView(
//         shrinkWrap: true,
//         physics: const BouncingScrollPhysics(),
//         children: data.entries.map((entry) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: ESettingsMenuTile(
//               title: entry.key,
//               subTitle: entry.value,
//               onTap: () {
//                 // Add any onTap functionality here if needed
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

 */

///
/// // // import 'package:flutter/material.dart';
// // //
// // // import '../../../../common/widgets/appbar/appbar.dart';
// // // import '../../../../utils/constants/colors.dart';
// // // import '../../../../utils/constants/sizes.dart';
// // //
// // // class SettingsScreen extends StatelessWidget {
// // //   const SettingsScreen({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return const Scaffold(
// // //       appBar: GAppBar(
// // //         showBackArrow: false,
// // //         title: Text(
// // //           'Account',
// // //           style: TextStyle(
// // //               fontSize: ESizes.appTitle,
// // //               color: EColors.white,
// // //               fontWeight: FontWeight.w600),
// // //         ),
// // //         backgroundColor: EColors.primary,
// // //         centerTitle: true,
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //
// // //
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:baderia_tech_wave/common/widgets/texts/top_first_heading.dart';
// // import '../../../../common/widgets/appbar/appbar.dart';
// // import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
// // import '../../../../utils/constants/colors.dart';
// // import '../../../../utils/constants/image_strings.dart';
// //
// //
// // //
// // // class SettingsScreen extends StatelessWidget {
// // //   const SettingsScreen({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: const GAppBar(
// // //         showBackArrow: false,
// // //         title: Text(
// // //           'Account',
// // //           style: TextStyle(
// // //               fontSize: ESizes.appTitle,
// // //               color: EColors.white,
// // //               fontWeight: FontWeight.w600),
// // //         ),
// // //         backgroundColor: EColors.primary,
// // //         centerTitle: true,
// // //       ),
// // //
// // //       // Body ---
// // //       body: Column(
// // //         children: [
// // //           Expanded(child: TimetableScreen()),
// // //         ],
// // //       )
// // //     );
// // //   }
// // // }
// // class SettingsScreen extends StatefulWidget {
// //   const SettingsScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<SettingsScreen> createState() => _SettingsScreenState();
// // }
// //
// // class _SettingsScreenState extends State<SettingsScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: EColors.backgroundColor,
// //       appBar: const GAppBar(
// //         showBackArrow: false,
// //         title: Text(
// //           'Account',
// //           style: TextStyle(
// //             fontSize: 20.0,
// //             color: Colors.white,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         backgroundColor: EColors.primary,
// //         centerTitle: true,
// //       ),
// //       body: DefaultTabController(
// //         length: 2, // Number of tabs
// //         child: Column(
// //           children: [
// //             const Padding(
// //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
// //               child: Row(
// //                 children: [
// //                   TopHeading(
// //                     text: 'Hello,',
// //                     fontSize: 20,
// //                   ),
// //                   Text(' Surya Pratap Singh', style: TextStyle(fontSize: 16)),
// //                 ],
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 10, top: 10),
// //               child: Row(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(100),
// //                     child: Image.asset(
// //                       EImages.userIcon,
// //                       fit: BoxFit.cover,
// //                       width: 80,
// //                       height: 80,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             // Add the TabBar here
// //             const TabBar(
// //               tabs: [
// //                 Tab(text: 'Profile Details'),
// //                 Tab(text: 'Educational Details'),
// //               ],
// //             ),
// //             // Add the TabBarView here
// //             Expanded(
// //               child: TabBarView(
// //                 children: [
// //                   UserDetails(data: personalDetails,),
// //                   EducationDetailsPanel(educationalDetails),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// // class UserDetails extends StatelessWidget {
// //   final Map<String, String> data;
// //
// //   const UserDetails({Key? key, required this.data, })
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.all(8),
// //       child: ListView(
// //         shrinkWrap: true,
// //         physics: const BouncingScrollPhysics(),
// //         children: data.entries.map((entry) {
// //           return Padding(
// //             padding: const EdgeInsets.only(bottom: 16),
// //             child: ESettingsMenuTile(
// //               title: entry.key,
// //               subTitle: entry.value,
// //               onTap: () {
// //                 // Add any onTap functionality here if needed
// //               },
// //             ),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// // }
// //
// // Map<String, String> personalDetails = {
// //   'Gn No': 'G/2023/Engg/CS56',
// //   'Enrollment Number': '121CS12024',
// //   'Father’s Name': 'Jon Wick Jones',
// //   'Mother’s Name': 'Jon Wick Jones',
// //   'Date of Birth': 'Jan 01 2024',
// //   'Contact No': '9898987777',
// //   'Course': 'Engg',
// //   'Branch': 'CS',
// //   'Address': 'Jabalpur, M.P. 482001',
// //   'Parent Contact': '7979797777',
// //   'Email': 'google@gmail.com',
// //   'Category': 'General',
// //   'Blood Group': 'A+',
// //   'Aadhaar No': '1245 6789 1234 5678',
// //   'Samarga Id': '121JBP456',
// //   'Laptop': 'YES',
// // };
// //
// // class EducationDetailsPanel extends StatefulWidget {
// //   final List<Map<String, dynamic>> educationalDetails;
// //
// //   EducationDetailsPanel(this.educationalDetails);
// //
// //   @override
// //   _EducationDetailsPanelState createState() => _EducationDetailsPanelState();
// // }
// //
// // class _EducationDetailsPanelState extends State<EducationDetailsPanel> {
// //   late List<bool> _isExpandedList;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _isExpandedList = List.generate(widget.educationalDetails.length, (index) => false);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: ExpansionPanelList(
// //               elevation: 1,
// //               children: widget.educationalDetails
// //                   .asMap()
// //                   .entries
// //                   .map(
// //                     (entry) => ExpansionPanel(
// //                   headerBuilder: (context, isExpanded) {
// //                     return ListTile(
// //                       title: Text(entry.value['type']),
// //                     );
// //                   },
// //                   body: ListTile(
// //                     title: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         for (var key in entry.value['details'].keys)
// //                           ListTile(
// //                             title: Text('$key: ${entry.value['details'][key]}'),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                   isExpanded: _isExpandedList[entry.key],
// //                   canTapOnHeader: true,
// //                   backgroundColor: Colors.white,
// //                 ),
// //               )
// //                   .toList(),
// //               expansionCallback: (panelIndex, isExpanded) {
// //                 setState(() {
// //                   _isExpandedList[panelIndex] = !isExpanded;
// //                 });
// //               },
// //             ),
// //           ),
// //
// //           Text('data'),
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// // List<Map<String, dynamic>> educationalDetails = [
// //   {
// //     'type': 'High School',
// //     'details': {
// //       'School': 'ABC High School',
// //       'Board': 'State Board',
// //       'Passing Year': '2020',
// //       'Subjects': 'Maths, Science, English',
// //       'Percentage': '85%',
// //     },
// //   },
// //   {
// //     'type': 'Higher Secondary School',
// //     'details': {
// //       'School': 'XYZ Higher Secondary School',
// //       'Board': 'State Board',
// //       'Passing Year': '2022',
// //       'Subjects': 'Physics, Chemistry, Biology',
// //       'Percentage': '92%',
// //     },
// //   },
// //   {
// //     'type': 'College',
// //     'details': {
// //       'Name': 'Global Engineering College',
// //       'Semester': '3rd',
// //       'Branch': 'Computer Science',
// //       'CGPA': '9.5',
// //     },
// //   },
// //   {
// //     'type': 'Internship',
// //     'details': {
// //       'Company': 'Tech Solutions Ltd.',
// //       'Duration': '3 months',
// //       'Role': 'Software Developer Intern',
// //     },
// //   },
// //   {
// //     'type': 'Project',
// //     'details': {
// //       'Title': 'Smart Home Automation',
// //       'Duration': '6 months',
// //       'Description': 'Developed a system for automating home appliances using IoT',
// //     },
// //   },
// //   {
// //     'type': 'Achievements',
// //     'details': {
// //       '1': 'Winner - Coding Competition',
// //       '2': 'Runner-up - Science Exhibition',
// //     },
// //   },
// // ];
// //