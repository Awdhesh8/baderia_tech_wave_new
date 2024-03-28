
class ApiResponseModel {
  final List<Map<String, dynamic>> semesters;
  final List<Map<String, dynamic>> overallStatus;

  ApiResponseModel({
    required this.semesters,
    required this.overallStatus,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      semesters: List<Map<String, dynamic>>.from(json['semesters'] ?? []),
      overallStatus: List<Map<String, dynamic>>.from(json['overallStatus'] ?? []),
    );
  }
}




/*
class ResultModel {
  late List<SemesterData> response;
  late List<OverallStatus> overallStatus;
  late String message;
  late String status;

  ResultModel({required this.response, required this.overallStatus, required this.message, required this.status});

  ResultModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <SemesterData>[];
      json['response'].forEach((v) {
        response.add(SemesterData.fromJson(v));
      });
    }
    if (json['overallStatus'] != null) {
      overallStatus = <OverallStatus>[];
      json['overallStatus'].forEach((v) {
        overallStatus.add(OverallStatus.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response.map((v) => v.toJson()).toList();
    data['overallStatus'] = overallStatus.map((v) => v.toJson()).toList();
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class SemesterData {
  late Semesters semesters;

  SemesterData({required this.semesters});

  SemesterData.fromJson(Map<String, dynamic> json) {
    semesters = Semesters.fromJson(json['semesters']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semesters'] = semesters.toJson();
    return data;
  }
}

class Semesters {
  late String semesterNumber;
  late FinalExam finalExam;
  late MidTermExam midTermExam;

  Semesters({required this.semesterNumber, required this.finalExam, required this.midTermExam});

  Semesters.fromJson(Map<String, dynamic> json) {
    semesterNumber = json['semester_number'];
    finalExam = FinalExam.fromJson(json['final_exam']);
    midTermExam = MidTermExam.fromJson(json['mid_term_exam']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester_number'] = semesterNumber;
    data['final_exam'] = finalExam.toJson();
    data['mid_term_exam'] = midTermExam.toJson();
    return data;
  }
}

class FinalExam {
  late String result;
  late TheoreticalResult theoreticalResult;
  late PracticalResult practicalResult;

  FinalExam({required this.result, required this.theoreticalResult, required this.practicalResult});

  FinalExam.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    theoreticalResult = TheoreticalResult.fromJson(json['theoretical_result']);
    practicalResult = PracticalResult.fromJson(json['practical_result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['theoretical_result'] = theoreticalResult.toJson();
    data['practical_result'] = practicalResult.toJson();
    return data;
  }
}

class TheoreticalResult {
  late String result;
  late String currentSemesterSgpa; // Update this line
  late List<Subjects> subjects;

  TheoreticalResult({required this.result, required this.currentSemesterSgpa, required this.subjects});

  TheoreticalResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    currentSemesterSgpa = json['current_semester_sgpa']; // Update this line
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['current_semester_sgpa'] = currentSemesterSgpa; // Update this line
    data['subjects'] = subjects.map((v) => v.toJson()).toList();
    return data;
  }
}

class PracticalResult {
  late String result;
  late String currentSemesterSgpa; // Update this line
  late List<Subjects> subjects;

  PracticalResult({required this.result, required this.currentSemesterSgpa, required this.subjects});

  PracticalResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    currentSemesterSgpa = json['current_semester_sgpa']; // Update this line
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['current_semester_sgpa'] = currentSemesterSgpa; // Update this line
    data['subjects'] = subjects.map((v) => v.toJson()).toList();
    return data;
  }
}

class Subjects {
  late String name;
  late String grade;
  late String status;

  Subjects({required this.name, required this.grade, required this.status});

  Subjects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    grade = json['grade'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['grade'] = grade;
    data['status'] = status;
    return data;
  }
}

class MidTermExam {
  late String result;
  late TheoreticalResult theoreticalResult;
  late PracticalResult practicalResult;

  MidTermExam({required this.result, required this.theoreticalResult, required this.practicalResult});

  MidTermExam.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    theoreticalResult = TheoreticalResult.fromJson(json['theoretical_result']);
    practicalResult = PracticalResult.fromJson(json['practical_result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['theoretical_result'] = theoreticalResult.toJson();
    data['practical_result'] = practicalResult.toJson();
    return data;
  }
}

class OverallStatus {
  late String currentSemester;
  late String currentSemesterSgpa; // Update this line
  late String currentSemesterStatus;
  late String midTermStatus;
  late String finalStatus;

  OverallStatus({
    required this.currentSemester,
    required this.currentSemesterSgpa,
    required this.currentSemesterStatus,
    required this.midTermStatus,
    required this.finalStatus,
  });

  OverallStatus.fromJson(Map<String, dynamic> json) {
    currentSemester = json['current_semester'];
    currentSemesterSgpa = json['current_semester_sgpa']; // Update this line
    currentSemesterStatus = json['current_semester_status'];
    midTermStatus = json['mid_term_status'];
    finalStatus = json['final_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_semester'] = currentSemester;
    data['current_semester_sgpa'] = currentSemesterSgpa; // Update this line
    data['current_semester_status'] = currentSemesterStatus;
    data['mid_term_status'] = midTermStatus;
    data['final_status'] = finalStatus;
    return data;
  }
}


 */

