import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/personalization/screens/settings/edit_profile/edit_Profile.dart';
import '../../features/home/screens/right_circle_menu_and_screens/activity/activity.dart';
import '../../features/home/screens/right_circle_menu_and_screens/vt_letter/widgets/vt_letter_form.dart';
import '../../features/home/screens/left_circle_menu_and_screens/gate_pass/widgets/gate_pass_form_widget/gate_pass_form.dart';

class ApiService {
  /// User Login --->>>
  static Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    try {
      var headers = {
        'Cookie':
            'ci_session=trb1cdm1k01ka4jrt6t55nrstv6frt8p; remember_code=529f1face76aad1813e947055101a76386950be0.e599f6271f11ddc484b1e8288df76ed79742de7399f1cd73f46f29113b68db349035fc15cdae996a5df0a4faec0d53c40d3b666f6336fc9ea236da0428f702c6'
      };

      var request = http.MultipartRequest('POST',
          Uri.parse(APIConstants.getFullUrl(APIConstants.loginEndpoint)));
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USERNAME': username,
        'PASSWORD': password,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(await response.stream.bytesToString());
        return data;
      } else {
        throw Exception('Failed to login. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  /// Get Profile Data --->>>
  static Future<Map<String, dynamic>?> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    String userType = prefs.getString('user_type') ?? '';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(APIConstants.getFullUrl(APIConstants.getProfileEndpoint)),
    );
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
    });

    request.headers.addAll(APIConstants.headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = json.decode(await response.stream.bytesToString());

        // Check if 'response' key is present and not null
        if (responseData.containsKey('response') &&
            responseData['response'] != null) {
          return responseData;
        } else {
          if (kDebugMode) {
            print('Error: Missing or null "response" key in the API response.');
          }
          return null;
        }
      } else {
        if (kDebugMode) {
          print('API error: ${response.reasonPhrase}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in API call: $e');
      }
      return null;
    }
  }

  /// Get Rank Attendance -->>>
  static Future<Map<String, dynamic>?> getRankAndAttendanceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    String userType = prefs.getString('user_type') ?? '';

    var request = http.MultipartRequest(
        'POST', Uri.parse(APIConstants.getFullUrl('get_rankattend')));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
    });

    request.headers.addAll(APIConstants.headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = json.decode(await response.stream.bytesToString());
        return responseData;
      } else {
        if (kDebugMode) {
          print('API error: ${response.reasonPhrase}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in API call: $e');
      }
      return null;
    }
  }

  /// Get Blood Group --->>>
  static Future<List<BloodGroup>> fetchBloodGroups() async {
    try {
      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.getBloodGroup)),
        headers: APIConstants.headers,
        body: {'APIKEY': 'GNCS0225'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == "1") {
          List<dynamic> bloodGroupData = data['response'];
          List<BloodGroup> bloodGroups = bloodGroupData
              .map((bloodGroupJson) => BloodGroup.fromJson(bloodGroupJson))
              .toList();
          return bloodGroups;
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception(
            'Failed to load blood groups: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Exception while fetching blood groups: $e');
    }
  }

  /// Edit Profile --->>>>
  static Future<void> updateProfile({
    required String contactNumber,
    required String email,
    required String samagraId,
    required String laptop,
    required String bloodGroup,
    required String laptopBrand,
    required String laptopRam,
    required String laptopProcessor,
    required String laptopConfig,
    required String imagePath,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('user_id') ?? '';
      String userType = prefs.getString('user_type') ?? '';

      var headers = APIConstants.headers;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.getFullUrl(APIConstants.updateProfile)),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId, // Ensure this is not an empty string
        'USER_TYPE': userType,
        'contact_no': contactNumber,
        'stud_email': email,
        'samagra_id': samagraId,
        'laptop': laptop,
        'stud_bgroup': bloodGroup,
        'lap_brand': laptopBrand,
        'lap_ram': laptopRam,
        'lap_processor': laptopProcessor,
        'lap_config': laptopConfig,
      });

      // Check if imagePath is a network URL starting with 'http' or 'https'
      if (imagePath.startsWith('http')) {
        // Add the image URL directly to the request
        request.fields['form_file'] = imagePath;
      } else if (imagePath.startsWith('assets')) {
        // Load the asset image and add it to the request
        ByteData byteData = await rootBundle.load(imagePath);
        List<int> imageData = byteData.buffer.asUint8List();
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'form_file', imageData,
            filename: imagePath);
        request.files.add(multipartFile);
      } else {
        // Assume local file image
        var imageFile =
            await http.MultipartFile.fromPath('form_file', imagePath);
        request.files.add(imageFile);
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(await response.stream.bytesToString());
        }
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  /// Get Educational Info --->>>
  Future<Map<String, dynamic>> fetchEducationalDetails() async {
    // Removed static keyword
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var userType = prefs.getString('user_type') ?? '';

    var headers = {'Cookie': 'ci_session=s63p3q25pe1l70smdpptatqmg0j2vb8p'};

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

    if (kDebugMode) {
      print('Sending request to API...');
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print('Response received from API: $responseBody');
      }
      var parsedResponse = json.decode(responseBody);

      if (parsedResponse['status'] == "1") {
        if (kDebugMode) {
          print('API call successful');
        }
        return {'success': true, 'data': parsedResponse};
      } else {
        if (kDebugMode) {
          print('API call failed. Error message: ${parsedResponse['message']}');
        }
        return {'success': false, 'error': parsedResponse['message']};
      }
    } else {
      if (kDebugMode) {
        print('API request failed with status: ${response.statusCode}');
      }
      return {
        'success': false,
        'error': 'Request failed with status: ${response.statusCode}'
      };
    }
  }

  /// Get Time Table  --->>>>
  static Future<Map<String, dynamic>> fetchTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var userType = prefs.getString('user_type') ?? '';

    if (kDebugMode) {
      print(userId);
    }
    if (kDebugMode) {
      print(userType);
    }

    var headers = {
      'Cookie': 'ci_session=ga2gv43kdoaqr8bs0f91tqof0rss55r4',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(APIConstants.getFullUrl(APIConstants.getTimeTable)));
    // var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/API005/student_timetable'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          json.decode(await response.stream.bytesToString());
      return data;
    } else {
      throw Exception('Failed to load timetable');
    }
  }

  /*
  /// By using GetX
  static Future<Map<String, dynamic>> fetchTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var userType = prefs.getString('user_type') ?? '';



    var headers = {
      'Cookie': 'ci_session=ga2gv43kdoaqr8bs0f91tqof0rss55r4',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(APIConstants.getFullUrl(APIConstants.getTimeTable)),
    );
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'USER_TYPE': userType,
    });
    print(userId);
    print(userType);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data =
        json.decode(await response.stream.bytesToString());

        // Check if the response is a list and convert it to a map if necessary
        if (data['response'] is List) {
          List<dynamic> timetableDataList = data['response'];
          Map<String, dynamic> convertedData = {};

          for (var dayData in timetableDataList) {
            String day = dayData.keys.first;
            convertedData[day] = dayData[day];
          }

          return {'response': convertedData};
        } else {
          return {'response': data['response']};
        }
      } catch (e) {
        throw Exception('Error parsing response: $e');
      }
    } else {
      throw Exception('Failed to load timetable');
    }
  }
   */

  /// Library Search --->
  static Future<List<Map<String, dynamic>>> bookSearch(
      String searchKeyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var userType = prefs.getString('user_type') ?? '';
    var employerId = prefs.getString('emp_id') ?? '';

    try {
      var headers = {
        'Cookie': 'ci_session=1t3b502csempj6ti9mak02q48j6h2k1g',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.getFullUrl(APIConstants.getBooks)),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'srch_keyword': searchKeyword,
        'USER_ID': userId,
      });
      if (kDebugMode) {
        print(request);
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        return List<Map<String, dynamic>>.from(jsonResponse['response']);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return []; // Return an empty list in case of an error
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      return []; // Return an empty list in case of an error
    }
  }

  /// Lock unlock Books
  Future<void> updateLockStatus(
      String bookId, bool newLockStatus, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    try {
      var headers = {'Cookie': 'ci_session=41u6ft1qdlm59a6h30cuc0or6p46ot2m'};
      var request = http.MultipartRequest('POST',
          Uri.parse(APIConstants.getFullUrl(APIConstants.lockOrUnlockBooks))
          // Uri.parse('http://myglobalapp.in/global/API005/lock_book'),
          );

      // Set request fields
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'book_id': bookId,
        'lock_status': newLockStatus.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(await response.stream.bytesToString());
        // Print the response data
        if (kDebugMode) {
          print('Response Data: $responseData');
        }

        // Handle the response data as needed
        var status = responseData['status'];
        var message = responseData['message'];

        if (status == '1') {
          // Update was successful, handle accordingly
          if (kDebugMode) {
            print('Lock Status Updated Successfully');
          }

          // Show a SnackBar with the success message
          Get.snackbar(
            'Lock Status : ',
            '$message',
            colorText: EColors.textColorPrimary1,
          );
          // Get.snackbar('Lock Status : $message', 'You can now take the book from the college library.');

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Lock Status Updated Successfully. You can now take the book from the college library.'),
          //     duration: Duration(seconds: 4),
          //   ),
          // );
        } else {
          // Update failed, handle accordingly
          if (kDebugMode) {
            print('Lock Status Update Failed: $message');
          }

          // Show a SnackBar with the failure message
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Lock Status Update Failed: $message'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
          Get.snackbar('Lock Status Update Failed: ', '$message');
        }
      } else {
        // Print the reason phrase in case of non-200 status code
        print('Error: ${response.reasonPhrase}');

        // Show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.reasonPhrase}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Handle any other errors that might occur during the request
      if (kDebugMode) {
        print('Error updating lock status: $error');
      }

      // Show a SnackBar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating lock status: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// eLibrary
  static Future<List<Map<String, dynamic>>> getEBooks(
      String searchKeyword) async {
    try {
      var headers = {
        'Cookie': 'ci_session=7am93kpc7ut7avqqauh42l8t8pk9a1u8',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.getFullUrl(APIConstants.getEBooks)),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'srch_keyword': searchKeyword,
      });
      if (kDebugMode) {
        print(request);
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        return List<Map<String, dynamic>>.from(jsonResponse['response']);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return []; // Return an empty list in case of an error
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      return []; // Return an empty list in case of an error
    }
  }

  /// IssueBooks History ---->>>
  static Future<Map<String, dynamic>> issuedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userType = prefs.getString('user_type') ?? '';
    var empID = prefs.getString('emp_id') ?? '';

    if (kDebugMode) {
      print("EMP_ID: $empID");
    }
    // print("USER_TYPE: $userType");

    var headers = {
      'Content-Type':
          'application/x-www-form-urlencoded', // Set the correct content type
      'Cookie': 'ci_session=emi9l982e536e4alkaneli56uq6vghqb',
    };

    var body = {
      'APIKEY': 'GNCS0225',
      'emp_id': empID,
      'USER_TYPE': userType,
    };

    var uri = Uri.parse(APIConstants.getFullUrl(APIConstants.issuedBooks));
    var response = await http.post(uri, headers: headers, body: body);

    /*
    print('Link URL: ${response.request}');
    print("Headers: ${response.headers}");
    print("Code: ${response.statusCode}");
    print('Body: ${response.body}');
    print(empID);
    print("Print Response : $response");
    */

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load Issue Book History Data');
    }
  }

  /// Book History ---->>>
  static Future<Map<String, dynamic>> libraryHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userType = prefs.getString('user_type') ?? '';
    var empID = prefs.getString('emp_id') ?? '';

    print("EMP_ID: $empID");
    print("USER_TYPE: $userType");

    var headers = {
      'Cookie':
          'ci_session=06idajds6tidndrcefdn7cqj6qvqu2k5; remember_code=3fe3befddf2e48650ddc76d5d6697a61cfbf4ed6.156bad30a0afd8ce50fb8553e490c99d170e19371cf15b4366cad31d125d8279806b12813a77c9d93859ad8b3d4c157324dbf43326429d7138599ed5aa06965a',
    };

    var body = {
      'APIKEY': 'GNCS0225',
      'emp_id': empID,
      'USER_TYPE': userType,
    };

    var uri = Uri.parse(APIConstants.getFullUrl(APIConstants.libraryHistory));
    var response = await http.post(uri, headers: headers, body: body);

    /*
    print('Link URL: ${response.request}');
    print("Headers: ${response.headers}");
    print("Code: ${response.statusCode}");
    print('Body: ${response.body}');
    print(empID);
    print("Print Response : $response");
     */

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load History Data');
    }
  }

  /// Attendance (In Calender)
  static Future<Map<String, dynamic>> getAttendanceData(
      int year, int month) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String empId = prefs.getString('emp_id') ?? '';
      String userType = prefs.getString('user_type') ?? '';

      var headers = {
        'Cookie': 'ci_session=6tb2g58tb2c3cn3io2q8p3eei2re7soo',
      };

      var request = http.MultipartRequest('POST',
          Uri.parse(APIConstants.getFullUrl(APIConstants.attendanceCalender)));
      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'emp_id': empId,
        'USER_TYPE': userType,
        'year': year.toString(),
        'month': month.toString(),
      });
      /*
          print('Emp id: $empId');
          print('user type: $userType');
          print('year: $year');
          print('month: $month');
          print('request fields: ${request.fields}');
          print('request headers: ${request.headers}');
          print('request headers: ${request.method}');

       */

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      /*
      print('Response: $response');
      print('Response: ${response.stream}');
      print('Request: $request');
       */

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        return jsonData;
      } else {
        return {'error': response.reasonPhrase};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  /// Fees
  static Future<Map<String, dynamic>> fetchFeeSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String empId = prefs.getString('emp_id') ?? '';
    String userType = prefs.getString('user_type') ?? '';
    var headers = {
      'Cookie':
          'ci_session=edn7k256dg192cpgoa8qltoc355qma65; remember_code=192544114397b621016b697351b3071fd3e499b5.caea73eb212ce286f0a0eca04192926bd52e2a0ce1f90a928834801fd9a4f355d64005f9426390aafb37e68a807fd6e907c88ce541d6f50b2d20d8a50a29bb3c'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://myglobalapp.in/global/API005/feesummary'));

    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'emp_id': empId,
      'USER_TYPE': userType,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        if (jsonResponse.containsKey('response')) {
          return jsonResponse['response'];
        } else {
          throw Exception("Response data not found in the response");
        }
      } else {
        throw Exception(
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Apply Leave
  static Future<String> applyLeave({
    required String applyFrom,
    required String applyTo,
    required String reason,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var headers = {
        'Cookie': 'ci_session=9918717oip21ucg7572uevf8cn0e3f5u',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://myglobalapp.in/global/API005/applyleave'),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'applyfrom': applyFrom,
        'applyto': applyTo,
        'reason': reason,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        String message = jsonResponse['message'] ?? 'Unknown response';

        return message;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return 'Error occurred: ${response.reasonPhrase}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error applying leave: $e');
      }
      return 'Error occurred: $e';
    }
  }

  /// Get Leave History
  static Future<List<Map<String, dynamic>>> getLeaveHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var headers = {
        'Cookie': 'ci_session=9918717oip21ucg7572uevf8cn0e3f5u',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://myglobalapp.in/global/API005/get_leavehistory'),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        if (kDebugMode) {
          print(responseBody);
        }
        if (kDebugMode) {
          print(response.request);
        }
        if (jsonResponse['status'] == '1') {
          // Successful API response
          List<dynamic> leaveHistoryData = jsonResponse['response'];
          List<Map<String, dynamic>> leaveHistoryList = [];
          for (var leaveData in leaveHistoryData) {
            leaveHistoryList.add(Map<String, dynamic>.from(leaveData));
          }
          return leaveHistoryList;
        } else {
          // Error in API response
          if (kDebugMode) {
            print('Error in API response: ${jsonResponse['message']}');
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting leave history: $e');
      }
      return [];
    }
  }

  ///  Cancel Leave
  static Future<void> cancelLeave(String leaveId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var headers = {'Cookie': 'ci_session=5a5e359s108tlmsgdfsnevd9s51pns27'};
    var body = {
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'leav_id': leaveId,
    };

    var response = await http.post(
      Uri.parse(APIConstants.getFullUrl(APIConstants.cancelLeave)),
      headers: headers,
      body: body,
    );
    if (kDebugMode) {
      print(body);
    }
    if (kDebugMode) {
      print(response);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  /// Get Gate Pass Reasons
  static Future<List<GatePassReason>> fetchGatePassReasons() async {
    try {
      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.getGatePassReasons)),
        headers: APIConstants.headers,
        body: {'APIKEY': 'GNCS0225'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == "1") {
          List<dynamic> GatePassReasonData = data['response'];
          List<GatePassReason> gatePassReasons = GatePassReasonData.map(
              (gatePassReasonJson) =>
                  GatePassReason.fromJson(gatePassReasonJson)).toList();
          return gatePassReasons;
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception(
            'Failed to load Gate Pass Reasons: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Exception while fetching Gate Pass Reasons: $e');
    }
  }

  /// Apply Gate Pass
  static Future<String> applyGatePass({
    required String applyFrom,
    required String applyTo,
    required String reason,
    required String goWith,
    required String applyRemark,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var headers = {
        'Cookie': 'ci_session=9918717oip21ucg7572uevf8cn0e3f5u',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://myglobalapp.in/global/API005/apply_gatepass'),
        // final response = await http.post(
        // Uri.parse(APIConstants.getFullUrl(APIConstants.getGatePassReasons)),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
        'applyFrom': applyFrom,
        'applyTo': applyTo,
        'reason': reason,
        'goWith': goWith,
        'applyRemark': applyRemark,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        String message = jsonResponse['message'] ?? 'Unknown response';

        return message;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return 'Error occurred: ${response.reasonPhrase}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error applying Gate Pass: $e');
      }
      return 'Error occurred: $e';
    }
  }

  /// Get Gate Pass History
  static Future<List<Map<String, dynamic>>> getGatePassHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var headers = {
        'Cookie': 'ci_session=9918717oip21ucg7572uevf8cn0e3f5u',
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(APIConstants.getFullUrl(APIConstants.gatePassHistory)),
        // Uri.parse('http://myglobalapp.in/global/API005/gatepass_history'),
      );

      request.fields.addAll({
        'APIKEY': 'GNCS0225',
        'USER_ID': userId,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        //print(responseBody);
        //print(response.request);
        if (jsonResponse['status'] == '1') {
          // Successful API response
          List<dynamic> GatePassHistoryData = jsonResponse['response'];
          List<Map<String, dynamic>> GatePassHistoryList = [];
          for (var gatePassData in GatePassHistoryData) {
            GatePassHistoryList.add(Map<String, dynamic>.from(gatePassData));
          }
          return GatePassHistoryList;
        } else {
          // Error in API response
          if (kDebugMode) {
            print('Error in API response: ${jsonResponse['message']}');
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Gate Pass history: $e');
      }
      return [];
    }
  }

  ///  Cancel Leave
  static Future<void> cancelGatePass(String gatePassId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';
    var headers = {'Cookie': 'ci_session=5a5e359s108tlmsgdfsnevd9s51pns27'};
    var body = {
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'gpas_id': gatePassId,
    };

    var response = await http.post(
      Uri.parse(APIConstants.getFullUrl(APIConstants.cancelGatePass)),
      // Uri.parse('http://myglobalapp.in/global/API005/cancelgatepass'),
      headers: headers,
      body: body,
    );
    if (kDebugMode) {
      print(body);
    }
    if (kDebugMode) {
      print(response);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  /// Result
  static Future<String> getAllResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    var headers = {
      'Cookie': 'ci_session=h2t5hogqm5qno7mjgfbspmok2j1t0mjb',
    };

    // var request = http.MultipartRequest('POST', Uri.parse('$baseUrl2/get_all_result'));
    var request = http.MultipartRequest(
        'POST', Uri.parse(APIConstants.getFullUrl(APIConstants.getResult)));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
       'USER_ID': userId,
      'USER_ID': '1044',
    });
    // if (kDebugMode) {
    //   print('Current User ID => USER_ID ' ' 1044');
    // }
    if (kDebugMode) {
      print(userId);
    }

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print(response);
      }
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// Get VT Letter Subject
  static Future<List<VtLetterSubject>> fetchVtLetterSubject() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';
      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.getVtLetterSubject)),
        headers: APIConstants.headers,
        body: {
          'APIKEY': 'GNCS0225',
          // 'APIKEY': 'GNCS0225',
          //'USER_ID': userId,
         'USER_ID': '567'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == "1") {
          List<dynamic> VtLetterSubjectData = data['response'];
          List<VtLetterSubject> vtLetterSubject = VtLetterSubjectData.map(
              (vtLetterSubjectJson) =>
                  VtLetterSubject.fromJson(vtLetterSubjectJson)).toList();
          return vtLetterSubject;
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception(
            'Failed to load Vt Letter Subject: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Exception while fetching Vt Letter Subject: $e');
    }
  }

  ///Get VT Letter Location
  static Future<Map<String, dynamic>>fetchVtLetterLocation(
      String vtp_subjid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //var userId = prefs.getString('user_id') ?? '';
      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.getVtLetterLocation)),
        headers: APIConstants.headers,
        body: {
          'APIKEY': 'GNCS0225',
          'vtp_subjid': vtp_subjid
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
          return data;
        } else {
          //throw Exception(data['message']);
          throw Exception('Failed to load  Vt Letter Location: ${response.statusCode}');
        }

    } catch (e) {
      throw Exception('Exception while fetching Vt Letter Location: $e');
    }
  }

  ///Get VT Letter History
  static Future<List<Map<String, dynamic>>>fetchVtLetterHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';
      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.getVtLetterHistory)),
        headers: APIConstants.headers,
        body: {
          'APIKEY': 'GNCS0225',
          'USER_ID': userId
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        //print(responseBody);
        //print(response.request);
        if (jsonResponse['status'] == '1') {
          // Successful API response
          List<dynamic> HistoryData = jsonResponse['response'];
          List<Map<String, dynamic>> HistoryList = [];
          for (var i in HistoryData) {
            HistoryList.add(Map<String, dynamic>.from(i));
          }
          return HistoryList;
        } else {
          // Error in API response
          if (kDebugMode) {
            print('Error in API response: ${jsonResponse['message']}');
          }
          return [];
        }
      } else {
        //throw Exception(data['message']);
        throw Exception('Failed to load  Vt Letter Location: ${response.statusCode}');
      }

    } catch (e) {
      throw Exception('Exception while fetching Vt Letter Location: $e');
    }
  }

  /// Apply VT Letter
  static Future<String> applyVtLetter({
    required String applyFrom,
    required String applyTo,
    required String totalDay,
    required String locationIds,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id') ?? '';

      var headers = {
        'Cookie': 'ci_session=9918717oip21ucg7572uevf8cn0e3f5u',
      };

      final response = await http.post(
        Uri.parse(APIConstants.getFullUrl(APIConstants.applyVtLetter)),
        headers: APIConstants.headers,
        body: {
          'APIKEY': 'GNCS0225',
          'USER_ID': userId,
          'vt_fromdate': applyFrom,
          'vt_todate': applyTo,
          'vt_totalday': totalDay,
          'vt_locationids': locationIds,
        },
      );
      //bytesToString();
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'] ?? 'Unknown response';

        return message;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return 'Error occurred: ${response.reasonPhrase}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error applying Vt Letter: $e');
      }
      return 'Error occurred: $e';
    }
  }


  /// Activity
  static Future<List<EventData>> fetchEventData() async {
    final response = await http.post(
      Uri.parse(APIConstants.getFullUrl(APIConstants.getActivity)),
      // Uri.parse(APIConstants.getActivity),
      // Uri.parse(baseUrl + 'get_activity'),
      headers: {'Cookie': 'ci_session=obq2f8dlcp0kiq4h1hpnspprtgbrahih'},
      body: {'APIKEY': 'GNCS0225'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['response'];

      return data.map((item) => EventData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// Result
  static Future<String> getAllSubjectList(String stud_sem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    var headers = {
      'Cookie': 'ci_session=h2t5hogqm5qno7mjgfbspmok2j1t0mjb',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(APIConstants.getFullUrl(APIConstants.getsubjectlist)));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
      'stud_sem': stud_sem,
    });
    // if (kDebugMode) {
    //   print('Current User ID => USER_ID ' ' 1044');
    // }
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print(response);
      }
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  ///Get VT Letter History
  static Future<List<String>> fetchTopicList(String sub_id, String unit)async {
    final response = await http.post(
      Uri.parse(APIConstants.getFullUrl(APIConstants.getsyllabus)),
      headers: APIConstants.headers,
      body: {
        'APIKEY': 'GNCS0225',
        //'sub_id': sub_id,
        'sub_id': '49',
        'unit' : unit,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<String> topics = List<String>.from(jsonData['response']);
      return topics;
    } else {
      throw Exception('Failed to load topics');
    }
  }
}
