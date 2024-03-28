import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api/api_services.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final String profilePhoto;
  final String contactNo;
  final String email;
  final String samagraId;
  final String laptop;
  final String bloodGroup;
  final String laptopBrand;
  final String laptopRam;
  final String laptopProcessor;
  final String laptopConfig;

  EditProfile({
    Key? key,
    required this.profilePhoto,
    required this.contactNo,
    required this.email,
    required this.samagraId,
    required this.laptop,
    required this.bloodGroup,
    required this.laptopBrand,
    required this.laptopRam,
    required this.laptopProcessor,
    required this.laptopConfig,
  }) : super(key: key) {
    // Initialize values in the controller when the widget is created
    profileController.imagePath.value = profilePhoto;
    profileController.contactNumber.value = contactNo;
    profileController.email.value = email;
    profileController.samaraId.value = samagraId;
    profileController.bloodGroup.value = bloodGroup;
    // profileController.selectedBloodGroupId.value;
    profileController.laptopBrand.value = laptopBrand;
    profileController.laptopRam.value = laptopRam;
    profileController.laptopProcessor.value = laptopProcessor;
    profileController.laptopConfig.value = laptopConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: EColors.textColorPrimary1),
        ),
        centerTitle: false,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: Obx(() => CircularAvatar(
                    imagePath: profileController.imagePath.value,
                    onTap: () => _pickImage(context),
                    uploadIcon: IconButton(
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                      onPressed: () => _pickImage(context),
                    ),
                  )),
            ),
            const SizedBox(height: 16),
            // _buildTextField1('Contact Number', profileController.contactNumber.value),
            _buildTextField(
                'Contact Number', profileController.contactNumber.value,
                (value) {
              profileController.contactNumber.value = value;
            }),
            // _buildTextField1('Contact Number', profileController.contactNumber.value),
            // _buildTextField1('Email', profileController.email.value),
            _buildTextField('Email', profileController.email.value, (value) {
              profileController.email.value = value;
            }),

            /// Blood Groups Dropdown--->>>
            /// Blood Groups Dropdown--->>>
            FutureBuilder<List<BloodGroup>>(
              future: ApiService.fetchBloodGroups(), // Fetch blood groups
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 60, // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // If data is fetched successfully
                  return _buildBloodGroupDropdown(snapshot.data!);
                } else {
                  return Text('No data available'); // Handle the case when there is no data
                }
              },
            ),

            // FutureBuilder<List<String>>(
            //   future: ApiService.fetchBloodGroups(), // Fetch blood groups
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       // Show shimmer loading effect while fetching
            //       return Shimmer.fromColors(
            //         baseColor: Colors.grey[300]!,
            //         highlightColor: Colors.grey[100]!,
            //         child: Container(
            //           width: double.infinity,
            //           height: 60, // Adjust height as needed
            //           color: Colors.white,
            //         ),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       // If data is fetched successfully
            //       return _buildBloodGroupDropdown(snapshot.data!);
            //     }
            //   },
            // ),


            // _buildTextField1('Samagra ID', profileController.samaraId.value),
            _buildTextField('Samagra ID', profileController.samaraId.value,
                (value) {
              profileController.samaraId.value = value;
            }),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Your Laptop Details Here!!!'),
                  ],
                ),
                // Show laptop details fields only if the switch is toggled on
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        'Laptop Brand', profileController.laptopBrand.value,
                        (value) {
                      profileController.laptopBrand.value = value;
                    }),
                    _buildTextField(
                        'Laptop RAM', profileController.laptopRam.value,
                        (value) {
                      profileController.laptopRam.value = value;
                    }),
                    _buildTextField('Laptop Processor',
                        profileController.laptopProcessor.value, (value) {
                      profileController.laptopProcessor.value = value;
                    }),
                    _buildTextField('Laptop Configuration',
                        profileController.laptopConfig.value, (value) {
                      profileController.laptopConfig.value = value;
                    }),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String text, void Function(String) onChanged) {
    TextEditingController controller = TextEditingController(text: text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBloodGroupDropdown(List<BloodGroup> bloodGroups) {
    String initialValue = profileController.selectedBloodGroup.value?.id ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Blood Group'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      value: initialValue, // Set initial value here
      decoration: const InputDecoration(
        labelText: 'Blood Group',
        labelStyle: TextStyle(color: EColors.textColorPrimary1),
      ),
      onChanged: (String? newValue) {
        profileController.selectedBloodGroup.value =
            bloodGroups.firstWhere((group) => group.id == newValue);
      },
      items: [
        const DropdownMenuItem<String>(
          value: 'Select Your Blood Group',
          child: Text('Select Your Blood Group'),
        ),
        ...bloodGroups.map<DropdownMenuItem<String>>((BloodGroup group) {
          return DropdownMenuItem<String>(
            value: group.id,
            child: Text(group.name),
          );
        }).toList(),
      ],
    );
  }


/*
  Widget _buildBloodGroupDropdown(List<String> bloodGroups) {
    String initialValue = profileController.bloodGroup.value ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Blood Group'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      value: initialValue, // Set initial value here
      decoration: const InputDecoration(
        labelText: 'Blood Group',
        labelStyle: TextStyle(color: EColors.textColorPrimary1),
      ),

      onChanged: (String? newValue) {
        profileController.selectedBloodGroupId.value  =
            newValue!; // Update the selected blood group
        // profileController.bloodGroup.value =
        //     newValue!; // Update the selected blood group
      },
      items: [
        const DropdownMenuItem<String>(
          value: 'Select Your Blood Group', // Set value for default prompt
          child: Text('Select Your Blood Group'), // Set text for default prompt
        ),
        ...bloodGroups.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ],
    );
  }

 */
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      // Update the image path in the controller
      profileController.imagePath.value = pickedFile.path;
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
                _updateProfileAndShowSnackbar();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Get.back(); // Pop back to EditProfile
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _updateProfileAndShowSnackbar() async {
    // Check if any of the laptop details is entered
    bool laptopDetailsEntered =
        profileController.laptopBrand.value.isNotEmpty ||
            profileController.laptopRam.value.isNotEmpty ||
            profileController.laptopProcessor.value.isNotEmpty ||
            profileController.laptopConfig.value.isNotEmpty;

    // Update the laptop value based on the condition
    profileController.laptopBrand.value.isEmpty &&
            profileController.laptopRam.value.isEmpty &&
            profileController.laptopProcessor.value.isEmpty &&
            profileController.laptopConfig.value.isEmpty
        ? profileController.laptop.value = '0'
        : profileController.laptop.value = '1';

    // Perform update logic here
    // _saveProfile(); // Assuming this should save the profile

    // Print bloodGroup value before calling the API
    print(profileController.bloodGroup.value);
    print(profileController.selectedBloodGroup.value);

    // Show Snackbar
    Get.snackbar('Profile Updated', 'Your profile has been updated.');

    // Call the API service to update the profile
    await ApiService.updateProfile(
      contactNumber: profileController.contactNumber.value,
      email: profileController.email.value,
      samagraId: profileController.samaraId.value,
      laptop: profileController.laptop.value,
      // bloodGroup: profileController.selectedBloodGroup.value,
      bloodGroup: profileController.selectedBloodGroup.value?.id ?? '',

      // bloodGroup: profileController.bloodGroup.value,
      laptopBrand: profileController.laptopBrand.value,
      laptopRam: profileController.laptopRam.value,
      laptopProcessor: profileController.laptopProcessor.value,
      laptopConfig: profileController.laptopConfig.value,
      imagePath: profileController.imagePath.value,
    );
    print(profileController.bloodGroup.value);
    print(profileController.selectedBloodGroup.value);

    // Navigate back
    Get.back(); // This will go back to the previous screen
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final Function onTap;
  final Widget uploadIcon;

  const CircularAvatar({
    Key? key,
    required this.imagePath,
    required this.onTap,
    required this.uploadIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: _buildAvatarContent(),
          ),
        ),
        uploadIcon,
      ],
    );
  }

  // Widget _buildAvatarContent() {
  //   if (imagePath.isNotEmpty) {
  //     if (imagePath.startsWith('http')) {
  //       // Display network image
  //       return Container(
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           image: DecorationImage(
  //             image: NetworkImage(imagePath),
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //       );
  //     } else {
  //       // Display local file image
  //       File file = File(imagePath);
  //       if (file.existsSync()) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             image: DecorationImage(
  //               image: FileImage(file),
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  //
  //   // Display default icon if imagePath is empty or invalid
  //   return const Icon(Icons.person, size: 50, color: Colors.white);
  // }

  Widget _buildAvatarContent() {
    if (imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        // Display network image directly
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else if (imagePath.startsWith('assets')) {
        // Display asset image
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else {
        // Assume local file image
        File file = File(imagePath);
        if (file.existsSync()) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(file),
                fit: BoxFit.fill,
              ),
            ),
          );
        }
      }
    }

    // Display default icon if imagePath is empty or invalid
    return const Icon(Icons.person, size: 50, color: Colors.white);
  }
}

