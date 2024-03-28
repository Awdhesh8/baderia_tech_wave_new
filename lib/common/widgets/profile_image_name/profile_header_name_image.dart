import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/screens/settings/edit_profile/edit_Profile.dart';
import '../../../utils/constants/colors.dart';
import '../custom_shapes/containers/primary_header_container.dart';

class UserProfile extends StatelessWidget {
  final String userText;
  final String? userText2;
  final String imagePath;
  final double? width;
  final double? height;
  final bool showEditButton;
  final VoidCallback onPressed; // Define onPressed here

  const UserProfile({
    Key? key,
    required this.userText,
    required this.imagePath,
    this.showEditButton = true,
    this.width = 120,
    this.height = 120,
    this.userText2,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EPrimaryHeaderContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 13, right: 20),
        child: Column(
          children: [
            // SizedBox(
            //   height: 40,
            // ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 13),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         'User Profile',
            //         style: TextStyle(
            //           fontSize: 24.0,
            //           fontFamily: 'Inter',
            //           color: EColors.textColorPrimary1,
            //           // color: EColors.white,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),


            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Hello, ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        // color: EColors.white,
                        color: EColors.textColorPrimary1,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      userText,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        // color: EColors.white,
                        color: EColors.textColorPrimary1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(

              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  Colors.white, // Set the color of the border
                              width: 3, // Set the width of the border
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                  Colors.black12, // Set the color of the border
                                  width: 1, // Set the width of the border
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imagePath.startsWith('http')
                                    ? Image.network(
                                        imagePath,
                                        fit: BoxFit.fill,
                                        width: width,
                                        height: height,
                                      )
                                    : Image.asset(
                                        imagePath,
                                        fit: BoxFit.fill,
                                        width: width,
                                        height: height,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userText2 ?? '',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                        ),
                        // SizedBox(
                        //   child: Row(
                        //     children: [
                        //       const Text(
                        //         'Hello, ',
                        //         style: TextStyle(
                        //           fontFamily: 'Inter',
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w300,
                        //           // color: EColors.white,
                        //           color: EColors.textColorPrimary1,
                        //         ),
                        //         overflow: TextOverflow.fade,
                        //       ),
                        //       Text(
                        //         userText,
                        //         style: const TextStyle(
                        //           fontFamily: 'Inter',
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w500,
                        //           // color: EColors.white,
                        //           color: EColors.textColorPrimary1,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // if (showEditButton) const SizedBox(height: 8),
                        // if (showEditButton) EditButton(onPressed: onPressed,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(height: 45,)
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: SizedBox(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         const Text(
            //           'Hello, ',
            //           style: TextStyle(
            //             fontFamily: 'Inter',
            //             fontSize: 16,
            //             fontWeight: FontWeight.w300,
            //             // color: EColors.white,
            //             color: EColors.textColorPrimary1,
            //           ),
            //           overflow: TextOverflow.fade,
            //         ),
            //         Text(
            //           userText,
            //           style: const TextStyle(
            //             fontFamily: 'Inter',
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //             // color: EColors.white,
            //             color: EColors.textColorPrimary1,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showEditButton) const SizedBox(height: 8),
                if (showEditButton)
                  EditButton(
                    onPressed: onPressed,
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;
  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      // () {

      // Get.to(
      //       () => EditProfile(),
      //   transition: Transition.rightToLeftWithFade,
      //   duration: const Duration(milliseconds: 300),
      // );
      // },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Edit Profile',
            style: TextStyleClass.buttonStyle1,
          ),
          SizedBox(width: 4),
          Icon(
            Iconsax.edit,
            size: 15,
          ),
        ],
      ),
    );
  }
}

class NameText extends StatelessWidget {
  const NameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Edit Profile'),
      ],
    );
  }
}
