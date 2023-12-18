import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Widgets/Buttons/LoginButton.dart';
import 'package:duke_kanban/Widgets/Containers/BgBox.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ChooseLogin extends StatefulWidget {
  @override
  State<ChooseLogin> createState() => _ChooseLoginState();
}

class _ChooseLoginState extends State<ChooseLogin> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ! Box UI
          BgBox(
            title: "Delta iAccount.",
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            data: "Software that Lead your Ways!",
            fSize: 16,
            fColor: ColorConfig.primaryAppColor,
            fWeight: FontWeight.w600,
          ),
          // SizedBox(
          //   height: 30,
          // ),

          // ! Register Button
          // Container(
          //   width: Get.width / 1.2,
          //   child: CustomLoginButton(
          //       press: () {
          //         Get.toNamed("/register");
          //       },
          //       bName: "Sign Up"),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // ! Login Button
          Container(
            width: Get.width / 1.2,
            child: CustomLoginButton(
                press: () {
                  Get.toNamed("/login");
                },
                bName: "Sign In"),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   width: Get.width / 1.2,
          //   height: Get.height / 18,
          //   child: CustomOutButton(
          //     press: () {
          //       Get.toNamed("/login");
          //     },
          //     fcolor: Colors.black,
          //     bName: "Sign In",
          //     color: Colors.white,
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          CustomText(
            // data: "© 2023 Copyright, gainfra.in",
            data: "© Copyright 2023 Delta Infosoft Private Limited.",
            fSize: 14,
            fColor: ColorConfig.primaryAppColor,
            fWeight: FontWeight.w500,
          ),
        ],
      )),
    );
  }
}