class BloodGroup {
  final String id;
  final String name;

  BloodGroup({required this.id, required this.name});

  factory BloodGroup.fromJson(Map<String, dynamic> json) {
    return BloodGroup(
      id: json['id'] ?? '',
      name: json['bloodg'] ?? '',
    );
  }
}


/// ---- Correct code----->>>
/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api/api_services.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final String profilePhoto;
  final String contactNo;
  final String email;
  final String samagraId;
  final String laptop;
  final String bloodGroup;
  final String laptopBrand;
  final String laptopRam;
  final String laptopProcessor;
  final String laptopConfig;

  EditProfile({
    Key? key,
    required this.profilePhoto,
    required this.contactNo,
    required this.email,
    required this.samagraId,
    required this.laptop,
    required this.bloodGroup,
    required this.laptopBrand,
    required this.laptopRam,
    required this.laptopProcessor,
    required this.laptopConfig,
  }) : super(key: key) {
    // Initialize values in the controller when the widget is created
    profileController.imagePath.value = profilePhoto;
    profileController.contactNumber.value = contactNo;
    profileController.email.value = email;
    profileController.samaraId.value = samagraId;
    profileController.bloodGroup.value = bloodGroup;
    profileController.laptopBrand.value = laptopBrand;
    profileController.laptopRam.value = laptopRam;
    profileController.laptopProcessor.value = laptopProcessor;
    profileController.laptopConfig.value = laptopConfig;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: EColors.textColorPrimary1),
        ),
        centerTitle: false,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: Obx(() => CircularAvatar(
                imagePath: profileController.imagePath.value,
                onTap: () => _pickImage(context),
                uploadIcon: IconButton(
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(context),
                ),
              )),
            ),
            const SizedBox(height: 16),
            // _buildTextField1('Contact Number', profileController.contactNumber.value),
            _buildTextField('Contact Number', profileController.contactNumber.value, (value) {
              profileController.contactNumber.value = value;
            }),
            // _buildTextField1('Contact Number', profileController.contactNumber.value),
            // _buildTextField1('Email', profileController.email.value),
            _buildTextField('Email', profileController.email.value, (value) {
              profileController.email.value = value;
            }),

            /// Blood Groups Dropdown--->>>
            FutureBuilder<List<String>>(
              future: ApiService.fetchBloodGroups(), // Fetch blood groups
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is fetched successfully
                  return _buildBloodGroupDropdown(snapshot.data!);
                }
              },
            ),

            // _buildTextField1('Samagra ID', profileController.samaraId.value),
            _buildTextField('Samagra ID', profileController.samaraId.value, (value) {
              profileController.samaraId.value = value;
            }),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Your Laptop Details Here!!!'),
                  ],
                ),
                // Show laptop details fields only if the switch is toggled on
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Laptop Brand', profileController.laptopBrand.value, (value) {
                      profileController.laptopBrand.value = value;
                    }),
                    _buildTextField('Laptop RAM', profileController.laptopRam.value, (value) {
                      profileController.laptopRam.value = value;
                    }),
                    _buildTextField('Laptop Processor', profileController.laptopProcessor.value, (value) {
                      profileController.laptopProcessor.value = value;
                    }),
                    _buildTextField('Laptop Configuration', profileController.laptopConfig.value, (value) {
                      profileController.laptopConfig.value = value;
                    }),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String text, void Function(String) onChanged) {
    TextEditingController controller = TextEditingController(text: text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBloodGroupDropdown(List<String> bloodGroups) {
    String initialValue = profileController.bloodGroup.value ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Blood Group'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      value: initialValue, // Set initial value here
      decoration: InputDecoration(
        labelText: 'Blood Group',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
      ),
      onChanged: (String? newValue) {
        profileController.bloodGroup.value =
        newValue!; // Update the selected blood group
      },
      items: [
        DropdownMenuItem<String>(
          value: 'Select Your Blood Group', // Set value for default prompt
          child: Text('Select Your Blood Group'), // Set text for default prompt
        ),
        ...bloodGroups.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      // Update the image path in the controller
      profileController.imagePath.value = pickedFile.path;
    }
  }

  // void _saveProfile() {
  //   // Perform save logic here
  // }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
                _updateProfileAndShowSnackbar();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Get.back(); // Pop back to EditProfile
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  // void _updateProfileAndShowSnackbar() {
  //   // Perform update logic here
  //   _saveProfile(); // Assuming this should save the profile
  //
  //   // Show Snackbar
  //   Get.snackbar('Profile Updated', 'Your profile has been updated.');
  //
  //   // Navigate back to the SettingsScreen
  //   Get.back(); // Assumes that you have a GetMaterialController associated with SettingsScreen
  // }

  // void _updateProfileAndShowSnackbar() async {
  //   // Perform update logic here
  //   // _saveProfile(); // Assuming this should save the profile
  //
  //   // Show Snackbar
  //   Get.snackbar('Profile Updated', 'Your profile has been updated.');
  //
  //   // Call the API service to update the profile
  //   await ApiService.updateProfile(
  //     contactNumber: profileController.contactNumber.value,
  //     email: profileController.email.value,
  //     samagraId: profileController.samaraId.value,
  //     laptop: profileController.laptopBrand.value,
  //     bloodGroup: profileController.bloodGroup.value,
  //     laptopBrand: profileController.laptopBrand.value,
  //     laptopRam: profileController.laptopRam.value,
  //     laptopProcessor: profileController.laptopProcessor.value,
  //     laptopConfig: profileController.laptopConfig.value,
  //     imagePath: profileController.imagePath.value,
  //   );
  //
  //   // Navigate back
  //   Get.back(); // This will go back to the previous screen
  // }

  void _updateProfileAndShowSnackbar() async {
    // Check if any of the laptop details is entered
    bool laptopDetailsEntered =
        profileController.laptopBrand.value.isNotEmpty ||
            profileController.laptopRam.value.isNotEmpty ||
            profileController.laptopProcessor.value.isNotEmpty ||
            profileController.laptopConfig.value.isNotEmpty;

    // Update the laptop value based on the condition
    profileController.laptopBrand.value.isEmpty &&
        profileController.laptopRam.value.isEmpty &&
        profileController.laptopProcessor.value.isEmpty &&
        profileController.laptopConfig.value.isEmpty
        ? profileController.laptop.value = '0'
        : profileController.laptop.value = '1';

    // Perform update logic here
    // _saveProfile(); // Assuming this should save the profile

    // Show Snackbar
    Get.snackbar('Profile Updated', 'Your profile has been updated.');

    // Call the API service to update the profile
    await ApiService.updateProfile(
      contactNumber: profileController.contactNumber.value,
      email: profileController.email.value,
      samagraId: profileController.samaraId.value,
      laptop: profileController.laptop.value,
      bloodGroup: profileController.bloodGroup.value,
      laptopBrand: profileController.laptopBrand.value,
      laptopRam: profileController.laptopRam.value,
      laptopProcessor: profileController.laptopProcessor.value,
      laptopConfig: profileController.laptopConfig.value,
      imagePath: profileController.imagePath.value,
    );

    // Navigate back
    Get.back(); // This will go back to the previous screen
  }


}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final Function onTap;
  final Widget uploadIcon;

  const CircularAvatar({
    Key? key,
    required this.imagePath,
    required this.onTap,
    required this.uploadIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: _buildAvatarContent(),
          ),
        ),
        uploadIcon,
      ],
    );
  }

  // Widget _buildAvatarContent() {
  //   if (imagePath.isNotEmpty) {
  //     if (imagePath.startsWith('http')) {
  //       // Display network image
  //       return Container(
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           image: DecorationImage(
  //             image: NetworkImage(imagePath),
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //       );
  //     } else {
  //       // Display local file image
  //       File file = File(imagePath);
  //       if (file.existsSync()) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             image: DecorationImage(
  //               image: FileImage(file),
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  //
  //   // Display default icon if imagePath is empty or invalid
  //   return const Icon(Icons.person, size: 50, color: Colors.white);
  // }

  Widget _buildAvatarContent() {
    if (imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        // Display network image directly
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else if (imagePath.startsWith('assets')) {
        // Display asset image
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else {
        // Assume local file image
        File file = File(imagePath);
        if (file.existsSync()) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(file),
                fit: BoxFit.fill,
              ),
            ),
          );
        }
      }
    }

    // Display default icon if imagePath is empty or invalid
    return const Icon(Icons.person, size: 50, color: Colors.white);
  }


}
 */

