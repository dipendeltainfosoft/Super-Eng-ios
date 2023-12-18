import 'dart:async';

import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Widgets/TextFields/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Buttons/LoginButton.dart';
import '../Dropdown/SearchDropdown.dart';

class CustomBottomSheet {
  static Future<void> chooseFilebottomSheet(
    context, {
    VoidCallback gall,
    VoidCallback takePhoto,
    VoidCallback documentFile,
  }) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (context) {
        return Builder(
          builder: (BuildContext builderContext) {
            return Container(
              padding: EdgeInsets.all(12),
              height: Get.height / 3.8,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  CustomLoginButton(
                    press: gall,
                    bName: "1). Choose from Gallery",
                  ),
                  SizedBox(height: 10),
                  CustomLoginButton(
                    press: takePhoto,
                    bName: "2). Take Photo",
                  ),
                  SizedBox(height: 10),
                  CustomLoginButton(
                    fcolor: Colors.white,
                    press: documentFile,
                    bName: "3). Choose Document File",
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static Future<void> updateTargetDate(
    context, {
    VoidCallback selectDateFunction,
    VoidCallback updateFunction,
    TextEditingController controller,
    TextEditingController remarksCltr,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),

                  InkWell(
                    onTap: selectDateFunction,
                    child: CustomTextField(
                        isEnabled: false,
                        lText: "",
                        title: "Select Date",
                        hintColor: Colors.black,
                        hintText: "Select Date",
                        prefix: Icon(Icons.calendar_month_outlined),
                        controller: controller,
                        obscureText: false,
                        fillColor: ColorConfig.primaryLightAppColor),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                      // isEnabled: false,
                      lText: "",
                      title: "Remarks",
                      hintColor: Colors.black,
                      hintText: "Remarks",
                      prefix: Icon(Icons.text_fields),
                      controller: remarksCltr,
                      obscureText: false,
                      fillColor: ColorConfig.primaryLightAppColor),
                  SizedBox(
                    height: 10,
                  ),
                  CustomLoginButton(press: updateFunction, bName: "Update"),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   width: Get.width / 1.05,
                  //   height: Get.height / 18,
                  //   child: CustomOutButton(
                  //     press: editFunc,
                  //     fcolor: Colors.black,
                  //     bName: "Edit Mode",
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomCancelButton(
                  //   fcolor: Colors.white,
                  //   press: () {
                  //     Get.back();
                  //   },
                  //   // fcolor: Colors.black,
                  //   bName: "Cancel",
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          );
        });
  }

  static Future<void> taskListBottomSheet(
    context, {
    TextEditingController taskCltr,
    TextEditingController projectCltr,
    TextEditingController dateCltr,
    FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback,
    TextEditingController planCltr,
    dynamic Function(dynamic) onSelected,
    VoidCallback selectDate,
    @required VoidCallback uploadFile,
    @required VoidCallback multipleusers,
    @required VoidCallback addTask,
    VoidCallback doneButton,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Scaffold(
              body: Container(
                // height: Get.height / 2,
                color: ColorConfig.primaryLightAppColor2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: "Write Task....",
                            controller: taskCltr,
                            obscureText: false,
                            title: "",
                            hintColor: ColorConfig.primaryAppColor,
                            fillColor: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: ColorConfig.primaryAppColor,
                          child: Transform.rotate(
                            angle: 3.14159 / 2,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: ColorConfig.primaryAppColor,
                          child: IconButton(
                              onPressed: addTask,
                              iconSize: 20,
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SearchDropdownWOTitle(
                          hint: "Select Project",
                          controller: projectCltr,
                          title: "",
                          suggestionsCallback: suggestionsCallback,
                          onSelected: onSelected,
                          suggestionText: "ProjectName"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: InkWell(
                          onTap: () {
                            selectDate();
                          },
                          child: CustomTextFieldWOTitle(
                              hintText: "Select Target Date",
                              controller: dateCltr,
                              obscureText: false,
                              isEnabled: false,
                              fillColor: Colors.white,
                              hintColor: ColorConfig.primaryAppColor,
                              title: ""),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextFieldWOTitle(
                          hintText: "How to Plan",
                          controller: planCltr,
                          obscureText: false,
                          fillColor: Colors.white,
                          hintColor: ColorConfig.primaryAppColor,
                          title: ""),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Get.width / 2,
                            child: CustomLoginButton(
                              iconData: Icons.attach_file,
                              press: uploadFile,
                              bName: "Upload File",
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // width: Get.width / 2.5,
                            child: CustomLoginButton(
                              press: multipleusers,
                              bName: "Multiple User",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    
                  ],
                ),
              ),
            );
          });
        });
  }

  // static Future<void> multipleUsers(context, Widget child) {
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       useSafeArea: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(10), topRight: Radius.circular(10)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return Scaffold(
  //               body: Container(
  //                   // height: Get.height / 2,
  //                   color: ColorConfig.primaryLightAppColor2,
  //                   child: child));
  //         });
  //       });
  // }
}