/*
class ResultModel {
  List<Response>? response;
  OverallStatus? overallStatus;
  String? message;
  String? status;

  ResultModel({this.response, this.overallStatus, this.message, this.status});

  ResultModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
    overallStatus = json['overallStatus'] != null
        ? new OverallStatus.fromJson(json['overallStatus'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    if (this.overallStatus != null) {
      data['overallStatus'] = this.overallStatus!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Response {
  Semesters? semesters;

  Response({this.semesters});

  Response.fromJson(Map<String, dynamic> json) {
    semesters = json['semesters'] != null
        ? new Semesters.fromJson(json['semesters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.semesters != null) {
      data['semesters'] = this.semesters!.toJson();
    }
    return data;
  }
}

class Semesters {
  String? semesterNumber;
  FinalExam? finalExam;
  MidTermExam? midTermExam;

  Semesters({this.semesterNumber, this.finalExam, this.midTermExam});

  Semesters.fromJson(Map<String, dynamic> json) {
    semesterNumber = json['semester_number'];
    finalExam = json['final_exam'] != null
        ? FinalExam.fromJson(json['final_exam'])
        : null;
    midTermExam = json['mid_term_exam'] != null
        ? MidTermExam.fromJson(json['mid_term_exam'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester_number'] = semesterNumber;
    if (finalExam != null) {
      data['final_exam'] = finalExam!.toJson();
    }
    if (midTermExam != null) {
      data['mid_term_exam'] = midTermExam!.toJson();
    }
    return data;
  }
}

class FinalExam {
  String? result;
  String? sGPA;
  TheoreticalResult? theoreticalResult;
  Null practicalResult;

  FinalExam(
      {this.result, this.sGPA, this.theoreticalResult, this.practicalResult});

  FinalExam.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    sGPA = json['SGPA'];
    theoreticalResult = json['theoretical_result'] != null
        ? new TheoreticalResult.fromJson(json['theoretical_result'])
        : null;
    practicalResult = json['practical_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['SGPA'] = this.sGPA;
    if (this.theoreticalResult != null) {
      data['theoretical_result'] = this.theoreticalResult!.toJson();
    }
    data['practical_result'] = this.practicalResult;
    return data;
  }
}

class TheoreticalResult {
  String? result;
  List<Subjects>? subjects;

  TheoreticalResult({this.result, this.subjects});

  TheoreticalResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? name;
  String? grade;
  String? status;

  Subjects({this.name, this.grade, this.status});

  Subjects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    grade = json['grade'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['grade'] = this.grade;
    data['status'] = this.status;
    return data;
  }
}

class MidTermExam {
  Null? midTermExam;
  Null? practicalResult;

  MidTermExam({this.midTermExam, this.practicalResult});

  MidTermExam.fromJson(Map<String, dynamic> json) {
    midTermExam = json['mid_term_exam'];
    practicalResult = json['practical_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid_term_exam'] = this.midTermExam;
    data['practical_result'] = this.practicalResult;
    return data;
  }
}

class OverallStatus {
  String? currentSemester;
  String? currentSemesterCgpa;
  String? currentSemesterStatus;
  String? midTermStatus;
  String? finalStatus;

  OverallStatus(
      {this.currentSemester,
        this.currentSemesterCgpa,
        this.currentSemesterStatus,
        this.midTermStatus,
        this.finalStatus});

  OverallStatus.fromJson(Map<String, dynamic> json) {
    currentSemester = json['current_semester'];
    currentSemesterCgpa = json['current_semester_cgpa'];
    currentSemesterStatus = json['current_semester_status'];
    midTermStatus = json['mid_term_status'];
    finalStatus = json['final_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_semester'] = this.currentSemester;
    data['current_semester_cgpa'] = this.currentSemesterCgpa;
    data['current_semester_status'] = this.currentSemesterStatus;
    data['mid_term_status'] = this.midTermStatus;
    data['final_status'] = this.finalStatus;
    return data;
  }
}
*/

