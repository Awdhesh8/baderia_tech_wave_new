import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../controller/form_controller.dart';
import '../functions/form_functions.dart';

class VTLetterForm extends StatelessWidget {
  /// Instance
  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          /// VT Letter Subject

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: const BoxDecoration(),
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            child: FutureBuilder<List<VtLetterSubject>>(
              future: ApiService.fetchVtLetterSubject(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return _buildVtLetterSubjectDropdown(snapshot.data!);
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),

          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          // child:
          Obx(() {
            final List<Item> selectedItems = controller.selectedItems;
            return selectedItems.isEmpty
                ? const SizedBox.shrink()
                : AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: CustomDeco.decoRectangle2(),
                    constraints: const BoxConstraints(
                        minHeight: 50.0, minWidth: double.infinity),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 8.0,
                            children: selectedItems.map((item) {
                              return Chip(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                label: Text(
                                  item.name,
                                  style: TextStyleClass.labelText1,
                                ),
                                avatar: const Icon(
                                  FontAwesomeIcons.checkCircle,
                                  size: 15,
                                ),
                                onDeleted: () {
                                  controller.toggleSelection(item);
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    _showMultiSelect();
                                  },
                                  child: const Text('Select more ?',
                                      style: TextStyleClass.buttonStyle1)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          }),

          const SizedBox(height: ESizes.spaceBtwItems,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// From Date
              Obx(
                () => AnimatedContainer(
                  width: 165,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: const BoxDecoration(),
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: controller.fromController.value),
                    // text: 'Text here',
                    // controller: TextEditingController(text: controller.fromController.value.isEmpty ? 'From' : controller.fromController.value),
                    style: TextStyleClass.inputText1,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Iconsax.calendar_add),
                        onPressed: () {
                          FormUtils.selectDates(
                              context, controller.fromController);
                        },
                      ),
                      labelText: 'From',
                      labelStyle: TextStyleClass.labelText1,
                      errorText: controller.fromError.value
                          ? 'Select init Date'
                          : null,
                    ),
                  ),
                ),
              ),

