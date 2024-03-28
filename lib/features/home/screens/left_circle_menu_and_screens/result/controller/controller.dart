// import '../../../../../../data/api/api_services.dart';
// import '../model/model.dart';
// import 'package:get/get.dart';
//
// class ResultController extends GetxController {
//   var isLoading = true.obs;
//   var apiResponse = ApiResponse(semesters: [], overallStatus: [], response: null, message: '', status: '').obs;
//
//   @override
//   void onInit() {
//     fetchData();
//     super.onInit();
//   }
//
//   Future<void> fetchData() async {
//     try {
//       isLoading(true);
//       var response = await ApiService.getAllResults();
//       apiResponse(ApiResponse.fromJson(response));
//     } catch (error) {
//       print('Error fetching data: $error');
//     } finally {
//       isLoading(false);
//     }
//   }
// }
//
// class ResultDetailController extends GetxController {
//   // Controller for ResultDetailScreen if needed
// }
//
// final resultController = ResultController();
// final resultDetailController = ResultDetailController();
import 'dart:convert';
import '../../../../../../data/api/api_services.dart';
import 'package:get/get.dart';
class ResultController extends GetxController {
  Rx<Map<String, dynamic>?> apiResponse = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      String result = await ApiService.getAllResults();
      Map<String, dynamic> jsonResponse = json.decode(result);
      apiResponse.value = jsonResponse['response'];
    } catch (error) {
      print("Error fetching results: $error");
      // Handle error gracefully
    }
  }
}


/*
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model.dart'; // For json decoding

class StudentController extends GetxController {
  var studentModel = StudentModel(
    semesters: [],
    overallStatus: [],
    // message: '',
    // status: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentData();
  }

  void fetchStudentData() async {
    var headers = {
      'Cookie': 'ci_session=mouu69ekloinnhq9jlocqet74205i237'
    };

    // Get USER_ID from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id') ?? '';

    var request = http.MultipartRequest('POST', Uri.parse('http://myglobalapp.in/global/Web0001/get_all_result'));
    request.fields.addAll({
      'APIKEY': 'GNCS0225',
      'USER_ID': userId,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();

        // Decode JSON string to Map
        Map<String, dynamic> decodedJson = json.decode(responseData);
        print(userId);
        print(response);
        print(request);
        print(response.request);
        print('API Response: $responseData');

        // Parsing semesters
        List<dynamic> semestersJson = decodedJson['response']['semesters'];
        List<Semester> semesters =
        semestersJson.map((json) => Semester.fromJson(json)).toList();
        // print(overallStatus);
        print(semesters);
        // Parsing overallStatus
        List<dynamic> overallStatusJson = decodedJson['response']['overallStatus'];
        OverallStatus overallStatus =
        OverallStatus.fromJson(overallStatusJson[0]); // Get the first element
        print(overallStatus);
        print(semesters);
        // Updating studentModel
        studentModel.value = StudentModel(
          semesters: semesters,
          overallStatus: [overallStatus],
          // message: decodedJson['message'],
          // status: decodedJson['status'],
        );
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API request: $error');
    }
  }
}


 */


