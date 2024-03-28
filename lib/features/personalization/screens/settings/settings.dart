import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/edit_profile/edit_Profile.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/education_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/personal_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/rounded_radio_buttons.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/top_heading.dart';
import '../../../../common/widgets/animations/common_animation.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/profile_image_name/profile_header_name_image.dart';
import '../../../../controllers/user_controller_login_check/user_controller.dart';
import '../../../../data/api/api_services.dart';
import '../../../../utils/constants/colors.dart';
import '../../../authentication/screens/onboding/onboding_screen.dart';

class SettingsController extends GetxController {
  RxBool showPersonalDetails = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showPersonalInfo() {
    showPersonalDetails.value = true;
  }

  void showEducationalInfo() {
    showPersonalDetails.value = false;
  }
}

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final UserController userController = Get.find<UserController>();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      // backgroundColor: EColors.white,
      appBar: const GAppBar(
        title:   Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Inter',
            color: EColors.textColorPrimary1,
            // color: EColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        // backgroundColor: EColors.lightContainer,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: ShimmerProfileLoading());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final Map<String, dynamic> userData =
                  snapshot.data!['response'][0];
                  final String profilePhoto =
                      userData['Profile_photo'] ?? 'assets/images/user_icon.png';
                  final String studentName = userData['student_name'] ?? '';
                  final String studentGNo = userData['GNo'] ?? '';

                  return AnimationWidget(
                    duration: Duration(milliseconds: 400),
                    animationType: 'fade_slide',
                    curve: Curves.easeInOut,
                    child: UserProfile(
                      userText: studentName,
                      imagePath: profilePhoto,
                      showEditButton: true,
                      onPressed: () {
                        Get.to(EditProfile(
                          profilePhoto: userData['Profile_photo'] ??
                              'assets/images/user_icon.png',
                          // profilePhoto: profilePhoto,
                          contactNo: userData['ContactNo'] ?? '',
                          email: userData['Email'] ?? '',
                          bloodGroup: userData['Blood_Group'] ?? '',
                          samagraId: userData['SamagraId'] ?? '',
                          laptop: userData['Laptop'] ?? '',
                          laptopBrand: userData['lap_brand'] ?? '',
                          laptopRam: userData['lap_ram'] ?? '',
                          laptopProcessor: userData['lap_processor'] ?? '',
                          laptopConfig: userData['lap_config'] ?? '',
                        ));
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
            //   child: Divider(),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(12.0),
                //   color: EColors.lightContainer1,
                //   // color: Colors.white70,
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => RoundedButton(
                        label: '  Personal Info  ',
                        isSelected: controller.showPersonalDetails.value,
                        onPressed: () => controller.showPersonalInfo(), icon: FontAwesomeIcons.info,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(() => RoundedButton(
                        label: 'Educational Info',
                        isSelected: !controller.showPersonalDetails.value,
                        onPressed: () => controller.showEducationalInfo(), icon: FontAwesomeIcons.graduationCap,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  TopHeading(text: 'Your Information', fontSize: 18),
                ],
              ),
            ),
            FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const UserDetails(
                    dataList: [],
                    data: {},
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, dynamic>> dataList = [
                    snapshot.data!['response'][0]
                  ];
                  return Obx(() => controller.showPersonalDetails.value
                      ? UserDetails(
                      data: snapshot.data!['response'][0],
                      dataList: dataList)
                      : EducationDetailsPanel());
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),

      /// Logout Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              // color: Color(0xFFFFC1C5),
              offset: Offset(-5, -5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(5, 5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(14.0),
          elevation: 8,
          color: EColors.primarySecond,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    color: EColors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout',
          style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500
          ),
        ),
        content: const Text('Do you really want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);

              // Perform the logout actions (e.g., clear user session)
              userController.logout();
              // Navigate to OnbodingScreen and close everything
              Get.offAll(() => const OnbodingScreen());
            },
            child: const Text('Logout',
            ),
          ),
        ],
      ),
    );
  }
}



/// Correct code With old Ui
/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/edit_profile/edit_Profile.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/education_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/personal_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/rounded_radio_buttons.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/top_heading.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/profile_image_name/profile_header_name_image.dart';
import '../../../../controllers/user_controller_login_check/user_controller.dart';
import '../../../../data/api/api_services.dart';
import '../../../../utils/constants/colors.dart';
import '../../../authentication/screens/onboding/onboding_screen.dart';

class SettingsController extends GetxController {
  RxBool showPersonalDetails = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showPersonalInfo() {
    showPersonalDetails.value = true;
  }

