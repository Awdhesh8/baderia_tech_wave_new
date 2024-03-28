/*
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Make sure you have imported the Iconsax package
import 'package:shimmer/shimmer.dart'; // Import the Shimmer package
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart'; // Assuming you have your colors defined in this file

class EducationDetailsPanel extends StatefulWidget {
  @override
  _EducationDetailsPanelState createState() => _EducationDetailsPanelState();
}
//
class _EducationDetailsPanelState extends State<EducationDetailsPanel> {
  late Future<Map<String, dynamic>> _educationalDetailsFuture;
  final ApiService _apiService = ApiService(); // Creating an instance of ApiService

  @override
  void initState() {
    super.initState();
    _educationalDetailsFuture = _apiService.fetchEducationalDetails(); // Calling the method using the instance
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _educationalDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerEducationDetails(); // Display shimmer effect while data is loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!['success']) {
          List<dynamic> educationalDetailsResponse = snapshot.data!['data']['response'];
          List<Map<String, dynamic>> educationalDetails = educationalDetailsResponse.map((entry) {
            return {
              'type': entry['type'],
              'details': (entry['details'] as List).isNotEmpty ? entry['details'][0] : {}, // Check if 'details' list is not empty before accessing the first element
            };
          }).toList();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: ShapeDecoration(
                color: EColors.lightContainer1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                children: educationalDetails.map((entry) {
                  return ListTile(
                    trailing: const Icon(
                      Iconsax.folder_open4,
                      color: EColors.primary,
                    ),
                    title: Text(entry['type']),
                    onTap: () {
                      _showEducationalDetailsDialog(context, entry);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Center(child: Text('Failed to fetch data'));
        }
      },
    );
  }

  void _showEducationalDetailsDialog(BuildContext context, Map<String, dynamic> details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        details['type'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: EColors.primary, // Customize the color
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (var key in details['details'].keys)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: EColors.textColorPrimary1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  details['details'][key].toString(),
                                  style: const TextStyle(
                                    color: EColors.primarySecond,
                                  ),
                                  maxLines: 2, // Adjust the number of lines
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ShimmerEducationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        decoration: ShapeDecoration(
          color: EColors.lightContainer1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          children: List.generate(
            5, // Generate 5 shimmering list tiles
                (index) => ListTile(
              title: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
              trailing: Icon(
                Iconsax.folder_open4,
                color: EColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 */

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import '../../../../../data/api/api_services.dart';
import '../../../../../utils/constants/colors.dart';

class EducationDetailsPanel extends StatefulWidget {
  @override
  _EducationDetailsPanelState createState() => _EducationDetailsPanelState();
}
class _EducationDetailsPanelState extends State<EducationDetailsPanel> {
  late Future<Map<String, dynamic>> _educationalDetailsFuture;
  final ApiService _apiService = ApiService(); // Creating an instance of ApiService