              /// To Date
              Obx(() => InkWell(
                    onTap: () {
                      // _selectDates(context, false, controller.toController);
                    },
                    child: AnimatedContainer(
                      width: 165,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: const BoxDecoration(),
                      constraints: const BoxConstraints(
                        minHeight: 50.0,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                            text: controller.toController.value),
                        style: TextStyleClass.inputText1,
                        onChanged: (value) {
                          // controller.toController.value.isEmpty
                          //     ? 'To'
                          //     : controller.toController.value;
                          // controller.reasonError.value = false;
                          // Reset the error state when the user starts typing
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Iconsax.calendar_add),
                            onPressed: () {
                              FormUtils.selectDates(
                                  context, controller.toController);

                              // _selectDates(
                              //     context, false, controller.toController);
                            },
                          ),
                          labelText: 'To',
                          labelStyle: TextStyleClass.labelText1,
                          errorText: controller.toError.value
                              ? 'Please Select to date'
                              : null,
                        ),
                      ),
                    ),
                  )),
            ],
          ),

          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          /// Calculate the Days form the From date and To date & show in this text-field
          Obx(
            () => TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text: FormUtils.calculateDays(
                  controller.fromController.value,
                  controller.toController.value,
                ),
              ),
              onChanged: (value) {},
              style: TextStyleClass.inputText1,
              decoration: const InputDecoration(
                labelText: 'Duration (Days)',
                labelStyle: TextStyleClass.labelText1,
                // errorText: controller.totalDayError.value
                //     ? 'Please Select to date'
                //     : null,
              ),
            ),
          ),

          const SizedBox(height: ESizes.spaceBtwItems),

          /// Submit Button
          ElevatedButton(
            onPressed: () {
              if (controller.subjectController.value == null || controller.selectedItems.isEmpty) {
                // Show a snack bar if subject is not selected or chips are not added
                Get.snackbar(
                  'Error',
                  'Please select Subject & add at least one Company\'s.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              } else {
                // Subject and chips are selected, submit the form
                FormUtils.submitForm(context, controller);
              }
            },
            child: const Text('Submit Form'),
          ),

        ],
      ),
    );
  }

  Widget _buildVtLetterSubjectDropdown(List<VtLetterSubject> vtLetterSubject) {
    String? initialValue = controller.subjectController.value?.id;

    if (initialValue == null ||
        initialValue.isEmpty ||
        !vtLetterSubject.any((subject) => subject.id == initialValue)) {
      // If initialValue is null, empty, or not found in vtLetterSubject, set it to null
      initialValue = null;
    }

    return DropdownButtonFormField<String>(
      isDense: true,
      value: initialValue,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        errorText:
            controller.subjectError.value ? 'Select VT Letter Subject' : null,
      ),
      onChanged: (String? newValue) async {
        if (newValue != null) {
          controller.subjectController.value =
              vtLetterSubject.firstWhere((group) => group.id == newValue);
          String selectedSubject = controller.subjectController.value?.id ?? '';
          controller.vtSubjectId = selectedSubject.obs;
          await controller
              .getCompany(); // Wait for the data fetching process to complete
          _showMultiSelect(); // Show the bottom sheet after the data is loaded
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a VT Letter Subject';
        }
        return null;
      },
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child:
              Text('Select VT Letter Subject', style: TextStyle(fontSize: 12)),
        ),
        ...vtLetterSubject
            .map<DropdownMenuItem<String>>((VtLetterSubject group) {
          return DropdownMenuItem<String>(
            value: group.id,
            child: Text(group.name, style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ],
    );
  }

  void _showMultiSelect() async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: MultiSelectBottomSheet(
          checkColor: EColors.lightContainer,
          selectedColor: EColors.textColorPrimary1,
          cancelText: const Text('Cancel', style: TextStyle(fontFamily: 'Inter',color: Colors.redAccent),),
          title:
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Tap Into Careers',
                    style: TextStyleClass.feesSummaryText,
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    text: ' (Select more? then Drag Up)',
                    style: TextStyleClass.labelText1,
                  ),
                ),
              ],
            ),
          ),
          itemsTextStyle: TextStyleClass.bodyText,
          items: controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: controller.selectedItems,
          onConfirm: (values) {
            controller.selectedItems.assignAll(values);
            controller.vtLocationIds =
                controller.selectedItems.map((item) => item.id).join(",");
            if (kDebugMode) {
              print('From: ${controller.fromController}');
              print('To  : ${controller.toController}');
              print('day : ${controller.totalDayController}');
              print('IDs : ${controller.vtLocationIds}');
            }
          },
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 100),
      ignoreSafeArea: true,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }


}

class VtLetterSubject {
  final String id;
  final String name;

  VtLetterSubject({required this.id, required this.name});

  factory VtLetterSubject.fromJson(Map<String, dynamic> json) {
    return VtLetterSubject(
      id: json['vtsubj_id'] ?? '',
      name: json['vtsubj_name'] ?? '',
    );
  }
}




/*
  /// Old Bottom sheet code
  void _showMultiSelect() async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: MultiSelectBottomSheet(
          checkColor: EColors.lightContainer,
          cancelText: const Text('Cancel', style: TextStyle(fontFamily: 'Inter',color: Colors.redAccent),),
          title:
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: RichText(
              text: const TextSpan(
                text: 'Tap Into Careers',
                style: TextStyleClass.feesSummaryText,
              ),
            ),
          ),
          itemsTextStyle: TextStyleClass.bodyText,
          items: controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: controller.selectedItems,
          onConfirm: (values) {
            controller.selectedItems.assignAll(values);
            controller.vtLocationIds =
                controller.selectedItems.map((item) => item.id).join(",");
            if (kDebugMode) {
              print('From: ${controller.fromController}');
              print('To  : ${controller.toController}');
              print('day : ${controller.totalDayController}');
              print('IDs : ${controller.vtLocationIds}');
            }
          },
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 100),
      ignoreSafeArea: true,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }
*/

