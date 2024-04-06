
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../data/api/api_services.dart';
import 'package:get/get.dart';
/*
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


 */

class SyllabusController extends GetxController {
  Rx<List<dynamic>?> subjectList = Rx<List<dynamic>?>(null);
  RxString course = ''.obs;
  RxString currentSem = ''.obs;

  Rx<List<DropdownMenuItem<String>>> semDropDown =
  Rx<List<DropdownMenuItem<String>>>([]);
  final subject = <SubjectList>[].obs;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentSem.value = prefs.getString('stud_sem') ?? '';
    if (currentSem.value.isNotEmpty) {
      fetchSubject(currentSem.value);
    } else {
      print("Current semester is not set.");
    }
  }


  // @override
  // void onInit() {
  //   super.onInit();
  //   // Ensure currentSem.value is initialized before calling fetchSubject
  //   if (currentSem.value.isNotEmpty) {
  //     fetchSubject(currentSem.value);
  //   } else {
  //     // Handle the case where currentSem.value is empty
  //     print("Current semester is not set.");
  //   }
  // }

  Future<void> fetchSubject(String semesterid) async {
    try {
      String result = await ApiService.getAllSubjectList(semesterid);
      Map<String, dynamic> jsonResponse = json.decode(result);
      subjectList.value = jsonResponse['response'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      course.value = prefs.getString('course_name') ?? '';
      currentSem.value = prefs.getString('stud_sem') ?? '';
      int count;
      if (course.value == 'Mba') {
        count = 4;
      } else {
        count = 6;
      }
      semDropDown.value.clear();
      for (int k = 1; k <= count; k++) {
        String semesterValue = '${k}';
        // Check if the semester value already exists in semDropDown list
        bool alreadyExists = semDropDown.value.any((item) => item.value == semesterValue);
        if (!alreadyExists) {
          semDropDown.value.add(DropdownMenuItem(value: semesterValue, child: Text("Semester $k")));
        }
      }

      List<dynamic> listData = jsonResponse['response'];
      List<SubjectList> listArray =
      listData.map((e) => SubjectList.fromJson(e)).toList();
      subject.clear();
      for (var i in listArray) {
        subject.add(SubjectList(id: '${i.id}', name: '${i.name}'));
      }
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
