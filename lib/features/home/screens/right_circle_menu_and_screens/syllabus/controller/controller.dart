
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../data/api/api_services.dart';
import 'package:get/get.dart';
class SyllabusController extends GetxController {
  Rx<List<dynamic>?> subjectList = Rx<List<dynamic>?>(null);
  RxString course = ''.obs;
  RxString currentSem = ''.obs;

  Rx<List<DropdownMenuItem<String>>> semDropDown = Rx<List<DropdownMenuItem<String>>>([]);
  final subject = <SubjectList>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubject(currentSem.value);
  }

  Future<void> fetchSubject(String semesterid) async {
    try {
      String result = await ApiService.getAllSubjectList(semesterid);
      Map<String, dynamic> jsonResponse = json.decode(result);
      subjectList.value = jsonResponse['response'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      course.value = prefs.getString('course_name') ?? '';
      currentSem.value = prefs.getString('stud_sem') ?? '';
      int count;
      if(course.value=='Mba'){
        count = 4;
      }else{
        count = 6;
      }
      semDropDown.value.clear();
      for(int k = 1; k <= count; k++) {
        semDropDown.value.add(DropdownMenuItem(value: '${k}',child: Text("Semester ${k}"),));
      }

      List<dynamic> listData = jsonResponse['response'];
      List<SubjectList> listArray = listData.map((e) =>SubjectList.fromJson(e)).toList();
      subject.clear();
      for (var i in listArray) {
        //subject.add("${i.name}");
        subject.add(SubjectList(id: '${i.id}', name: '${i.name}'));
      }
      //apiResponse.value
    } catch (error) {
      print("Error fetching results: $error");
      // Handle error gracefully
    }
  }
}

class SubjectList{
  final String id;
  final String name;

  SubjectList({required this.id, required this.name});

  factory SubjectList.fromJson(Map<String, dynamic> json) {
    return SubjectList(
      id: json['sub_id'] ?? '',
      name: json['subj_name'] ?? '',
    );
  }
}
