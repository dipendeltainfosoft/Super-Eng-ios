import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Widgets/Buttons/LoginButton.dart';
import 'package:duke_kanban/Widgets/Messages/Snackbar.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/Others/CustomTexts.dart';
import '../../Widgets/TextFields/TextFields.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.materialAppbar(screenName: "", lead: lead()),
      body: ListView(
        children: [
          // Center(
          //   child: ImageConfig.fromAsset(
          //     imagePath: loginImage,
          //     size: Get.height / 2.5,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(10),
            height: Get.height / 1,
            width: Get.width,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  data: "Sign Up",
                  align: TextAlign.center,
                  fSize: 22,
                  fWeight: FontWeight.bold,
                ),
                // SizedBox(
                //   height: 20,
                // ),
                ListTile(
                  title: CustomText(data: "Full Name", fSize: 14),
                  subtitle: CustomTextField(
                      mLength: 10,
                      hintText: "Sanjay Raval",
                      type: TextInputType.text,
                      prefix: Icon(Icons.person_2_sharp,
                          color: ColorConfig.btnColor3),
                      controller: controller1,
                      obscureText: false, fillColor: null,),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: CustomText(data: "Email-Address", fSize: 14),
                  subtitle: CustomTextField(
                      mLength: 10,
                      hintText: "example@gmail.com",
                      type: TextInputType.emailAddress,
                      prefix: Icon(
                        Icons.email,
                        color: ColorConfig.btnColor3,
                      ),
                      controller: controller1,
                      obscureText: false),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: CustomText(data: "Mobile Number", fSize: 14),
                  subtitle: CustomTextField(
                      mLength: 10,
                      hintText: "+91-1234567890",
                      type: TextInputType.number,
                      prefix: Icon(
                        Icons.call,
                        color: ColorConfig.btnColor3,
                      ),
                      controller: controller1,
                      obscureText: false),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: CustomText(data: "Password", fSize: 14),
                  subtitle: CustomTextField(
                    hintText: "Enter Password",
                    controller: controller2,
                    obscureText: isHide,
                    prefix: Icon(
                      Icons.lock,
                      color: ColorConfig.btnColor3,
                    ),
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: Icon(
                          isHide ? Icons.visibility : Icons.visibility_off,
                          color: ColorConfig.btnColor3,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  subtitle: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: CustomLoginButton(
                          press: () {
                            CustomSnackbar.snackbarNormal(
                              context,
                              "Register Successfully Done",
                            );
                          },
                          bName: "Register")),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CustomRichText(
                      press: () {
                        Get.toNamed('/login');
                      },
                      firstText: "Already have an account?",
                      secondText: " Login"),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorConfig.boxColor,
            ),
          ),
        ],
      ),
    );
  }
}