/*
  void _showMultiSelect() async {
    Get.bottomSheet(
      enterBottomSheetDuration: const Duration(milliseconds: 100),
      elevation: 20,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: MultiSelectBottomSheet(

          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(Iconsax.arrow_up_24),
              Container(
                width: 150,
                height: 4,
                decoration: BoxDecoration(
                  color: EColors.grey,
                ),
              ),
              ///
              // const Text(
              //   "Select Company's",
              //   style: TextStyleClass.subtleTextStyle,
              // ),
            ],
          ),
          items: controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: controller.selectedItems,
          onConfirm: (values) {
            controller.selectedItems.assignAll(values);
            //print('Confirmed Selected Items: ${controller.selectedItems.map((item) => item.name).join(", ")}');
            //print('Confirmed Selected ID: ${controller.selectedItems.map((item) => item.id).join(", ")}');
            controller.vtLocationIds =
                controller.selectedItems.map((item) => item.id).join(",");
            if (kDebugMode) {
              print('From: ${controller.fromController}');
              print('To  : ${controller.toController}');
              print('day : ${controller.totalDayController}');
              print('IDs : ${controller.vtLocationIds}');
            }
          },
          //maxChildSize: 1,
        ),
      ),
    );
  }


   */

/*
  void _showMultiSelect() async {
    Get.bottomSheet(
      enterBottomSheetDuration: const Duration(milliseconds: 100),ignoreSafeArea: true,
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: MultiSelectBottomSheet(

          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(Iconsax.arrow_up_24),
              Container(
                width: 150,
                height: 4,
                decoration: BoxDecoration(
                  color: EColors.grey,
                ),
              ),
              ///
              // const Text(
              //   "Select Company's",
              //   style: TextStyleClass.subtleTextStyle,
              // ),
            ],
          ),
          items: controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: controller.selectedItems,
          onConfirm: (values) {
            controller.selectedItems.assignAll(values);
            //print('Confirmed Selected Items: ${controller.selectedItems.map((item) => item.name).join(", ")}');
            //print('Confirmed Selected ID: ${controller.selectedItems.map((item) => item.id).join(", ")}');
            controller.vtLocationIds =
                controller.selectedItems.map((item) => item.id).join(",");
            if (kDebugMode) {
              print('From: ${controller.fromController}');
              print('To  : ${controller.toController}');
              print('day : ${controller.totalDayController}');
              print('IDs : ${controller.vtLocationIds}');
            }
          },
          //maxChildSize: 1,
        ),
      ),
    );
  }


   */

