// import 'package:flutter/material.dart';
// import '../../../../../../common/widgets/appbar/appbar.dart';
// import '../model/model.dart';
//
// class ExamResultScreen extends StatelessWidget {
//   final Exam exam;
//   final Semester semester;
//   final String examType;
//   final String sgpa;
//
//   ExamResultScreen(
//       {required this.exam, required this.semester, required this.examType, required this.sgpa});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GAppBar(
//         title: Text(examType),
//         showBackArrow: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Semester ${semester.semesterNumber} Results'),
//             Text('Result: ${exam.result}'),
//             Text('Theoretical Result: ${exam.theoreticalResult.result}'),
//             Text('SGPA: ${exam.theoreticalResult.sgpa}'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: exam.theoreticalResult.subjects.map((subject) {
//                 return Text('${subject.name}: ${subject.grade}');
//               }).toList(),
//             ),
//             Text('Practical Result: ${exam.practicalResult.result}'),
//             Text('SGPA: ${exam.practicalResult.sgpa}'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: exam.practicalResult.subjects.map((subject) {
//                 return Text('${subject.name}: ${subject.grade}');
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
