
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../data/api/api_services.dart';
import '../widgets/vt_letter_form.dart';

class VTLetterFormController extends GetxController {
  RxString fromController = ''.obs;
  RxString toController = ''.obs;
  RxBool toError = false.obs;
  RxBool fromError = false.obs;

  RxString totalDayController = ''.obs;//
  RxBool totalDayError = false.obs;

  Rx<VtLetterSubject?> subjectController = Rx<VtLetterSubject?>(null);
  RxBool subjectError = false.obs;
  RxString vtSubjectId   = ''.obs;
  String vtLocationIds = '';
  RxBool vtLocationIdsError = false.obs;

  final items = <Item>[].obs;
  final selectedItems = <Item>[].obs;

  // RxList to store the history of leave applications
  RxList<String> vtLetterHistory = <String>[].obs;

/*
  Rx<List<DropdownMenuItem<String>>> listCompanyDropDown = Rx<List<DropdownMenuItem<String>>>([]);
  void getCompany_old()async{
    //listCompanyDropDown.value.clear();
    print(vtSubjectId);
    //listCompanyDropDown.value.add(DropdownMenuItem(child: Text("GCF"),value: '1998',));
    //listCompanyDropDown.value.add(DropdownMenuItem(child: Text("TCS"),value: '1948',));
    //items.add(Item(11, "Item 11"));
    //items.add(Item(22, "Item 22"));
    print(vtSubjectId);
  }
*/

  void toggleSelection(Item item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    //print('Selected Items: ${selectedItems.map((item) => item.name).join(", ")}');
    //print('Selected Items: ${selectedItems.map((item) => item.id).join(", ")}');
  }

  Future<void> getCompany() async {
      String vtp_subjid = vtSubjectId.value;
      //print('SubjectId $vtp_subjid');
      var snapshot = await Future.value(ApiService.fetchVtLetterLocation(vtp_subjid));
      var data = snapshot['response'];
      //print(data);

      List<dynamic> listData = data;
      List<LocationModal> listArray = listData.map((e) =>LocationModal.fromJson(e)).toList();
      items.clear();
      for (var i in listArray) {
        items.add(Item(i.id, "${i.name}"));
        //print('vtp_id: ${i.id}, locat: ${i.name}');
      }
  }
}
//
//
class Item {
  final String id;
  final String name;
  Item(this.id, this.name);
}

class LocationModal {
  final String id;
  final String name;

  LocationModal({required this.id, required this.name});

  factory LocationModal.fromJson(Map<String, dynamic> json) {
    return LocationModal(
      id: json['vtp_id'] ?? '',
      name: json['locat'] ?? '',
    );
  }
}

/*
    try {
      // Get.dialog(Center(
      //   child: CircularProgressIndicator(),
      // ));
      repository!.getalldistrict()?.then((value) {
        print('fff');
        print(value);
        if (value.data.isNotEmpty) {
          //Get.back();
           lstdistmodel.value.clear();
          lstdistmodel.value.addAll(value.data);
          listCompanyDropDown.value = [];
          listCompanyDropDown.value.add(
            DropdownMenuItem(
              child: Text(
                'Select Dist',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              value: "0",
            ),
          );
          for (DistDatum dist in lstdistmodel.value) {
            listCompanyDropDown.value.add(
              DropdownMenuItem(
                child: Text(
                  dist.districtTitle,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                value: dist.districtid,
              ),
            );
          }
        }

      }).onError((error, stackTrace) {
        Get.back();
        print('popo $error');
        //error handling code
      });
    } catch (exception) {
      //Get.back();
      print('ggggg $exception');
      // exception handling code
    }

    */