  void showEducationalInfo() {
    showPersonalDetails.value = false;
  }
}

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final UserController userController = Get.find<UserController>();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.white,
      // appBar: const GAppBar(
      //   showBackArrow: false,
      //   title: Text(
      //     'Profile',
      //     style: TextStyle(
      //       fontSize: 20.0,
      //       fontFamily: 'Inter',
      //       color: EColors.textSecondaryTitle,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   // backgroundColor: EColors.primary,
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>?>(
            future: ApiService.getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: ShimmerProfileLoading());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              } else if (snapshot.hasData && snapshot.data != null) {
                final Map<String, dynamic> userData =
                    snapshot.data!['response'][0];
                final String profilePhoto =
                    userData['Profile_photo'] ?? 'assets/images/user_icon.png';
                final String studentName = userData['student_name'] ?? '';
                final String studentGNo = userData['GNo'] ?? '';

                return UserProfile(
                  userText: studentName,
                  imagePath: profilePhoto,
                  showEditButton: true,
                  onPressed: () {
                    Get.to(EditProfile(
                      profilePhoto: userData['Profile_photo'] ??
                          'assets/images/user_icon.png',
                      // profilePhoto: profilePhoto,
                      contactNo: userData['ContactNo'] ?? '',
                      email: userData['Email'] ?? '',
                      bloodGroup: userData['Blood_Group'] ?? '',
                      samagraId: userData['SamagraId'] ?? '',
                      laptop: userData['Laptop'] ?? '',
                      laptopBrand: userData['lap_brand'] ?? '',
                      laptopRam: userData['lap_ram'] ?? '',
                      laptopProcessor: userData['lap_processor'] ?? '',
                      laptopConfig: userData['lap_config'] ?? '',
                    ));
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
          //   child: Divider(),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(12.0),
              //   color: EColors.lightContainer1,
              //   // color: Colors.white70,
              // ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => RoundedButton(
                          label: '  Personal Info  ',
                          isSelected: controller.showPersonalDetails.value,
                          onPressed: () => controller.showPersonalInfo(), icon: FontAwesomeIcons.info,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() => RoundedButton(
                          label: 'Educational Info',
                          isSelected: !controller.showPersonalDetails.value,
                          onPressed: () => controller.showEducationalInfo(), icon: FontAwesomeIcons.graduationCap,
                        )),
                  ],
                ),
              ),
            ),
          ),
           const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                TopHeading(text: 'Your Information', fontSize: 18),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const UserDetails(
                    dataList: [],
                    data: {},
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, dynamic>> dataList = [
                    snapshot.data!['response'][0]
                  ];
                  return Obx(() => controller.showPersonalDetails.value
                      ? UserDetails(
                          data: snapshot.data!['response'][0],
                          dataList: dataList)
                      : EducationDetailsPanel());
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),

      /// Logout Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              // color: Color(0xFFFFC1C5),
              offset: Offset(-5, -5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(5, 5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(14.0),
          elevation: 8,
          color: EColors.primarySecond,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    color: EColors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500
        ),
        ),
        content: const Text('Do you really want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);

              // Perform the logout actions (e.g., clear user session)
              userController.logout();
              // Navigate to OnbodingScreen and close everything
              Get.offAll(() => const OnbodingScreen());
            },
            child: const Text('Logout',
            ),
          ),
        ],
      ),
    );
  }
}
*/

/// Correct Code
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/edit_profile/edit_Profile.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/education_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/personal_details_tab.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/rounded_radio_buttons.dart';
import 'package:baderia_tech_wave/features/personalization/screens/settings/widgets/top_heading.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/profile_image_name/profile_header_name_image.dart';
import '../../../../controllers/user_controller_login_check/user_controller.dart';
import '../../../../data/api/api_services.dart';
import '../../../../utils/constants/colors.dart';
import '../../../authentication/screens/onboding/onboding_screen.dart';

class SettingsController extends GetxController {
  RxBool showPersonalDetails = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showPersonalInfo() {
    showPersonalDetails.value = true;
  }

