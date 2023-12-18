import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Controllers/Authentication/LoginController.dart';
import 'package:duke_kanban/Widgets/Containers/BgBox.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:duke_kanban/Widgets/Others/on_tap_keyboard_remover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Networks/Connections/Connection.dart';
import '../../Widgets/Buttons/LoginButton.dart';
import '../../Widgets/Messages/Snackbar.dart';
import '../../Widgets/TextFields/TextFields.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController pass = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isPass = false;
  bool isDisable = false;
  final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  String imei = "";
  String fcmId = "";

  Future<void> getImeiNumber() async {
    imei = await UniqueIdentifier.serial;
    print('IMEI: $imei');
  }

  @override
  void dispose() {
    userNameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  //Future<void> getFCMID() async {
  //  await FirebaseMessaging.instance.getToken().then((value) {
  //    setState(() {
  //      fcmId = value;
  //    });
  //    print("Your FCM Token:  " + fcmId);
  //  });
  //}

  @override
  void initState() {
    super.initState();
    getImeiNumber();
  }

  @override
  Widget build(BuildContext context) {
    return OnTapKeyBoardRemoveWidget(
      child: Scaffold(
        backgroundColor: ColorConfig.primaryAppColor,
        // appBar: CustomAppbar.materialAppbar(screenName: ""),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: ImageConfig.fromAsset(
                    imagePath: applogoImage,
                    size: Get.height / 8,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  data: "Kanban 3.0",
                  fColor: Colors.white,
                  fSize: 22,
                  fWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 30,
                ),
                BgBox(
                  title: "Login",
                  cols: [
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: CustomText(
                        data: "Login",
                        align: TextAlign.left,
                        fSize: 24,
                        fWeight: FontWeight.bold,
                        fColor: Colors.black,
                      ),
                      subtitle: CustomText(
                        data: "Proceed with your credentials",
                        fWeight: FontWeight.normal,
                        fSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      textFieldColor: Colors.white,
                      title: "",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: userNameFocus,
                      onEditingComplete: () {
                        // Move focus to the password field when "Next" is pressed
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      fillColor: ColorConfig.primaryDarkAppColor,
                      validator: (val) {
                        if (val.trim().isEmpty) {
                          return 'Please Enter User Name';
                        }
                        return null;
                      },
                      prefix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      onChange: (value) {
                        // Update the controller's value by trimming leading and trailing spaces
                        userName.value = userName.value.copyWith(
                          text: value.trim(),
                          selection: TextSelection.collapsed(
                              offset: value.trim().length),
                          composing: TextRange.empty,
                        );
                      },
                      hintText: "Enter Username",
                      controller: userName,
                      obscureText: false,
                    ),

                    // CustomTextField(
                    //     textFieldColor: Colors.white,
                    //     title: "",
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     fillColor: ColorConfig.primaryDarkAppColor,
                    //     validator: (val) {
                    //       String trimmedValue = val.trim();
                    //       if (val.isEmpty) {
                    //         return 'Please Enter User Name';
                    //       }
                    //       return null;
                    //     },
                    //     prefix: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.person,
                    //           color: Colors.white,
                    //         )),
                    //     onChange: (value) {
                    //       userName.text = value.trim();
                    //     },
                    //     hintText: "Enter Username",
                    //     controller: userName,
                    //     obscureText: false),
                    CustomTextField(
                        textFieldColor: Colors.white,
                        title: "",
                        fillColor: ColorConfig.primaryDarkAppColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: passwordFocus,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPass = !isPass;
                              });
                            },
                            icon: Icon(
                              isPass ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            )),
                        prefix: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.key,
                              color: Colors.white,
                            )),
                        hintText: "Enter Password",
                        controller: pass,
                        obscureText: isPass ? false : true),
                    SizedBox(
                      height: 20,
                    ),
                    isDisable == false
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: Get.width / 3,
                              child: CustomLoginButton(
                                  press: () {
                                    errorLens();
                                  },
                                  bName: "Login"),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: Get.width / 3,
                              child: CustomLoginButton(
                                  circular: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  press: () {
                                    CustomSnackbar.snackbarNormal(
                                        context, "Please Wait");
                                  },
                                  bName: "Wait.."),
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  errorLens() {
    if (networkManager.connectionType == 0) {
      CustomSnackbar.snackbarNormal(context, "No Internet Connection",
          color: Colors.red);
      return;
    }
    if (loginKey.currentState.validate()) {
      setState(() {
        isDisable = true;
        AuthController.loginAPI(
                uName: userName.text.trim(),
                pass: pass.text,
                imei: imei,
                fcm: "",
                context: context)
            .then((value) => {
                  if (value.status == "200")
                    {
                      setState(() {
                        isDisable = false;
                      })
                    }
                  else if (value.status == "210")
                    {
                      setState(() {
                        isDisable = false;
                      })
                    }
                  else
                    {
                      setState(() {
                        isDisable = false;
                      })
                    }
                });
      });
    }
  }
  // errorLens() {
  //   if (networkManager.connectionType == 0) {
  //     CustomSnackbar.snackbarNormal(context, "No Internet Connection",
  //         color: Colors.red);
  //   } else if (userName.text.isEmpty) {
  //     CustomSnackbar.snackbarNormal(context, "Please Enter Username",
  //         color: Colors.red);
  //   } else if (pass.text.isEmpty) {
  //     CustomSnackbar.snackbarNormal(context, "Please Enter Password",
  //         color: Colors.red);
  //   } else {
  //     setState(() {
  //       isDisable = true;
  //       AuthController.loginAPI(
  //               uName: userName.text,
  //               pass: pass.text,
  //               imei: imei,
  //               fcm: "",
  //               context: context)
  //           .then((value) => {
  //                 if (value.status == "200")
  //                   {
  //                     setState(() {
  //                       isDisable = false;
  //                     })
  //                   }
  //                 else if (value.status == "210")
  //                   {
  //                     setState(() {
  //                       isDisable = false;
  //                     })
  //                   }
  //                 else
  //                   {
  //                     setState(() {
  //                       isDisable = false;
  //                     })
  //                   }
  //               });
  //     });
  //   }
  // }
}