/// Edit By Alok
/*
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baderia_tech_wave/common/widgets/continue_border_Deco_rectangle/continue_border_rectangle.dart';
import 'package:baderia_tech_wave/utils/constants/teext_styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../data/api/api_services.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../controller/form_controller.dart';
import '../functions/form_functions.dart';

class VTLetterForm extends StatelessWidget {
  /// Instance
  final controller = Get.put(VTLetterFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          /// VT Letter Subject
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: const BoxDecoration(),
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            child: FutureBuilder<List<VtLetterSubject>>(
              future:
              ApiService.fetchVtLetterSubject(), // Fetch Gate Pass Reasons
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer loading effect while fetching
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      // Adjust height as needed
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // If data is fetched successfully
                  return _buildVtLetterSubjectDropdown(snapshot.data!);
                } else {
                  return const Text(
                      'No data available'); // Handle the case when there is no data
                }
              },
            ),
          ),

          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

            // Container(
                // duration: const Duration(milliseconds: 300),
                // curve: Curves.easeInOut,
                // decoration: const BoxDecoration(),
                // constraints: const BoxConstraints(
                  //minHeight: 50.0,

                // child:
                InkWell(
                  onTap:() {
                    _showMultiSelect();
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: CustomDeco.decoRectangle2(),
                    constraints: const BoxConstraints(
                    minHeight: 50.0,
                    minWidth: double.infinity
                    // width: double.infinity,
                    // height: 60,
                    // padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(10),
                     ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        spacing: 8.0,
                        children: controller.selectedItems.map((item) {
                          return Chip(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                            label: Text(item.name),
                            onDeleted: () {
                              controller.toggleSelection(item);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )),
                ),

              // ),


          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// From Date
              Obx(
                () => AnimatedContainer(
                  width: 165,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: const BoxDecoration(),
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                  ),
                  child: TextFormField(
                     readOnly: true,
                    controller: TextEditingController(
                        text: controller.fromController.value),
                    // text: 'Text here',
                    // controller: TextEditingController(text: controller.fromController.value.isEmpty ? 'From' : controller.fromController.value),
                    style: TextStyleClass.inputText1,
                    onChanged: (value) {},

                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Iconsax.calendar_add),
                        onPressed: () {
                          FormUtils.selectDates(
                              context, controller.fromController);

                          // _selectDates(
                          //     context, false, controller.fromController);
                        },
                      ),
                      labelText: 'From',
                      labelStyle: TextStyleClass.labelText1,
                      errorText: controller.fromError.value
                          ? 'Please Select init Date'
                          : null,
                    ),
                  ),
                ),
              ),

              /// To Date
              Obx(() => InkWell(
                    onTap: () {
                      // _selectDates(context, false, controller.toController);
                    },
                    child: AnimatedContainer(
                      width: 165,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: const BoxDecoration(),
                      constraints: const BoxConstraints(
                        minHeight: 50.0,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                            text: controller.toController.value),
                        style: TextStyleClass.inputText1,
                        onChanged: (value) {
                          // controller.toController.value.isEmpty
                          //     ? 'To'
                          //     : controller.toController.value;
                          // controller.reasonError.value = false;
                          // Reset the error state when the user starts typing
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Iconsax.calendar_add),
                            onPressed: () {
                              FormUtils.selectDates(
                                  context, controller.toController);

                              // _selectDates(
                              //     context, false, controller.toController);
                            },
                          ),
                          labelText: 'To',
                          labelStyle: TextStyleClass.labelText1,
                          errorText: controller.toError.value
                              ? 'Please Select to date'
                              : null,
                        ),
                        // maxLength: 250,
                        // maxLines:
                        //     null, // Allow the field to expand vertically as needed
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: ESizes.spaceBtwItems,
          ),

          /// Calculate the Days form the From date and To date & show in this textfield
          Obx(
            () => TextFormField(
              readOnly: true,

              controller: TextEditingController(
                text: FormUtils.calculateDays(
                  controller.fromController.value,
                  controller.toController.value,
                ),
              ),
              onChanged: (value) {

              },
              style: TextStyleClass.inputText1,
              decoration: const InputDecoration(
                labelText: 'Duration (Days)',
                labelStyle: TextStyleClass.labelText1,
                // errorText: controller.totalDayError.value
                //     ? 'Please Select to date'
                //     : null,
              ),
            ),
          ),

          const SizedBox(height: ESizes.spaceBtwItems),
          ElevatedButton(
            onPressed: () {
              FormUtils.submitForm(context, controller);
            },
            child: const Text('Submit Form'),
          ),

        ],

      ),
    );
  }


  Widget _buildVtLetterSubjectDropdown(List<VtLetterSubject> vtLetterSubject) {
    String initialValue = controller.subjectController.value?.id ?? '';

    if (initialValue.isEmpty) {
      initialValue = 'Select VT Letter Subject'; // Set default prompt
    }

    return DropdownButtonFormField<String>(
      isDense: true,
      value: initialValue, // Set initial value here
      decoration: InputDecoration(
        //labelText: 'VT Letter Subject',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        errorText: controller.subjectError.value
            ? 'Select VT Letter Subject'
            : '',
        // : gatePassReasons.firstWhere((group) => group.id == null,
      ),
      onChanged: (String? newValue) {
        controller.subjectController.value =
            vtLetterSubject.firstWhere((group) => group.id == newValue);
            String selectedSubject = controller.subjectController.value?.id ?? '';
            controller.vtSubjectId = selectedSubject.obs;
            //print("ID ${controller.vtSubjectId}");
            controller.getCompany();
            Future.delayed(const Duration(seconds: 2), () {
              _showMultiSelect();
            });

      },

      items: [
        const DropdownMenuItem<String>(
          value: 'Select VT Letter Subject',
          child: Text('Select VT Letter Subject',
              style: TextStyle(fontSize: 12)),
        ),
        ...vtLetterSubject
            .map<DropdownMenuItem<String>>((VtLetterSubject group) {
          return DropdownMenuItem<String>(
            value: group.id,
            child: Text(group.name, style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ],
    );
  }

  /*
  Obx _showReasonBottomSheet(BuildContext context){

    return Obx(() => DropdownButtonFormField<String>(
      isDense: true,
      //value: controller.selectedCompany.value.isNotEmpty?controller.selectedCompany.value:null, // Set initial value here
      decoration: InputDecoration(
        //labelText: 'Gate Pass Reasons',
        labelStyle: const TextStyle(color: EColors.textColorPrimary1),
        errorText: controller.subjectError.value
            ? 'Please Select Gate Pass Reason'
            : '',
        // : gatePassReasons.firstWhere((group) => group.id == null,
      ),
      onChanged: (newValue) {
        controller.selectedCompany.value = newValue.toString();
        //String selectedSubject = controller.subjectController.value?.id ?? '';
        //controller.vtSubjectId = selectedSubject.obs;
        print(controller.selectedCompany.value);
      },

      items: controller.listCompanyDropDown.value,
    ));

  }

  MultiSelectDropDown _showMultiSelectBox(BuildContext context){

    return MultiSelectDropDown(
      //showClearIcon: true,
      //controller: controller.selectedCompanyww,
      onOptionSelected: (options) {
        print(options);
      },
      options: const <ValueItem>[
        ValueItem(label: 'Option 1', value: '1'),
        ValueItem(label: 'Option 2', value: '2'),
        ValueItem(label: 'Option 3', value: '3'),
        ValueItem(label: 'Option 4', value: '4'),
        ValueItem(label: 'Option 5', value: '5'),
        ValueItem(label: 'Option 6', value: '6'),
      ],
      maxItems: 3,
      disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 300,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );

  }

   */

  void _showMultiSelect() async{
     Get.bottomSheet(
      Container(
        color: Colors.white,
        child: MultiSelectBottomSheet(
          title: const Text("Please Select VT Company"),
          items: controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: controller.selectedItems,
           onConfirm: (values) {
             controller.selectedItems.assignAll(values);
            //print('Confirmed Selected Items: ${controller.selectedItems.map((item) => item.name).join(", ")}');
            //print('Confirmed Selected ID: ${controller.selectedItems.map((item) => item.id).join(", ")}');
            controller.vtLocationIds = controller.selectedItems.map((item) => item.id).join(",");
               if (kDebugMode) {
                  print('From: ${controller.fromController}');
                  print('To  : ${controller.toController}');
                  print('day : ${controller.totalDayController}');
                  print('IDs : ${controller.vtLocationIds}');
               }
            },
          maxChildSize: 1,
        ),
      ),
    );
  }

  /*
  void _showMultiSelect(BuildContext context) {
  Get.bottomSheet(
    Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75, // Adjust height according to your needs
            child: ListView(
              shrinkWrap: true,
              children: controller.items
                  .map((item) => CheckboxListTile(
                        title: Text(item.name),
                        value: controller.selectedItems.contains(item),
                        onChanged: (value) {
                          // Handle item selection here
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    ),
  );
}

   */

}

