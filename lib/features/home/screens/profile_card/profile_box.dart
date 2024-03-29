import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_back_side/profile_card_back_side.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_front_side/profile_front_side_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/api/api_services.dart';
import '../../../../utils/constants/colors.dart';
import 'package:flip_card/flip_card.dart';

class ProfileBox extends StatefulWidget {
  const ProfileBox({Key? key}) : super(key: key);

  @override
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final data = await ApiService.getProfileData();
      setState(() {
        profileData = data;
      });
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Profile Data: $profileData');
    return FlipCard(

      direction: FlipDirection.VERTICAL,
      flipOnTouch: true,
      front: profileData != null ? buildFront() : buildShimmer(),
      back: profileData != null ? buildBack() : buildShimmer(),
    );
  }

  Widget buildShimmer() {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: containerWidth,
        height: 125,
      ),
    );
  }

  Widget buildFront() {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    if (profileData?['response'] != null && profileData!['response'].isNotEmpty) {
      var responseData = profileData!['response'][0];

      // Check if 'response' contains 'student_name' and 'GNo' keys
      if (responseData.containsKey('student_name') && responseData.containsKey('GNo')) {
        // Use the profile photo URL if available, otherwise use a default image URL
        String imageUrl = responseData['Profile_photo'] ?? 'assets/avaters/Avatar Default.jpg';

        return Column(
          children: [
            Container(
              width: containerWidth,
              height: 140,
              decoration: BoxDecoration(
                // color: EColors.primary1,
                color: EColors.secondary11,
                // color: EColors.primarySecond,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(0),
                child: UserProfileWidget(
                  imageUrl: imageUrl,
                  name: responseData['student_name'] ?? 'Unknown',
                  branch: responseData['Branch'] ?? 'Unknown',
                  courseType: responseData['Course'] ?? 'Unknown',
                  enroll: responseData['GNo'] ?? 'Unknown',
                ),
              ),
            ),
          ],
        );
      } else {
        // Handle the case when required keys are not present in the response
        return Container(
          width: containerWidth,
          height: 140,
          decoration: BoxDecoration(
            color: EColors.primarySecond,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Colors.black12,
              )
            ],
          ),
          child: const Center(
            child: Text(
              'Profile data is not available.',
              style: TextStyle(
                color: EColors.textColorPrimary1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } else {
      // Handle the case when response or its sublists are null or empty
      return Container(
        width: containerWidth,
        height: 140,
        decoration: BoxDecoration(
          color: EColors.primarySecond,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),
        child: const Center(
          child: Text(
            'Profile data is not available.',
            style: TextStyle(
              color: EColors.textColorPrimary1,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  Widget buildBack() {
    if (profileData != null && profileData!['response'] != null && profileData!['response'].isNotEmpty) {
      var responseData = profileData!['response'][0];

      return BackUserDetailsWidget(
        fatherName: responseData['Fathers_Name'] ?? '',
        motherName: responseData['Mothers_Name'] ?? '',
        dateOfBirth: responseData['DOB'] ?? '',
        studentSession: responseData['stud_session'] ?? '',
        mobile: responseData['ContactNo'] ?? '',
        email: responseData['Email'] ?? '',
      );
    } else {
      // Handle the case when response or its sublist are null or empty
      return Container(
        // Your fallback UI or message for when the data is not available
      );
    }
  }

/*
  Widget buildBack() {
    return BackUserDetailsWidget(
      fatherName: profileData?['response']?[0]?[5]?['fathers_name'] ?? '',
      motherName: profileData?['response']?[0]?[5]?['mothers_name'] ?? '',
      studentSession: profileData?['response']?[0]?[15]?['stud_session'] ?? '',
      mobile: profileData?['response']?[0]?[7]?['mobile'] ?? '',
      email: profileData?['response']?[0]?[11]?['value'] ?? 'NA',
    );
  }

   */

}

/// Correct Original code
/*
import 'package:flutter/material.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_back_side/profile_card_back_side.dart';
import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_front_side/profile_front_side_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/api/api_services.dart';
import '../../../../utils/constants/colors.dart';
import 'package:flip_card/flip_card.dart';

class ProfileBox extends StatefulWidget {
  const ProfileBox({Key? key}) : super(key: key);

  @override
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final data = await ApiService.getProfileData();
      setState(() {
        profileData = data;
      });
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Profile Data: $profileData');
    return FlipCard(
      direction: FlipDirection.VERTICAL,
      flipOnTouch: true,
      front: profileData != null ? buildFront() : buildShimmer(),
      back: profileData != null ? buildBack() : buildShimmer(),
    );
  }

  Widget buildShimmer() {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: containerWidth,
        height: 125,
      ),
    );
  }

  Widget buildFront() {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

    if (profileData?['response'] != null && profileData!['response'].isNotEmpty) {
      var responseData = profileData!['response'][0];

      // Check if 'response' contains 'student_name' and 'GNo' keys
      if (responseData.containsKey('student_name') && responseData.containsKey('GNo')) {
        // Use the profile photo URL if available, otherwise use a default image URL
        String imageUrl = responseData['Profile_photo'] ?? 'assets/avaters/Avatar Default.jpg';

        return Column(
          children: [
            Container(
              width: containerWidth,
              height: 140,
              decoration: BoxDecoration(
                color: EColors.primary1,
                // color: EColors.primarySecond,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(0),
                child: UserProfileWidget(
                  imageUrl: imageUrl,
                  name: responseData['student_name'] ?? 'Unknown',
                  branch: responseData['Branch'] ?? 'Unknown',
                  courseType: responseData['Course'] ?? 'Unknown',
                  enroll: responseData['GNo'] ?? 'Unknown',
                ),
              ),
            ),
          ],
        );
      } else {
        // Handle the case when required keys are not present in the response
        return Container(
          width: containerWidth,
          height: 140,
          decoration: BoxDecoration(
            color: EColors.primarySecond,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Colors.black12,
              )
            ],
          ),
          child: const Center(
            child: Text(
              'Profile data is not available.',
              style: TextStyle(
                color: EColors.textColorPrimary1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } else {
      // Handle the case when response or its sublists are null or empty
      return Container(
        width: containerWidth,
        height: 140,
        decoration: BoxDecoration(
          color: EColors.primarySecond,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),
        child: const Center(
          child: Text(
            'Profile data is not available.',
            style: TextStyle(
              color: EColors.textColorPrimary1,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  Widget buildBack() {
    if (profileData != null && profileData!['response'] != null && profileData!['response'].isNotEmpty) {
      var responseData = profileData!['response'][0];

      return BackUserDetailsWidget(
        fatherName: responseData['Fathers_Name'] ?? '',
        motherName: responseData['Mothers_Name'] ?? '',
        dateOfBirth: responseData['DOB'] ?? '',
        studentSession: responseData['stud_session'] ?? '',
        mobile: responseData['ContactNo'] ?? '',
        email: responseData['Email'] ?? '',
      );
    } else {
      // Handle the case when response or its sublist are null or empty
      return Container(
        // Your fallback UI or message for when the data is not available
      );
    }
  }

/*
  Widget buildBack() {
    return BackUserDetailsWidget(
      fatherName: profileData?['response']?[0]?[5]?['fathers_name'] ?? '',
      motherName: profileData?['response']?[0]?[5]?['mothers_name'] ?? '',
      studentSession: profileData?['response']?[0]?[15]?['stud_session'] ?? '',
      mobile: profileData?['response']?[0]?[7]?['mobile'] ?? '',
      email: profileData?['response']?[0]?[11]?['value'] ?? 'NA',
    );
  }

   */

}
*/

/*
// Widget buildFront() {
//   double containerWidth = MediaQuery.of(context).size.width * 0.9;
//
//   if (profileData?['response'] != null && profileData!['response'].isNotEmpty) {
//     var responseData = profileData!['response'][0];
//
//     // Find the index of 'Profile photo' in responseData
//     int photoIndex = responseData.indexWhere((field) => field['type'] == 'Profile photo');
//
//     // Use the profile photo URL if found, otherwise use a default image URL
//     String imageUrl = photoIndex != -1 ? responseData[photoIndex]['value'] : 'assets/avaters/Avatar Default.jpg';
//
//     return Column(
//       children: [
//         Container(
//           width: containerWidth,
//           height: 125,
//           decoration: BoxDecoration(
//             color: EColors.primarySecond,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(0, 0),
//                 blurRadius: 10,
//                 color: Colors.black12,
//               )
//             ],
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             padding: const EdgeInsets.all(0),
//             child: UserProfileWidget(
//               imageUrl: imageUrl,
//               name: responseData[0]['value'] ?? 'Unknown',
//               branch: responseData[8]['value'] ?? 'Unknown',
//               courseType: responseData[7]['value'] ?? 'Unknown',
//               enroll: responseData[1]['value'] ?? 'Unknown',
//             ),
//           ),
//         ),
//       ],
//     );
//   } else {
//     // Handle the case when response or its sublists are null or empty
//     return Container(
//       width: containerWidth,
//       height: 125,
//       decoration: BoxDecoration(
//         color: EColors.primarySecond,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             offset: Offset(0, 0),
//             blurRadius: 10,
//             color: Colors.black12,
//           )
//         ],
//       ),
//       child: const Center(
//         child: Text(
//           'Profile data is not available.',
//           style: TextStyle(
//             color: EColors.textColorPrimary1,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
*/

// import 'package:flutter/material.dart';
// import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_back_side/profile_card_back_side.dart';
// import 'package:baderia_tech_wave/features/home/screens/profile_card/widgets/profile_card_front_side/profile_front_side_card.dart';
// import '../../../../utils/constants/colors.dart';
// import 'package:flip_card/flip_card.dart';
//
// class ProfileBox extends StatefulWidget {
//   const ProfileBox({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileBox> createState() => _ProfileBoxState();
// }
//
// class _ProfileBoxState extends State<ProfileBox> {
//   @override
//   Widget build(BuildContext context) {
//     return FlipCard(
//       direction: FlipDirection.VERTICAL, // Flip direction
//       flipOnTouch: true,
//       front: buildFront(),
//       back: buildBack(),
//     );
//   }
//
//   Widget buildFront() {
//     double containerWidth = MediaQuery.of(context).size.width * 0.9;
//     return Column(
//       children: [
//         Container(
//           width: containerWidth,
//           height: 125,
//           decoration: BoxDecoration(
//             color: EColors.primarySecond,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(0, 0),
//                 blurRadius: 10,
//                 color: Colors.black12,
//               )
//             ],
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             padding: const EdgeInsets.all(0),
//             child: const UserProfileWidget(
//               imageUrl:
//                   'assets/avaters/Avatar 6.jpg', // Replace with your image URL
//               name: 'Surya Pratap Singh',
//               branch: 'Computer Science Engineering',
//               courseType: 'Bachelor', enroll: '121ME2024CS',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildBack() {
//     // Back side of the card here
//     return BackUserDetailsWidget(fatherName: '', motherName: '', studentSession: '', mobile: '', text: '',
//
//     );
//   }
// }