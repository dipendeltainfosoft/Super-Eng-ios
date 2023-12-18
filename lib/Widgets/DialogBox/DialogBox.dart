import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Configuration/ColorConfig.dart';
import '../Others/CustomTexts.dart';
import '../TextFields/TextFields.dart';

class CustomDialogBox {
  static Future<void> alertDialogBoxRemarks(context,
      {String msgText,
      VoidCallback copyFunc,
      String titleText,
      TextEditingController controllerTxt}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () {
                  controllerTxt.text = '';
                  Get.back();
                },
                child: CustomText(
                  data: "Cancel",
                  fColor: Colors.black,
                  fWeight: FontWeight.bold,
                ),
              ),
              MaterialButton(
                onPressed: copyFunc,
                child: CustomText(
                  data: "Ok",
                  fColor: Colors.black,
                  fWeight: FontWeight.bold,
                ),
              )
            ],
            title: CustomText(
              data: titleText,
              fColor: Colors.black,
              fWeight: FontWeight.w900,
            ),
            //contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    data: msgText,
                    fColor: Colors.black,
                    fWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      // fillColor: ColorConfig.primaryLightAppColor,
                      title: "",
                      controller: controllerTxt,
                      prefix: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.note,
                            color: Colors.white,
                          )),
                      hintText: "Enter Remarks",
                      obscureText: false),
                ],
              ),
            ));
      },
    );
  }

  static Future<void> alertDialogBox(context,
      {String msgText, VoidCallback copyFunc, String titleText}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                data: "Cancel",
                fColor: Colors.black,
                fWeight: FontWeight.bold,
              ),
            ),
            MaterialButton(
              onPressed: copyFunc,
              child: CustomText(
                data: "Ok",
                fColor: Colors.black,
                fWeight: FontWeight.bold,
              ),
            )
          ],
          title: CustomText(
            data: titleText,
            fColor: Colors.black,
            fWeight: FontWeight.w900,
          ),
          content: CustomText(
            data: msgText,
            fColor: Colors.black,
            fWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  static Future<void> logoutDialog(context, {String iText, VoidCallback yes}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          actions: [
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text("No"),
            ),
            MaterialButton(
              onPressed: yes,
              child: Text("Yes"),
            )
          ],
          title: Text("Are you really want to Logout?"),
        );
      },
    );
  }

  static Future<void> logoutDialogIOS(BuildContext context,
      {String iText, VoidCallback yes}) {
    return showGeneralDialog(
      context: context,
      transitionDuration: 300.milliseconds,
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
        child: child,
      ),
      pageBuilder: (context, animation, secondaryAnimation) =>
          CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            onPressed: yes,
            child: Text("Yes"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"),
          ),
        ],
        title: Text("Are you sure you want to Logout?"),
      ),
    );
  }

  static Future<void> howToPlan(BuildContext context,
      {String iText,
      VoidCallback yes,
      TextEditingController how,
      String text}) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: yes,
              child: Text("Update"),
            ),
          ],
          //title: Text("Are you sure you want to Logout?"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.primaryAppColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      data: iText,
                      fSize: 16,
                      fColor: Colors.white,
                      fWeight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   /*child: Text(
                //     "Title",
                //     style: TextStyle(
                //         fontSize: 16,
                //         color: Color.fromARGB(255, 0, 0, 0),
                //         fontWeight: FontWeight.w900),
                //   ),*/
                //   child: CustomText(
                //     data: "Title",
                //     fSize: 16,
                //     fColor: Colors.black,
                //     fWeight: FontWeight.bold,
                //     align: TextAlign.start,
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: CustomText(
                //     data: "Msg",
                //     fSize: 12,
                //     fColor: Colors.grey,
                //     fWeight: FontWeight.bold,
                //     align: TextAlign.start,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1, // Divider height
                  color: CupertinoColors.destructiveRed, // Divider color
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    data: text,
                    fSize: 16,
                    fColor: Colors.black,
                    align: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CupertinoTextField(
                    controller: how,
                    //controller: controllerTxt,
                    /*prefix: CupertinoButton(
                        onPressed: () {},
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Colors.black,
                        )),*/
                    obscureText: false),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> taskListMenuDialog(context,
      {VoidCallback remarkHistory,
      VoidCallback deleteTask,
      String id,
      VoidCallback editTask}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          title: CustomText(
            data: 'Menu',
            fColor: Colors.black,
            fWeight: FontWeight.w900,
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*Container(
                    color: Colors.grey,
                    height: 1.0,
                  ),*/
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/remark', arguments: id);
                    },
                    child: buildEditText('Remarks History'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.back();
                      deleteTask();
                    },
                    child: buildEditText('Delete Task'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      editTask();
                    },
                    child: buildEditText('Edit Task'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget buildEditText(String text) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: ColorConfig.primaryLightAppColor,
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Center(
        child: CustomText(
          data: text,
          fSize: 16,
          fColor: Colors.black,
          fWeight: FontWeight.bold,
          align: TextAlign.center,
        ),
      ),
      /*readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12.0),
        filled: true,
        fillColor: ColorConfig.primaryLightAppColor,
        hintText: text,
        hintStyle: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
      ),*/
    );
  }

  static Future<void> targetDtReq(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                //padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 70.0,
                                  height: 5.0,
                                  margin: EdgeInsets.only(top: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  'Target Date Requisition',
                                  style: TextStyle(
                                    fontFamily: 'hind',
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.0),
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        color: Colors.blue,
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(8.0),
                                            hintText: 'Select Date',
                                            hintStyle:
                                                TextStyle(color: Colors.blue),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: Container(
                                          margin: EdgeInsets.only(right: 8.0),
                                          padding: EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: TextField(
                                    maxLength: 200,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'hind',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter Remarks',
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    padding: EdgeInsets.all(8.0),
                                  ),
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