  @override
  void initState() {
    super.initState();
    _educationalDetailsFuture = _apiService.fetchEducationalDetails(); // Calling the method using the instance
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.40;

    return FutureBuilder<Map<String, dynamic>>(
      future: _educationalDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerEducationDetails(); // Display shimmer effect while data is loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!['success']) {
          List<dynamic> educationalDetailsResponse = snapshot.data!['data']['response'];
          List<Map<String, dynamic>> educationalDetails = educationalDetailsResponse.map((entry) {
            return {
              'type': entry['type'],
              'details': (entry['details'] as List).isNotEmpty ? entry['details'][0] : {}, // Check if 'details' list is not empty before accessing the first element
            };
          }).toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                // height: containerHeight,
                decoration: ShapeDecoration(
                  color: EColors.white,
                  // color: EColors.lightContainer1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),

                  ),
                ),
                child: Column(
                  children: educationalDetails.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Container(
                        decoration: CustomDeco.neoDecoIconRectangle3(),
                        // decoration: BoxDecoration(
                        //   boxShadow: [
                        //     BoxShadow(
                        //       blurRadius: 0,
                        //       offset: Offset(-2, -2),
                        //       color: Colors.white
                        //     )
                        //   ],
                        //     color: EColors.lightContainer1,
                        //   borderRadius: BorderRadius.circular(14)
                        // ),
                        child: ListTile(
                          dense: true,
                          trailing: Container(
                               decoration: CustomDeco.neoDecoIconRectangle2(),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: const Icon(
                                Iconsax.folder_open4, size: 18,
                                color: EColors.primary,
                              ),
                            ),
                          ),
                          // trailing: const Icon(
                          //   Iconsax.folder_open4,
                          //   color: EColors.primary,
                          // ),
                          title: Text(entry['type']),
                          onTap: () {
                            _showEducationalDetailsDialog(context, entry);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text('Failed to fetch data'));
        }
      },
    );
  }

  void _showEducationalDetailsDialog(BuildContext context, Map<String, dynamic> details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        details['type'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: EColors.primary, // Customize the color
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (var key in details['details'].keys)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: EColors.textColorPrimary1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  details['details'][key].toString(),
                                  style: const TextStyle(
                                    color: EColors.primarySecond,
                                  ),
                                  maxLines: 2, // Adjust the number of lines
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ShimmerEducationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: ShapeDecoration(
            color: EColors.lightContainer1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            children: List.generate(
              5, // Generate 5 shimmering list tiles
                  (index) => ListTile(
                title: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0,
                                  offset: Offset(-2, -2),
                                  color: Colors.white
                              )
                            ],
                            color: EColors.lightContainer1,
                            borderRadius: BorderRadius.circular(14)
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





/// ------
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';

class EducationDetailsPanel extends StatefulWidget {
  @override
  _EducationDetailsPanelState createState() => _EducationDetailsPanelState();
}

class _EducationDetailsPanelState extends State<EducationDetailsPanel> {
  late Future<Map<String, dynamic>> _educationalDetailsFuture;

  @override
  void initState() {
    super.initState();
    _educationalDetailsFuture = fetchEducationalDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _educationalDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!['success']) {
          List<dynamic> educationalDetailsResponse = snapshot
              .data!['data']['response'];
          List<Map<String,
              dynamic>> educationalDetails = educationalDetailsResponse.map((
              entry) {
            return {
              'type': entry['type'],
              'details': (entry['details'] as List).isNotEmpty
                  ? entry['details'][0]
                  : {},
            };
          }).toList();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: ShapeDecoration(
                color: EColors.lightContainer1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                children: educationalDetails.map((entry) {
                  return ListTile(
                    trailing: const Icon(
                      Iconsax.folder_open4,
                      color: EColors.primary,
                    ),
                    title: Text(entry['type']),
                    onTap: () {
                      _showEducationalDetailsDialog(context, entry);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Center(child: Text('Failed to fetch data'));
        }
      },
    );
  }

  void _showEducationalDetailsDialog(BuildContext context,
      Map<String, dynamic> details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        details['type'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: EColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (var key in details['details'].keys)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: EColors.textColorPrimary1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  details['details'][key].toString(),
                                  style: const TextStyle(
                                    color: EColors.primarySecond,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
Future<Map<String, dynamic>> fetchEducationalDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('user_id') ?? '';
  var userType = prefs.getString('user_type') ?? '';

  var headers = {
    'Cookie': 'ci_session=s63p3q25pe1l70smdpptatqmg0j2vb8p'
  };

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://myglobalapp.in/global/API005/profile_educational'),
  );
  request.fields.addAll({
    'APIKEY': 'GNCS0225',
    'USER_ID': userId,
    'USER_TYPE': userType,
  });

  request.headers.addAll(headers);

  print('Sending request to API...');
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    print('Response received from API: $responseBody');
    var parsedResponse = json.decode(responseBody);

    if (parsedResponse['status'] == "1") {
      print('API call successful');
      return {'success': true, 'data': parsedResponse};
    } else {
      print('API call failed. Error message: ${parsedResponse['message']}');
      return {'success': false, 'error': parsedResponse['message']};
    }
  } else {
    print('API request failed with status: ${response.statusCode}');
    return {
      'success': false,
      'error': 'Request failed with status: ${response.statusCode}'
    };
  }
}


 */
/// -----

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../utils/constants/colors.dart';
//
// List<Map<String, dynamic>> educationalDetails = [
//   {
//     'type': 'High School',
//     'details': {
//       'School': 'ABC High School',
//       'Board': 'State Board',
//       'Passing Year': '2020',
//       'Stream': 'All',
//       'Maths': '98',
//       'English': '98',
//       'Physics': '98',
//       'Biology': '98',
//       'Sanskrit': '98',
//       'Chemistry': '98',
//       'Percentage': '85%',
//     },
//   },
//   {
//     'type': 'Higher Secondary School',
//     'details': {
//       'School': 'XYZ Higher Secondary School',
//       'Board': 'State Board',
//       'Passing Year': '2022',
//       'Stream': 'PCM',
//       'Maths': '98',
//       'English': '98',
//       'Physics': '98',
//       'Chemistry': '98',
//       'Hindi': '98',
//       'Percentage': '85%',
//     },
//   },
//   {
//     'type': 'College',
//     'details': {
//       'Name': 'Global Engineering College',
//       'Semester': '3rd',
//       'Branch': 'Computer Science',
//       'CGPA': '9.5',
//     },
//   },
//   {
//     'type': 'Internship',
//     'details': {
//       'Company': 'Tech Solutions Ltd.',
//       'Duration': '3 months',
//       'Role': 'Software Developer Intern',
//     },
//   },
//   {
//     'type': 'Project',
//     'details': {
//       'Title': 'Smart Home Automation',
//       'Duration': '6 months',
//       'Description':
//           'Developed a system for automating home appliances using IoT',
//     },
//   },
//   {
//     'type': 'Achievements',
//     'details': {
//       '1': 'Winner - Coding Competition',
//       '2': 'Runner-up - Science Exhibition',
//     },
//   },
// ];
//
// class EducationDetailsPanel extends StatelessWidget {
//   final List<Map<String, dynamic>> educationalDetails;
//
//   const EducationDetailsPanel({
//     Key? key,
//     required this.educationalDetails,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Container(
//         decoration: ShapeDecoration(
//           color: EColors.lightContainer1,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         ),
//         child: Column(
//           children: educationalDetails.map((entry) {
//             return ListTile(
//               trailing: const Icon(
//                 Iconsax.folder_open4,
//                 color: EColors.primary,
//               ),
//               title: Text(entry['type']),
//               onTap: () {
//                 // Show educational details in AlertDialog
//                 _showEducationalDetailsDialog(context, entry);
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   void _showEducationalDetailsDialog(BuildContext context, Map<String, dynamic> details) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         details['type'],
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: EColors.primary, // Customize the color
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       for (var key in details['details'].keys)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   key,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: EColors.textColorPrimary1,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 flex: 3,
//                                 child: Text(
//                                   details['details'][key],
//                                   style: const TextStyle(
//                                     color: EColors.primarySecond,
//                                   ),
//                                   maxLines: 2, // Adjust the number of lines
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       const SizedBox(height: 16),
//                       Align(
//                         alignment: Alignment.center,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('Close'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
// }