/*
class StudentModel {
  final List<Semester> semesters;
  final List<OverallStatus> overallStatus;

  StudentModel({
    required this.semesters,
    required this.overallStatus,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      semesters: List<Semester>.from(json['response']['semesters'].map((x) => Semester.fromJson(x))),
      overallStatus: List<OverallStatus>.from(json['response']['overallStatus'].map((x) => OverallStatus.fromJson(x))),
    );
  }
}

// class Semester {
//   final int semesterNumber;
//   final Exam finalExam;
//   final Exam midTermExam;
//
//   Semester({
//     required this.semesterNumber,
//     required this.finalExam,
//     required this.midTermExam,
//   });
//
//   factory Semester.fromJson(Map<String, dynamic> json) {
//     return Semester(
//       semesterNumber: json['semester_number']?? '',
//       finalExam: Exam.fromJson(json['final_exam'] ?? ''),
//       midTermExam: Exam.fromJson(json['mid_term_exam']?? ''),
//     );
//   }
// }

class Exam {
  final String result;
  final ExamResult theoreticalResult;
  final ExamResult practicalResult;
  final String sgpa;

  Exam({
    required this.result,
    required this.theoreticalResult,
    required this.practicalResult,
    required this.sgpa,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      result: json['result']?? '',
      sgpa: json['current_semester_sgpa']?? '',
      theoreticalResult: ExamResult.fromJson(json['theoretical_result']?? ''),
      practicalResult: ExamResult.fromJson(json['practical_result']?? ''),
    );
  }
}

class ExamResult {
  final String result;
  final List<Subject> subjects;
  final String sgpa;

  ExamResult({
    required this.result,
    required this.subjects, required this.sgpa,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      result: json['result']?? '',
      sgpa: json['current_semester_sgpa']?? '',
      subjects: List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
    );
  }
}

class Subject {
  final String name;
  final String grade;
  final String status;

  Subject({
    required this.name,
    required this.grade,
    required this.status,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name']?? '',
      grade: json['grade']?? '',
      status: json['status']?? '',
    );
  }
}

class Semester {
  final String semesterNumber;
  final Exam finalExam;
  final Exam midTermExam;

  Semester({
    required this.semesterNumber,
    required this.finalExam,
    required this.midTermExam,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    var semestersData = json['semesters'];

    return Semester(
      semesterNumber: semestersData['semester_number'].toString(),
      finalExam: Exam.fromJson(semestersData['final_exam'] ?? {}),
      midTermExam: Exam.fromJson(semestersData['mid_term_exam'] ?? {}),
    );
  }
}

class OverallStatus {
  final String currentSemester;
  final double currentSemesterCgpa;
  final String currentSemesterStatus;
  final String midTermStatus;
  final String finalStatus;

  OverallStatus({
    required this.currentSemester,
    required this.currentSemesterCgpa,
    required this.currentSemesterStatus,
    required this.midTermStatus,
    required this.finalStatus,
  });

  factory OverallStatus.fromJson(Map<String, dynamic> json) {
    return OverallStatus(
      currentSemester: json['current_semester'].toString(),
      currentSemesterCgpa: (json['current_semester_cgpa'] is num)
          ? (json['current_semester_cgpa'] as num).toDouble()
          : double.tryParse(json['current_semester_cgpa'].toString()) ?? 0.0,
      currentSemesterStatus: json['current_semester_status'].toString(),
      midTermStatus: json['mid_term_status'].toString(),
      finalStatus: json['final_status'].toString(),
    );
  }
}


 */

/*
import '../result.dart';

class AcademicResult {
  final String semester;
  final List<Subject> universitySubjects;
  final List<Subject> midtermSubjects;
  final List<Subject> practicalSubjects;

  AcademicResult({
    required this.semester,
    List<Subject>? universitySubjects,
    List<Subject>? midtermSubjects,
    List<Subject>? practicalSubjects,
  })  : universitySubjects = universitySubjects ?? [],
        midtermSubjects = midtermSubjects ?? [],
        practicalSubjects = practicalSubjects ?? [];
}

class Subject {
  final String name;
  final double marks;

  Subject({required this.name, required this.marks});
}

 */