/// Correct code without API integration
/*
import 'package:get/get.dart';
import 'dart:convert';

import '../model/model.dart'; // For json decoding

class StudentController extends GetxController {
  var studentModel = StudentModel(
    semesters: [],
    overallStatus: [],
    // message: '',
    // status: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentData();
  }

  void fetchStudentData() {
    // Your JSON data
    const String jsonData = '''
  {
    "response": {
      "semesters": [
        {
          "semester_number": 1,
          "final_exam": {
            "result": "Pass",
            "theoretical_result": {
              "result": "Pass",
               "current_semester_sgpa": "1.1",
              "subjects": [
                {"name": "Mathematics", "grade": "A", "status": "Pass"},
                {"name": "Physics", "grade": "B+", "status": "Pass"},
                {"name": "Chemistry", "grade": "A-", "status": "Pass"}
              ]
            },
            "practical_result": {
              "result": "Pass",
              "current_semester_sgpa": "1.2",
              "subjects": [
                {"name": "Mathematics Practical", "status": "Pass"},
                {"name": "Physics Practical", "status": "Pass"},
                {"name": "Chemistry Practical", "status": "Pass"}
              ]
            }
          },
          "mid_term_exam": {
            "result": "Pass",
            "theoretical_result": {
              "result": "Pass",
               "current_semester_sgpa": "2.2",
              "subjects": [
                {"name": "Mathematics", "grade": "A", "status": "Pass"},
                {"name": "Physics", "grade": "B+", "status": "Pass"},
                {"name": "Chemistry", "grade": "A-", "status": "Pass"}
              ]
            },
            "practical_result": {
              "result": "Pass",
               "current_semester_sgpa": "2.3",
              "subjects": [
                {"name": "Mathematics Practical", "status": "Pass"},
                {"name": "Physics Practical", "status": "Pass"},
                {"name": "Chemistry Practical", "status": "Pass"}
              ]
            }
          }
        },
        {
          "semester_number": 2,
          "final_exam": {
            "result": "Pass",
            "theoretical_result": {
              "result": "Pass",
              "current_semester_sgpa": "4.7",
              "subjects": [
                {"name": "Biology", "grade": "A", "status": "Pass"},
                {"name": "Computer Science", "grade": "B", "status": "Pass"},
                {"name": "English", "grade": "A", "status": "Pass"}
              ]
            },
            "practical_result": {
              "result": "Pass",
              "current_semester_sgpa": "4.7",
              "subjects": [
                {"name": "Biology Practical", "status": "Pass"},
                {"name": "Computer Science Practical", "status": "Pass"},
                {"name": "English Practical", "status": "Pass"}
              ]
            }
          },
          "mid_term_exam": {
            "result": "Pass",
            "theoretical_result": {
              "result": "Pass",
               "current_semester_sgpa": "3.7",
              "subjects": [
                {"name": "Biology", "grade": "A", "status": "Pass"},
                {"name": "Computer Science", "grade": "B", "status": "Pass"},
                {"name": "English", "grade": "A", "status": "Pass"}
              ]
            },
            "practical_result": {
              "result": "Pass",
              "current_semester_sgpa": "7.6",
              "subjects": [
                {"name": "Biology Practical", "status": "Pass"},
                {"name": "Computer Science Practical", "status": "Pass"},
                {"name": "English Practical", "status": "Pass"}
              ]
            }
          }
        }
      ],
      "overallStatus": [
        {
          "current_semester": 2,
          "current_semester_sgpa": "3.7",
          "current_semester_status": "Pass",
          "mid_term_status": "Pass",
          "final_status": "Pass"
        }
      ]
    }
  }
  ''';

    // Decoding JSON string to Map
    Map<String, dynamic> decodedJson = json.decode(jsonData);

    // Parsing semesters
    List<dynamic> semestersJson = decodedJson['response']['semesters'];
    List<Semester> semesters =
        semestersJson.map((json) => Semester.fromJson(json)).toList();


    // Parsing overallStatus
    List<dynamic> overallStatusJson = decodedJson['response']['overallStatus'];
    OverallStatus overallStatus =
        OverallStatus.fromJson(overallStatusJson[0]); // Get the first element

    // Updating studentModel
    studentModel.value = StudentModel(
      semesters: semesters,
      overallStatus: [overallStatus],
      // message: decodedJson['message'],
      // status: decodedJson['status'],
    );
  }
}


 */