  void showEducationalInfo() {
    showPersonalDetails.value = false;
  }
}

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final UserController userController = Get.find<UserController>();

  SettingsScreen({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>?>(
            future: ApiService.getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: ShimmerProfileLoading());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              } else if (snapshot.hasData && snapshot.data != null) {
                final Map<String, dynamic> userData =
                    snapshot.data!['response'][0];
                final String profilePhoto =
                    userData['Profile_photo'] ?? 'assets/images/user_icon.png';
                final String studentName = userData['student_name'] ?? '';

                return UserProfile(
                  userText: studentName,
                  imagePath: profilePhoto,
                  showEditButton: true,
                  onPressed: () {
                    Get.to(EditProfile(
                      profilePhoto: userData['Profile_photo'] ??
                          'assets/images/user_icon.png',
                      // profilePhoto: profilePhoto,
                      contactNo: userData['ContactNo'] ?? '',
                      email: userData['Email'] ?? '',
                      bloodGroup: userData['Blood_Group'] ?? '',
                      samagraId: userData['SamagraId'] ?? '',
                      laptop: userData['Laptop'] ?? '',
                      laptopBrand: userData['lap_brand'] ?? '',
                      laptopRam: userData['lap_ram'] ?? '',
                      laptopProcessor: userData['lap_processor'] ?? '',
                      laptopConfig: userData['lap_config'] ?? '',
                    ));
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => RoundedButton(
                      label: '  Personal Info  ',
                      isSelected: controller.showPersonalDetails.value,
                      onPressed: () => controller.showPersonalInfo(),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => RoundedButton(
                      label: 'Educational Info',
                      isSelected: !controller.showPersonalDetails.value,
                      onPressed: () => controller.showEducationalInfo(),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                TopHeading(text: 'Your Information', fontSize: 18),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const UserDetails(
                    dataList: [],
                    data: {},
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<Map<String, dynamic>> dataList = [
                    snapshot.data!['response'][0]
                  ];
                  return Obx(() => controller.showPersonalDetails.value
                      ? UserDetails(
                          data: snapshot.data!['response'][0],
                          dataList: dataList)
                      : EducationDetailsPanel());
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),

// class SettingsScreen extends StatelessWidget {
//   final SettingsController controller = Get.put(SettingsController());
//   final UserController userController = Get.find<UserController>();
//
//   SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         showBackArrow: false,
//         title: Text(
//           'Account',
//           style: TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: EColors.primary,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const UserProfile(
//             userText: 'Surya Pratap Singh',
//             imagePath: 'assets/images/user_icon.png',
//             showEditButton: true,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Obx(() => RoundedButton(
//                   label: 'Personal Info',
//                   isSelected: controller.showPersonalDetails.value,
//                   onPressed: () => controller.showPersonalInfo(),
//                 )),
//                 Obx(() => RoundedButton(
//                   label: 'Educational Info',
//                   isSelected: !controller.showPersonalDetails.value,
//                   onPressed: () => controller.showEducationalInfo(),
//                 )),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 10,),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 const TopHeading(text: 'Your Information', fontSize: 18),
//               ],
//             ),
//           ),
//           // SizedBox(height: 4,),
//
//           Expanded(
//             child: FutureBuilder<Map<String, dynamic>?>(
//               future: ApiService.getProfileData(),
//               builder: (context, snapshot) {
//                 print('Connection State: ${snapshot.connectionState}');
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   print('Waiting for data...');
//                   return UserDetails(dataList: [], data: {},); // Pass an empty list for now.
//                 } else if (snapshot.hasError) {
//                   print('Error loading data: ${snapshot.error}');
//                   return Center(child: Text('Error loading data'));
//                 } else if (snapshot.hasData && snapshot.data != null) {
//                   print('Received data: ${snapshot.data}');
//                   List<Map<String, dynamic>> dataList = [snapshot.data!['response'][0]];
//                   return Obx(() => controller.showPersonalDetails.value
//                       ? UserDetails(data: snapshot.data!['response'][0], dataList: dataList)
//                       : EducationDetailsPanel(
//                     educationalDetails: educationalDetails,
//                   ));
//                 } else {
//                   return Center(child: Text('No data available'));
//                 }
//               },
//             ),
//           ),
//

          /*
          Expanded(
            child: FutureBuilder<Map<String, dynamic>?>(
              future: ApiService.getProfileData(),
              builder: (context, snapshot) {
                print('Connection State: ${snapshot.connectionState}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Waiting for data...');
                  return UserDetails(data: []);
                } else if (snapshot.hasError) {
                  print('Error loading data: ${snapshot.error}');
                  return Center(child: Text('Error loading data'));
                } else {
                  print('Received data: ${snapshot.data}');
                  return Obx(() => controller.showPersonalDetails.value
                      ? UserDetails(data: [snapshot.data ?? {}])
                      : EducationDetailsPanel(
                    educationalDetails: educationalDetails,
                  ));
                }
              },
            ),
          ),

           */

          // Expanded(
          //   child: FutureBuilder<Map<String, dynamic>?>(
          //     future: ApiService.getProfileData(),
          //     builder: (context, snapshot) {
          //       print('Connection State: ${snapshot.connectionState}');
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         print('Waiting for data...');
          //         return UserDetails(data: []);
          //       } else if (snapshot.hasError) {
          //         print('Error loading data: ${snapshot.error}');
          //         return Center(child: Text('Error loading data'));
          //       } else if (snapshot.hasData && snapshot.data != null) {
          //         print('Received data: ${snapshot.data}');
          //         var responseData = snapshot.data!["response"] as List<dynamic>? ?? [];
          //         List<Map<String, dynamic>> mappedData = [];
          //
          //         if (responseData.isNotEmpty && responseData[0] is List<dynamic>) {
          //           mappedData = (responseData[0] as List<dynamic>)
          //               .cast<Map<String, dynamic>>()
          //               .toList();
          //         }
          //
          //         return Obx(() => controller.showPersonalDetails.value
          //             ? UserDetails(data: mappedData)
          //             : EducationDetailsPanel(
          //           educationalDetails: educationalDetails,
          //         ));
          //       } else {
          //         return Center(child: Text('No data available'));
          //       }
          //     },
          //   ),
          // ),
        ],
      ),

      /// Logout Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              // color: Color(0xFFFFC1C5),
              offset: Offset(-5, -5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(5, 5),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(14.0),
          elevation: 8,
          color: EColors.primarySecond,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    color: EColors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 13,
                      color: EColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);

              // Perform the logout actions (e.g., clear user session)
              userController.logout();
              // Navigate to OnbodingScreen and close everything
              Get.offAll(() => const OnbodingScreen());
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
 */

// class SettingsScreen extends StatelessWidget {
//   final SettingsController controller = Get.put(SettingsController());
//   final UserController userController = Get.find<UserController>(); // Add this line
//
//   SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         showBackArrow: false,
//         title: Text(
//           'Account',
//           style: TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: EColors.primary,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//
//           /// --- Circular Avatar User Profile Image & Edit Button ---
//           const UserProfile(
//             userText: 'Surya Pratap Singh',
//             imagePath: 'assets/images/user_icon.png',
//             showEditButton: true, // or false
//           ),
//
//
//           /// Rounded Radio buttons To show the Information | Personal OR Educational
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Obx(() => RoundedButton(
//                       label: 'Personal Info',
//                       isSelected: controller.showPersonalDetails.value,
//                       onPressed: () => controller.showPersonalInfo(),
//                     )),
//                 Obx(() => RoundedButton(
//                       label: 'Educational Info',
//                       isSelected: !controller.showPersonalDetails.value,
//                       onPressed: () => controller.showEducationalInfo(),
//                     )),
//               ],
//             ),
//           ),
//
//           // /// Display Data according to the Selected Button
//           // Expanded(
//           //   child: Obx(() => controller.showPersonalDetails.value
//           //       ? UserDetails(data: personalDetails)
//           //       : EducationDetailsPanel(
//           //           educationalDetails: educationalDetails,
//           //         )),
//           // ),
//           //
//
//
//
//           /// Display Data according to the Selected Button
//           Expanded(
//             child: FutureBuilder<Map<String, dynamic>?>(
//               future: ApiService.getProfileData(),  // Use the ApiService to call getProfileData
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return UserDetails(data: {});
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error loading data'));
//                 } else {
//                   return Obx(() => controller.showPersonalDetails.value
//                       ? UserDetails(data: snapshot.data ?? {})
//                       : EducationDetailsPanel(
//                     educationalDetails: educationalDetails,
//                   ));
//                 }
//               },
//             ),
//           ),
//
//
//
//         ],
//       ),
//
//
//       /// Logout Button
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       floatingActionButton: Container(
//         margin: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.white,
//               // color: Color(0xFFFFC1C5),
//               offset: Offset(-5, -5),
//               blurRadius: 5,
//               spreadRadius: 1,
//             ),
//             BoxShadow(
//               color: Colors.white,
//               offset: Offset(5, 5),
//               blurRadius: 5,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//         child: Material(
//           borderRadius: BorderRadius.circular(14.0),
//           elevation: 8,
//           color: EColors.primarySecond,
//           child: InkWell(
//             borderRadius: BorderRadius.circular(14.0),
//             onTap: () {
//               _showLogoutConfirmationDialog(context);
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.logout,
//                     color: EColors.white,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Logout',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: EColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Do you really want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true);
//
//               // Perform the logout actions (e.g., clear user session)
//               userController.logout();
//               // Navigate to OnbodingScreen and close everything
//               Get.offAll(() => const OnbodingScreen());
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