/// 0000000000

/*
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      profileController.imagePath.value = pickedFile.path;
    }
  }

  void _saveProfile() {
    // Perform save logic here
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _updateProfileAndShowSnackbar();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.back(); // Pop back to EditProfile
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _updateProfileAndShowSnackbar() {
    // Perform update logic here
    _saveProfile(); // Assuming this should save the profile

    // Show Snackbar
    Get.snackbar('Profile Updated', 'Your profile has been updated.');

    // Navigate back to the SettingsScreen
    Get.back(); // Assumes that you have a GetMaterialController associated with SettingsScreen
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const CircularAvatar({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
        child: imagePath.isEmpty ? const Icon(Icons.camera_alt) : null,
      ),
    );
  }
}


 */

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
// import 'package:image_picker/image_picker.dart';
// import '../controllers/profile_controller.dart';
//
// class EditProfile extends StatelessWidget {
//   final ProfileController profileController = Get.put(ProfileController());
//
//   EditProfile({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const GAppBar(
//         title: Text('Edit Profile'),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Hero(
//               tag: 'avatarHero',
//               child: CircularAvatar(
//                 imagePath: profileController.imagePath.value,
//                 onTap: () => _pickImage(context),
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField('Contact Number', profileController.contactNumber),
//             _buildTextField('Email', profileController.email),
//             _buildTextField('Blood Group', profileController.bloodGroup),
//             _buildTextField('Samara ID', profileController.samaraId),
//             const SizedBox(height: 16),
//             _buildLaptopSection(),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveProfile,
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _saveProfile();
//           Get.snackbar('Profile Updated', 'Your profile has been updated.');
//           Get.back();
//         },
//         child: const Icon(Icons.save),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, RxString controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: label,
//         ),
//         controller: TextEditingController(text: controller.value),
//         onChanged: (value) => controller.value = value,
//       ),
//     );
//   }
//
//   Widget _buildLaptopSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('Do you have a Laptop?'),
//             const SizedBox(width: 16),
//             Obx(
//                   () => Switch(
//                 value: profileController.hasLaptop.value,
//                 onChanged: (value) => profileController.toggleLaptop(value),
//               ),
//             ),
//           ],
//         ),
//         if (profileController.hasLaptop.value) ...[
//           _buildTextField('Laptop Brand', profileController.laptopBrand),
//           _buildTextField('Laptop RAM', profileController.laptopRam),
//           _buildTextField('Laptop Processor', profileController.laptopProcessor),
//           _buildTextField('Laptop Configuration', profileController.laptopConfig),
//         ],
//       ],
//     );
//   }
//
//   Future<void> _pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
//                 },
//                 child: const Text('Gallery'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
//                 },
//                 child: const Text('Camera'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     if (pickedFile != null) {
//       profileController.imagePath.value = pickedFile.path;
//     }
//   }
//
//   void _saveProfile() {
//     // Perform save logic here
//
//     /// back
//     Get.back();
//   }
// }
//
// class CircularAvatar extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onTap;
//
//   const CircularAvatar({super.key, required this.imagePath, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CircleAvatar(
//         radius: 40,
//         backgroundImage: imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
//         child: imagePath.isEmpty ? const Icon(Icons.camera_alt) : null,
//       ),
//     );
//   }
// }
/// ---->>>>>>>>>>>>>>>>>>>>
// class EditProfile extends StatelessWidget {
//   final ProfileController profileController = Get.put(ProfileController());
//   final String profilePhoto;
//   final String contactNo;
//   final String email;
//   final String bloodGroup;
//   final String samagraId;
//   final String laptop;
//   EditProfile({
//     Key? key,
//     required this.profilePhoto,
//     required this.contactNo,
//     required this.email,
//     required this.bloodGroup,
//     required this.samagraId,
//     required this.laptop,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     profileController.imagePath.value = profilePhoto; // Set the profile photo
//
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Edit Profile',
//           style: TextStyle(color: EColors.textColorPrimary1),
//         ),
//         centerTitle: false,
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Hero(
//               tag: 'avatarHero',
//               child: Obx(() => CircularAvatar(
//                 imagePath: profileController.imagePath.value,
//                 onTap: () => _pickImage(context),
//                 uploadIcon: IconButton(
//                   icon: const Icon(
//                     Icons.upload,
//                     color: Colors.white,
//                   ),
//                   onPressed: () => _pickImage(context),
//                 ),
//               )),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField('Contact Number', contactNo),
//             _buildTextField('Email', email),
//             _buildBloodGroupDropdown(),
//             _buildTextField('Samagra ID', samagraId),
//             const SizedBox(height: 16),
//             _buildLaptopSection(),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _showConfirmationDialog(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   Widget _buildTextField(String label, String text) {
//     RxString controller = RxString(text);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: EColors.textColorPrimary1),
//         ),
//         controller: TextEditingController(text: controller.value),
//         onChanged: (value) => controller.value = value,
//       ),
//     );
//   }
//
//   Widget _buildLaptopSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('Do you have a Laptop?'),
//             const SizedBox(width: 16),
//             Obx(
//                   () => Switch(
//                 activeColor: EColors.primarySecond,
//                 value: profileController.hasLaptop.value,
//                 onChanged: (value) => profileController.toggleLaptop(value),
//               ),
//             ),
//           ],
//         ),
//         Obx(() {
//           if (profileController.hasLaptop.value) {
//             return Column(
//               children: [
//                 _buildTextField('Laptop Brand', profileController.laptopBrand.value),
//                 _buildTextField('Laptop RAM', profileController.laptopRam.value),
//                 _buildTextField(
//                     'Laptop Processor', profileController.laptopProcessor.value),
//                 _buildTextField(
//                     'Laptop Configuration', profileController.laptopConfig.value),
//               ],
//             );
//           } else {
//             return Container(); // Empty container when switch is off
//           }
//         }),
//       ],
//     );
//   }
//
//   // Future<void> _pickImage(BuildContext context) async {
//   //   final picker = ImagePicker();
//   //   final pickedFile = await showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Select Image Source'),
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             ElevatedButton(
//   //               onPressed: () async {
//   //                 Navigator.of(context)
//   //                     .pop(await picker.pickImage(source: ImageSource.gallery));
//   //               },
//   //               child: const Text('Gallery'),
//   //             ),
//   //             ElevatedButton(
//   //               onPressed: () async {
//   //                 Navigator.of(context)
//   //                     .pop(await picker.pickImage(source: ImageSource.camera));
//   //               },
//   //               child: const Text('Camera'),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   //
//   //   if (pickedFile != null) {
//   //     profileController.imagePath.value = pickedFile.path;
//   //   }
//   // }
//
//   Future<void> _pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context)
//                       .pop(await picker.pickImage(source: ImageSource.gallery));
//                 },
//                 child: const Text('Gallery'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context)
//                       .pop(await picker.pickImage(source: ImageSource.camera));
//                 },
//                 child: const Text('Camera'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     if (pickedFile != null) {
//       // Remove the current image when a new image is picked
//       profileController.imagePath.value = '';
//       profileController.imagePath.value = pickedFile.path;
//     }
//   }
//
//   void _saveProfile() {
//     // Perform save logic here
//   }
//
//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Update Profile'),
//           content: const Text('Do you really want to update your profile?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 _updateProfileAndShowSnackbar(context);
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 Get.back(); // Pop back to EditProfile
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _updateProfileAndShowSnackbar(BuildContext context) async {
//     // Perform update logic here
//     _saveProfile(); // Assuming this should save the profile
//
//     // Show Snackbar
//     await Get.snackbar(
//       'Update Request Send',
//       'Your profile has been update soon.',
//       snackPosition: SnackPosition.TOP, // Change this position if needed
//       duration: const Duration(seconds: 2), // Adjust duration as needed
//     );
//
//     // Navigate back to the SettingsScreen after Snackbar is closed
//     Navigator.of(context).pop();
//   }
// }
/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api/api_services.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final String profilePhoto;
  final String contactNo;
  final String email;
  final String samagraId;
  final String laptop;
  final String bloodGroup;
  final String laptopBrand;
  final String laptopRam;
  final String laptopProcessor;
  final String laptopConfig;

  EditProfile({
    Key? key,
    required this.profilePhoto,
    required this.contactNo,
    required this.email,
    required this.samagraId,
    required this.laptop,
    required this.bloodGroup,
    required this.laptopBrand,
    required this.laptopRam,
    required this.laptopProcessor,
    required this.laptopConfig,
  }) : super(key: key) {
    // Initialize values in the controller when the widget is created
    profileController.imagePath.value = profilePhoto;
    profileController.contactNumber.value = contactNo;
    profileController.email.value = email;
    profileController.samaraId.value = samagraId;
    profileController.bloodGroup.value = bloodGroup;
    profileController.laptopBrand.value = laptopBrand;
    profileController.laptopRam.value = laptopRam;
    profileController.laptopProcessor.value = laptopProcessor;
    profileController.laptopConfig.value = laptopConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: EColors.textColorPrimary1),
        ),
        centerTitle: false,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: Obx(() => CircularAvatar(
                imagePath: profileController.imagePath.value,
                onTap: () => _pickImage(context),
                uploadIcon: IconButton(
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(context),
                ),
              )),
            ),
            const SizedBox(height: 16),
            _buildTextField1('Contact Number', profileController.contactNumber.value),
            _buildTextField1('Email', profileController.email.value),

            /// Blood Groups Dropdown--->>>
            FutureBuilder<List<String>>(
              future: ApiService.fetchBloodGroups(), // Fetch blood groups
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is fetched successfully
                  return _buildBloodGroupDropdown(snapshot.data!);
                }
              },
            ),

            _buildTextField1('Samagra ID', profileController.samaraId.value),
            const SizedBox(height: 16),
                 Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Your Laptop Details Here!!!'),

                    ],
                  ),
                  // Show laptop details fields only if the switch is toggled on
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         // _buildTextField1('Laptop Brand', profileController.laptopBrand.value),
                        _buildTextField('Laptop Brand', profileController.laptopBrand.value, (value) {
                          profileController.laptopBrand.value = value;
                       }),
                        _buildTextField('Laptop RAM', profileController.laptopRam.value, (value) {
                          profileController.laptopRam.value = value;
                        }),
                        _buildTextField('Laptop Processor', profileController.laptopProcessor.value, (value) {
                          profileController.laptopProcessor.value = value;
                        }),
                        _buildTextField('Laptop Configuration', profileController.laptopConfig.value, (value) {
                          profileController.laptopConfig.value = value;
                        }),
                      ],
                    ),
                ],
              ),