class VtLetterSubject {
  final String id;
  final String name;

  VtLetterSubject({required this.id, required this.name});

  factory VtLetterSubject.fromJson(Map<String, dynamic> json) {
    return VtLetterSubject(
      id: json['vtsubj_id'] ?? '',
      name: json['vtsubj_name'] ?? '',
    );
  }
}
*/

/// Bottom sheet with multiselection
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Item {
  final int id;
  final String name;

  Item(this.id, this.name);
}

class ActivityController extends GetxController {
  final items = <Item>[
    Item(1, 'Item 1'),
    Item(2, 'Item 2'),
    Item(3, 'Item 3'),
    Item(4, 'Item 4'),
    Item(5, 'Item 5'),
  ].obs;

  final selectedItems = <Item>[].obs;

  void toggleSelection(Item item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    print('Selected Items: ${selectedItems.map((item) => item.name).join(", ")}');
    print('Selected Items: ${selectedItems.map((item) => item.id).join(", ")}');
  }
}

class Activity extends StatelessWidget {
  final ActivityController _controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelectBottomSheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showMultiSelect(context);
              },
              child: Text('Open MultiSelect BottomSheet'),
            ),
            SizedBox(height: 20),
            Obx(() => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 8.0,
                children: _controller.selectedItems.map((item) {
                  return Chip(
                    label: Text(item.name),
                    onDeleted: () {
                      _controller.toggleSelection(item);
                    },
                  );
                }).toList(),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showMultiSelect(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: MultiSelectBottomSheet(
          items: _controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: _controller.selectedItems,
          onConfirm: (values) {
            _controller.selectedItems.assignAll(values);
            print('Confirmed Selected Items: ${_controller.selectedItems.map((item) => item.name).join(", ")}');
            print('Confirmed Selected ID: ${_controller.selectedItems.map((item) => item.id).join(", ")}');
          },
          maxChildSize: 1,
        ),
      ),
    );
  }
}
 */