/// Random code
/*

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/model.dart';

// class ResultController extends GetxController {
//   RxList<AcademicResult> results = <AcademicResult>[
//     AcademicResult(
//       semester: 'Semester 1',
//       universitySubjects: [
//         Subject(name: 'Mathematics', marks: 90.0),
//         Subject(name: 'Physics', marks: 80.0),
//         // Add more subjects as needed
//       ],
//       midtermSubjects: [
//         Subject(name: 'Computer Science', marks: 85.0),
//         Subject(name: 'Chemistry', marks: 75.5),
//         // Add more subjects as needed
//       ],
//       practicalSubjects: [
//         Subject(name: 'Lab Work', marks: 95.0),
//         Subject(name: 'Project', marks: 90.0),
//         // Add more subjects as needed
//       ],
//     ),
//     AcademicResult(
//       semester: 'Semester 2',
//       universitySubjects: [
//         Subject(name: 'Biology', marks: 85.0),
//         Subject(name: 'History', marks: 90.5),
//         Subject(name: 'Biology', marks: 85.0),
//         Subject(name: 'History', marks: 90.5),
//
//         // Add more subjects as needed
//       ],
//       midtermSubjects: [
//         Subject(name: 'English Literature', marks: 87.0),
//         Subject(name: 'Geography', marks: 82.5),
//         Subject(name: 'English Literature', marks: 87.0),
//         Subject(name: 'Geography', marks: 82.5),
//
//         // Add more subjects as needed
//       ],
//       practicalSubjects: [
//         Subject(name: 'Practical Exam 1', marks: 92.0),
//         Subject(name: 'Practical Exam 2', marks: 90.5),
//         Subject(name: 'Practical Exam 3', marks: 92.0),
//         Subject(name: 'Practical Exam 4', marks: 90.5),
//
//         // Add more subjects as needed
//       ],
//     ),
//     AcademicResult(
//       semester: 'Semester 3',
//       universitySubjects: [
//         Subject(name: 'Mathematics', marks: 90.0),
//         Subject(name: 'Physics', marks: 80.0),
//         // Add more subjects as needed
//       ],
//       midtermSubjects: [
//         Subject(name: 'Computer Science', marks: 85.0),
//         Subject(name: 'Chemistry', marks: 75.5),
//         // Add more subjects as needed
//       ],
//       practicalSubjects: [
//         Subject(name: 'Lab Work', marks: 95.0),
//         Subject(name: 'Project', marks: 90.0),
//         // Add more subjects as needed
//       ],
//     ),
//     AcademicResult(
//       semester: 'Semester 4',
//       universitySubjects: [
//         Subject(name: 'Biology', marks: 44.0),
//         Subject(name: 'History', marks: 44.5),
//         Subject(name: 'Biology', marks: 44.0),
//         Subject(name: 'History', marks: 44.5),
//
//         // Add more subjects as needed
//       ],
//       midtermSubjects: [
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//         Subject(name: 'English Literature', marks: 47.0),
//         Subject(name: 'Geography', marks: 42.5),
//
//         // Add more subjects as needed
//       ],
//       practicalSubjects: [
//         Subject(name: 'Practical Exam 11', marks: 40.0),
//         Subject(name: 'Practical Exam 22', marks: 40.5),
//         Subject(name: 'Practical Exam 33', marks: 40.0),
//         Subject(name: 'Practical Exam 44', marks: 40.5),
//
//         // Add more subjects as needed
//       ],
//     ),
//     // Add more semesters as needed
//   ].obs;
// }


class Semester {
  final int semesterNumber;
  final Exam finalExam;
  final Exam midTermExam;

  Semester({
    required this.semesterNumber,
    required this.finalExam,
    required this.midTermExam,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterNumber: json['semester_number'],
      finalExam: Exam.fromJson(json['final_exam']),
      midTermExam: Exam.fromJson(json['mid_term_exam']),
    );
  }
}

class Exam {
  final String result;
  final ExamResult theoreticalResult;
  final ExamResult practicalResult;

  Exam({
    required this.result,
    required this.theoreticalResult,
    required this.practicalResult,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      result: json['result'],
      theoreticalResult: ExamResult.fromJson(json['theoretical_result']),
      practicalResult: ExamResult.fromJson(json['practical_result']),
    );
  }
}

class ExamResult {
  final String result;
  final List<Subject> subjects;

  ExamResult({
    required this.result,
    required this.subjects,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      result: json['result'],
      subjects: List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
    );
  }
}

class Subject {
  final String name;
  final String? grade; // Optional for theoretical results
  final String status;

  Subject({
    required this.name,
    this.grade,
    required this.status,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
      grade: json['grade'],
      status: json['status'],
    );
  }
}

void main() {
  // Sample JSON data
  const jsonData = '''
  {
    "semesters": [
      {
        "semester_number": 1,
        "final_exam": {
          "result": "Pass",
          "theoretical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Mathematics",
                "grade": "A",
                "status": "Pass"
              },
              {
                "name": "Physics",
                "grade": "B+",
                "status": "Pass"
              },
              {
                "name": "Chemistry",
                "grade": "A-",
                "status": "Pass"
              }
            ]
          },
          "practical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Mathematics Practical",
                "status": "Pass"
              },
              {
                "name": "Physics Practical",
                "status": "Pass"
              },
              {
                "name": "Chemistry Practical",
                "status": "Pass"
              }
            ]
          }
        },
        "mid_term_exam": {
          "result": "Pass",
          "theoretical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Mathematics",
                "grade": "A",
                "status": "Pass"
              },
              {
                "name": "Physics",
                "grade": "B+",
                "status": "Pass"
              },
              {
                "name": "Chemistry",
                "grade": "A-",
                "status": "Pass"
              }
            ]
          },
          "practical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Mathematics Practical",
                "status": "Pass"
              },
              {
                "name": "Physics Practical",
                "status": "Pass"
              },
              {
                "name": "Chemistry Practical",
                "status": "Pass"
              }
            ]
          }
        }
      },
      {
        "semester_number": 2,
        "final_exam": {
          "result": "Pass",
          "theoretical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Biology",
                "grade": "A",
                "status": "Pass"
              },
              {
                "name": "Computer Science",
                "grade": "B",
                "status": "Pass"
              },
              {
                "name": "English",
                "grade": "A",
                "status": "Pass"
              }
            ]
          },
          "practical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Biology Practical",
                "status": "Pass"
              },
              {
                "name": "Computer Science Practical",
                "status": "Pass"
              },
              {
                "name": "English Practical",
                "status": "Pass"
              }
            ]
          }
        },
        "mid_term_exam": {
          "result": "Pass",
          "theoretical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Biology",
                "grade": "A",
                "status": "Pass"
              },
              {
                "name": "Computer Science",
                "grade": "B",
                "status": "Pass"
              },
              {
                "name": "English",
                "grade": "A",
                "status": "Pass"
              }
            ]
          },
          "practical_result": {
            "result": "Pass",
            "subjects": [
              {
                "name": "Biology Practical",
                "status": "Pass"
              },
              {
                "name": "Computer Science Practical",
                "status": "Pass"
              },
              {
                "name": "English Practical",
                "status": "Pass"
              }
            ]
          }
        }
      }
    ]
  }
  ''';

  // Parse JSON data
  final Map<String, dynamic> parsedJson = json.decode(jsonData);
  final List<dynamic> semestersData = parsedJson['semesters'];
  final List<Semester> semesters = semestersData.map((data) => Semester.fromJson(data)).toList();

  // Accessing data
  semesters.forEach((semester) {
    print('Semester ${semester.semesterNumber}:');
    print('Final Exam Result: ${semester.finalExam.result}');
    print('Mid-term Exam Result: ${semester.midTermExam.result}');
    print('-----------------------');
  });
}


 */