/*
            _buildTextField('Laptop Brand', profileController.laptopBrand.value),
            _buildTextField('Laptop RAM', profileController.laptopRam.value),
            _buildTextField('Laptop Processor', profileController.laptopProcessor.value),
            _buildTextField('Laptop Configuration', profileController.laptopConfig.value),
 */
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(String label, String text, void Function(String) onChanged) {
    TextEditingController controller = TextEditingController(text: text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField1(String label, String text) {
    RxString controller = RxString(text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: TextEditingController(text: controller.value),
        onChanged: (value) => controller.value = value,
      ),
    );
  }

  Widget _buildBloodGroupDropdown(List<String> bloodGroups) {
    String initialValue = profileController.bloodGroup.value ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Blood Group'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      value: initialValue, // Set initial value here
      decoration: InputDecoration(
        labelText: 'Blood Group',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
      ),
      onChanged: (String? newValue) {
        profileController.bloodGroup.value =
        newValue!; // Update the selected blood group
      },
      items: [
        DropdownMenuItem<String>(
          value: 'Select Your Blood Group', // Set value for default prompt
          child: Text('Select Your Blood Group'), // Set text for default prompt
        ),
        ...bloodGroups.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      // Check if the image is picked from the device's gallery or captured using the camera
      // If so, update the image path
      if (!(profileController.imagePath.value.startsWith('http') ||
          profileController.imagePath.value.startsWith('https'))) {
        profileController.imagePath.value = pickedFile.path;
      }
    }
  }


  void _saveProfile() async {
    // Retrieve userId and userType from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? ''; // Use the actual key used for user ID
    String userType = prefs.getString('user_type') ?? ''; // Use the actual key used for user type

    // Prepare the data to send
    Map<String, String> data = {
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
      'contact_no': profileController.contactNumber.value,
      'stud_email': profileController.email.value,
      'samagra_id': profileController.samaraId.value,
      'stud_bgroup': profileController.bloodGroup.value,
      'laptop': profileController.laptopBrand.value.isNotEmpty ? '1' : '0',
      'lap_brand': profileController.laptopBrand.value,
      'lap_ram': profileController.laptopRam.value,
      'lap_processor': profileController.laptopProcessor.value,
      'lap_config': profileController.laptopConfig.value,
    };

    // Call the API to update profile
    try {
      await ApiService.updateProfile(data, imagePath);
      // Show a snackbar to inform the user about the status of the update request
      Get.snackbar(
        'Update Request Sent',
        'Your profile has been updated.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (error) {
      // Handle errors
      print('Error updating profile: $error');
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again later.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }


  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _saveProfile(); // Call _saveProfile directly
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }




  Future<void> _updateProfileAndShowSnackbar(BuildContext context) async {
    _saveProfile();

    // Show Snackbar
    await Get.snackbar(
      'Update Request Sent',
      'Your profile has been updated.',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    // Navigate back to the SettingsScreen after Snackbar is closed
    Navigator.of(context).pop();
  }
}
 */

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:baderia_tech_wave/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/api/api_services.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final String profilePhoto;
  final String contactNo;
  final String email;
  final String samagraId;
  final String laptop;
  final String bloodGroup;
  final String laptopBrand;
  final String laptopRam;
  final String laptopProcessor;
  final String laptopConfig;

  EditProfile({
    Key? key,
    required this.profilePhoto,
    required this.contactNo,
    required this.email,
    required this.samagraId,
    required this.laptop,
    required this.bloodGroup,
    required this.laptopBrand,
    required this.laptopRam,
    required this.laptopProcessor,
    required this.laptopConfig,
  }) : super(key: key) {
    // Initialize values in the controller when the widget is created
    profileController.imagePath.value = profilePhoto;
    profileController.contactNumber.value = contactNo;
    profileController.email.value = email;
    profileController.samaraId.value = samagraId;
    profileController.bloodGroup.value = bloodGroup;
    profileController.laptopBrand.value = laptopBrand;
    profileController.laptopRam.value = laptopRam;
    profileController.laptopProcessor.value = laptopProcessor;
    profileController.laptopConfig.value = laptopConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.backgroundColor,
      appBar: const GAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: EColors.textColorPrimary1),
        ),
        centerTitle: false,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: Obx(() => CircularAvatar(
                imagePath: profileController.imagePath.value,
                onTap: () => _pickImage(context),
                uploadIcon: IconButton(
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(context),
                ),
              )),
            ),
            const SizedBox(height: 16),
            _buildTextField('Contact Number', profileController.contactNumber.value),
            _buildTextField('Email', profileController.email.value),

            /// Blood Groups Dropdown--->>>
            FutureBuilder<List<String>>(
              future: ApiService.fetchBloodGroups(), // Fetch blood groups
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is fetched successfully
                  return _buildBloodGroupDropdown(snapshot.data!);
                }
              },
            ),

            _buildTextField('Samagra ID', profileController.samaraId.value),
            const SizedBox(height: 16),

            Row(
              children: [
                Text('Laptop Information'),
              ],
            ),
            _buildTextField('Laptop Brand', profileController.laptopBrand.value),
            _buildTextField('Laptop RAM', profileController.laptopRam.value),
            _buildTextField('Laptop Processor', profileController.laptopProcessor.value),
            _buildTextField('Laptop Configuration', profileController.laptopConfig.value),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(String label, String text) {
    RxString controller = RxString(text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: TextEditingController(text: controller.value),
        onChanged: (value) => controller.value = value,
      ),
    );
  }

  Widget _buildBloodGroupDropdown(List<String> bloodGroups) {
    // print('Blood Groups length: ${bloodGroups.length}');
    // print('Blood Groups: $bloodGroups');
    // print('Selected Blood Group: ${profileController.bloodGroup.value}');

    String initialValue = profileController.bloodGroup.value ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select Your Blood Group'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      value: initialValue, // Set initial value here
      decoration: InputDecoration(
        labelText: 'Blood Group',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
      ),
      onChanged: (String? newValue) {
        print('New Blood Group selected: $newValue');
        profileController.bloodGroup.value =
            newValue!; // Update the selected blood group
      },
      items: [
        DropdownMenuItem<String>(
          value: 'Select Your Blood Group', // Set value for default prompt
          child: Text('Select Your Blood Group'), // Set text for default prompt
        ),
        ...bloodGroups.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      // Remove the current image when a new image is picked
      profileController.imagePath.value = '';
      profileController.imagePath.value = pickedFile.path;
    }
  }

  void _saveProfile() {
    // Perform save logic here
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _updateProfileAndShowSnackbar(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.back(); // Pop back to EditProfile
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfileAndShowSnackbar(BuildContext context) async {
    // Perform update logic here
    _saveProfile(); // Assuming this should save the profile

    // Show Snackbar
    await Get.snackbar(
      'Update Request Send',
      'Your profile has been update soon.',
      snackPosition: SnackPosition.TOP, // Change this position if needed
      duration: const Duration(seconds: 2), // Adjust duration as needed
    );

    // Navigate back to the SettingsScreen after Snackbar is closed
    Navigator.of(context).pop();
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final Function onTap;
  final Widget uploadIcon;

  const CircularAvatar({
    Key? key,
    required this.imagePath,
    required this.onTap,
    required this.uploadIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: 120, // Adjust width as needed
            height: 120, // Adjust height as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300], // Add a background color
            ),
            child: _buildAvatarContent(),
          ),
        ),
        uploadIcon,
      ],
    );
  }

  Widget _buildAvatarContent() {
    if (imagePath.isNotEmpty) {
      // Check if imagePath is a network image
      if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else {
        // Local file image
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.fill,
            ),
          ),
        );
      }
    } else {
      // Show default icon if imagePath is empty
      return const Icon(Icons.person, size: 50, color: Colors.white);
    }
  }
}


 */