/*
 /// Functions --->
  Future<void> _selectDates(
      BuildContext context, bool isFromDate, RxString controller) async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != currentDate) {
      controller.value = _formatDate(picked);
      print("Date selected: ${controller.value}");
    } else {
      print("Date selection canceled");
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isValidForm(VTLetterFormController controller) {
    if (controller.fromController.value.isEmpty ||
        controller.toController.value.isEmpty ||
        controller.subjectsController.value.isEmpty) {
      controller.reasonError.value =
          controller.subjectsController.value.isEmpty;
      controller.toError.value = controller.toController.value.isEmpty;
      controller.fromError.value = controller.fromController.value.isEmpty;

      print("Form validation failed");
      return false;
    }
    print("Form validation successful");
    return true;
  }

  String _calculateDays(String fromDate, String toDate) {
    try {
      DateTime from = DateTime.parse(fromDate);
      DateTime to = DateTime.parse(toDate);
      Duration duration = to.difference(from);
      return duration.inDays.toString();
    } catch (e) {
      print("Error parsing dates: $e");
      return 'Invalid date format';
    }
  }


  Future<void> _submitForm(
      BuildContext context, VTLetterFormController controller) async {
    if (_isValidForm(controller)) {
      // Perform form submission logic here
      print("Form submitted successfully");
    } else {
      print("Form submission failed");
    }
  }
 */

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Item {
  final int id;
  final String name;

  Item(this.id, this.name);
}

class ActivityController extends GetxController {
  final items = <Item>[
    Item(1, 'Item 1'),
    Item(2, 'Item 2'),
    Item(3, 'Item 3'),
    Item(4, 'Item 4'),
    Item(5, 'Item 5'),
  ].obs;

  final selectedItems = <Item>[].obs;

  void toggleSelection(Item item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    print('Selected Items: ${selectedItems.map((item) => item.name).join(", ")}');
    print('Selected Items: ${selectedItems.map((item) => item.id).join(", ")}');
  }
}

class Activity extends StatelessWidget {
  final ActivityController _controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelectBottomSheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showMultiSelect(context);
              },
              child: Text('Open MultiSelect BottomSheet'),
            ),
            SizedBox(height: 20),
            Obx(() => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 8.0,
                children: _controller.selectedItems.map((item) {
                  return Chip(
                    label: Text(item.name),
                    onDeleted: () {
                      _controller.toggleSelection(item);
                    },
                  );
                }).toList(),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showMultiSelect(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: MultiSelectBottomSheet(
          items: _controller.items
              .map((item) => MultiSelectItem<Item>(item, item.name))
              .toList(),
          initialValue: _controller.selectedItems,
          onConfirm: (values) {
            _controller.selectedItems.assignAll(values);
            print('Confirmed Selected Items: ${_controller.selectedItems.map((item) => item.name).join(", ")}');
            print('Confirmed Selected ID: ${_controller.selectedItems.map((item) => item.id).join(", ")}');
          },
          maxChildSize: 1,
        ),
      ),
    );
  }
}
 */
