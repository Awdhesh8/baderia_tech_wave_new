
/// Get Educational Info --->>>
// static Future<Map<String, dynamic>> fetchEducationalDetails() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var userId = prefs.getString('user_id') ?? '';
//   var userType = prefs.getString('user_type') ?? '';
//
//   var headers = {
//     'Cookie': 'ci_session=s63p3q25pe1l70smdpptatqmg0j2vb8p'
//   };
//
//   var request = http.MultipartRequest('POST',
//       Uri.parse('http://myglobalapp.in/global/API005/profile_educational'));
//   request.fields.addAll({
//     'APIKEY': 'GNCS0225',
//     'USER_ID': userId,
//     'USER_TYPE': userType,
//   });
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     var responseBody = await response.stream.bytesToString();
//     var parsedResponse = json.decode(responseBody);
//
//     if (parsedResponse['status'] == "1") {
//       return {'success': true, 'data': parsedResponse['response']};
//     } else {
//       return {'success': false, 'error': parsedResponse['message']};
//     }
//   } else {
//     return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
//   }
// }
/*
  static Future<Map<String, dynamic>> fetchEducationalDetails() async {
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
        return {'success': true, 'data': parsedResponse['response']};
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

// Future<Map<String, dynamic>> fetchEducationalDetails() async { // Removed static keyword
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getString('user_id') ?? '';
//     var userType = prefs.getString('user_type') ?? '';
//
//     var headers = {
//       'Cookie': 'ci_session=s63p3q25pe1l70smdpptatqmg0j2vb8p'
//     };
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('http://myglobalapp.in/global/API005/profile_educational'),
//     );
//     request.fields.addAll({
//       'APIKEY': 'GNCS0225',
//       'USER_ID': userId,
//       'USER_TYPE': userType,
//     });
//
//     request.headers.addAll(headers);
//
//     print('Sending request to API...');
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var responseBody = await response.stream.bytesToString();
//       print('Response received from API: $responseBody');
//       var parsedResponse = json.decode(responseBody);
//
//       if (parsedResponse['status'] == "1") {
//         print('API call successful');
//         return {'success': true, 'data': parsedResponse};
//       } else {
//         print('API call failed. Error message: ${parsedResponse['message']}');
//         return {'success': false, 'error': parsedResponse['message']};
//       }
//     } else {
//       print('API request failed with status: ${response.statusCode}');
//       return {
//         'success': false,
//         'error': 'Request failed with status: ${response.statusCode}'
//       };
//     }
//   }

/// Edit Profile --->>>>

// static Future<void> updateProfile({
//   required String contactNumber,
//   required String email,
//   required String samagraId,
//   required String laptop,
//   required String bloodGroup,
//   required String laptopBrand,
//   required String laptopRam,
//   required String laptopProcessor,
//   required String laptopConfig,
//   required String imagePath,
// }) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userId = prefs.getString('user_id') ?? '';
//     String userType = prefs.getString('user_type') ?? '';
//
//     var headers = APIConstants.headers;
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(APIConstants.getFullUrl(APIConstants.updateProfile)),
//     );
//
//     request.fields.addAll({
//       'APIKEY': 'GNCS0225',
//       'USER_ID': userId, // Ensure this is not an empty string
//       'USER_TYPE': userType,
//       'contact_no': contactNumber,
//       'stud_email': email,
//       'samagra_id': samagraId,
//       'laptop': laptop,
//       'stud_bgroup': bloodGroup,
//       'lap_brand': laptopBrand,
//       'lap_ram': laptopRam,
//       'lap_processor': laptopProcessor,
//       'lap_config': laptopConfig,
//     });
//
//     var imageFile = await http.MultipartFile.fromPath('form_file', imagePath);
//     request.files.add(imageFile);
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   } catch (error) {
//     print('Error: $error');
//   }
// }

/// Get Blood Group --->>>
// static Future<List<String>> fetchBloodGroups() async {
//   try {
//     final response = await http.post(
//       Uri.parse(APIConstants.getFullUrl(APIConstants.getBloodGroup)), // Modify this line
//       headers: APIConstants.headers,
//       body: {'APIKEY': 'GNCS0225'},
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       if (data['status'] == "1") {
//         List<dynamic> bloodGroupData = data['response'];
//         List<String> bloodGroups = bloodGroupData
//             .map((bloodGroup) => bloodGroup['bloodg'].toString())
//             .toList();
//         return bloodGroups;
//       } else {
//         throw Exception(data['message']);
//       }
//     } else {
//       throw Exception('Failed to load blood groups: ${response.reasonPhrase}');
//     }
//   } catch (e) {
//     throw Exception('Exception while fetching blood groups: $e');
//   }
// }