/// Laptop Switch widget
/*
class LaptopSection extends StatelessWidget {
  final ProfileController profileController;

  const LaptopSection({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Do you have a Laptop?'),
            const SizedBox(width: 16),
            Obx(
              () => Switch(
                activeColor: EColors.primarySecond,
                value: profileController.hasLaptop.value,
                onChanged: (value) => profileController.toggleLaptop(value),
              ),
            ),
          ],
        ),
        Obx(() {
          if (profileController.hasLaptop.value) {
            return Column(
              children: [
                _buildTextField('Laptop Brand', profileController.laptopBrand),
                _buildTextField('Laptop RAM', profileController.laptopRam),
                _buildTextField(
                  'Laptop Processor',
                  profileController.laptopProcessor,
                ),
                _buildTextField(
                  'Laptop Configuration',
                  profileController.laptopConfig,
                ),
              ],
            );
          } else {
            return Container(); // Empty container when switch is off
          }
        }),
      ],
    );
  }

  Widget _buildTextField(String label, RxString controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        ),
        controller: TextEditingController(text: controller.value),
        onChanged: (value) => controller.value = value,
      ),
    );
  }
}

 */

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
// import 'package:baderia_tech_wave/utils/constants/colors.dart';
// import 'package:image_picker/image_picker.dart';
// import '../controllers/profile_controller.dart';
//
// class EditProfile extends StatelessWidget {
//   final ProfileController profileController = Get.put(ProfileController());
//
//   EditProfile({
//     super.key, required String profilePhoto, required contactNo, required email, required bloodGroup, required samagraId, required laptop,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: EColors.backgroundColor,
//       appBar: const GAppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Edit Profile',
//           style: TextStyle(color: EColors.textColorPrimary1),
//         ),
//         centerTitle: false,
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Hero(
//               tag: 'avatarHero',
//               child: Obx(() => CircularAvatar(
//                     imagePath: profileController.imagePath.value,
//                     onTap: () => _pickImage(context),
//                     // Add an IconButton with an "Upload" icon
//                     uploadIcon: IconButton(
//                       icon: const Icon(
//                         Icons.upload,
//                         color: Colors.white,
//                       ), // You can customize the icon here
//                       onPressed: () => _pickImage(context),
//                     ),
//                   )),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField('Contact Number', profileController.contactNumber),
//             _buildTextField('Email', profileController.email),
//             _buildTextField('Blood Group', profileController.bloodGroup),
//             _buildTextField('Samara ID', profileController.samaraId),
//             const SizedBox(height: 16),
//             _buildLaptopSection(),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _showConfirmationDialog(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, RxString controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         decoration: InputDecoration(
//             labelText: label,
//             labelStyle: const TextStyle(color: EColors.textColorPrimary1)),
//         controller: TextEditingController(text: controller.value),
//         onChanged: (value) => controller.value = value,
//       ),
//     );
//   }
//
//   Widget _buildLaptopSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('Do you have a Laptop?'),
//             const SizedBox(width: 16),
//             Obx(
//               () => Switch(
//                 activeColor: EColors.primarySecond,
//                 value: profileController.hasLaptop.value,
//                 onChanged: (value) => profileController.toggleLaptop(value),
//               ),
//             ),
//           ],
//         ),
//         Obx(() {
//           if (profileController.hasLaptop.value) {
//             return Column(
//               children: [
//                 _buildTextField('Laptop Brand', profileController.laptopBrand),
//                 _buildTextField('Laptop RAM', profileController.laptopRam),
//                 _buildTextField(
//                     'Laptop Processor', profileController.laptopProcessor),
//                 _buildTextField(
//                     'Laptop Configuration', profileController.laptopConfig),
//               ],
//             );
//           } else {
//             return Container(); // Empty container when switch is off
//           }
//         }),
//       ],
//     );
//   }
//
//   Future<void> _pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Image Source'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context)
//                       .pop(await picker.pickImage(source: ImageSource.gallery));
//                 },
//                 child: const Text('Gallery'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context)
//                       .pop(await picker.pickImage(source: ImageSource.camera));
//                 },
//                 child: const Text('Camera'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//     if (pickedFile != null) {
//       profileController.imagePath.value = pickedFile.path;
//     }
//   }
//
//   void _saveProfile() {
//     // Perform save logic here
//   }
//
//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Update Profile'),
//           content: const Text('Do you really want to update your profile?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 _updateProfileAndShowSnackbar(context);
//               },
//               child: const Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 Get.back(); // Pop back to EditProfile
//               },
//               child: const Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _updateProfileAndShowSnackbar(BuildContext context) async {
//     // Perform update logic here
//     _saveProfile(); // Assuming this should save the profile
//
//     // Show Snackbar
//     await Get.snackbar(
//       'Update Request Send',
//       'Your profile has been update soon.',
//       snackPosition: SnackPosition.TOP, // Change this position if needed
//       duration: const Duration(seconds: 2), // Adjust duration as needed
//     );
//
//     // Navigate back to the SettingsScreen after Snackbar is closed
//     Navigator.of(context).pop();
//   }
// }
//
// class CircularAvatar extends StatelessWidget {
//   final String imagePath;
//   final Function onTap;
//   final Widget uploadIcon; // Add this property
//
//   const CircularAvatar(
//       {super.key,
//       required this.imagePath,
//       required this.onTap,
//       required this.uploadIcon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         GestureDetector(
//           onTap: () => onTap(),
//           child: CircleAvatar(
//             radius: 50,
//             backgroundImage:
//                 imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
//             child: imagePath.isEmpty
//                 ? const Icon(Icons.person, size: 50, color: Colors.white)
//                 : null,
//           ),
//         ),
//         // Add the uploadIcon
//         uploadIcon,
//       ],
//     );
//   }
// }

/*

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/appbar/appbar.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  EditProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(
        title: Text('Edit Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: Obx(() => CircularAvatar(
                imagePath: profileController.imagePath.value,
                onTap: () => _pickImage(context),
              )),
            ),
            const SizedBox(height: 16),
            _buildTextField('Contact Number', profileController.contactNumber),
            _buildTextField('Email', profileController.email),
            _buildTextField('Blood Group', profileController.bloodGroup),
            _buildTextField('Samara ID', profileController.samaraId),
            const SizedBox(height: 16),
            _buildLaptopSection(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveProfile();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildTextField(String label, RxString controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
        ),
        controller: TextEditingController(text: controller.value),
        onChanged: (value) => controller.value = value,
      ),
    );
  }

  Widget _buildLaptopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Do you have a Laptop?'),
            const SizedBox(width: 16),
            Obx(
                  () => Switch(
                value: profileController.hasLaptop.value,
                onChanged: (value) => profileController.toggleLaptop(value),
              ),
            ),
          ],
        ),
        Obx(() {
          if (profileController.hasLaptop.value) {
            return Column(
              children: [
                _buildTextField('Laptop Brand', profileController.laptopBrand),
                _buildTextField('Laptop RAM', profileController.laptopRam),
                _buildTextField('Laptop Processor', profileController.laptopProcessor),
                _buildTextField('Laptop Configuration', profileController.laptopConfig),
              ],
            );
          } else {
            return Container(); // Empty container when switch is off
          }
        }),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
                },
                child: const Text('Gallery'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
                },
                child: const Text('Camera'),
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      profileController.imagePath.value = pickedFile.path;
    }
  }

  void _saveProfile() {
    // Perform save logic here
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('Do you really want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _updateProfileAndShowSnackbar();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.back(); // Pop back to EditProfile
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _updateProfileAndShowSnackbar() {
    // Perform update logic here
    _saveProfile(); // Assuming this should save the profile

    // Show Snackbar
    Get.snackbar('Profile Updated', 'Your profile has been updated.');

    // Navigate back to the SettingsScreen
    Get.back(); // Assumes that you have a GetMaterialController associated with SettingsScreen
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const CircularAvatar({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
        child: imagePath.isEmpty ? const Icon(Icons.camera_alt) : null,
      ),
    );
  }
}


 */
