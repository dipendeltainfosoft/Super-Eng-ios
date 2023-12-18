import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:duke_kanban/Widgets/Messages/Snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Configuration/APIConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Model/UserModel.dart';

class AuthController {
  static Future<UserModel> loginAPI({
    @required String uName,
    @required String pass,
    @required String imei,
    @required String fcm,
    @required BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(loginURL), body: {
      "UserName": uName,
      "Password": pass,
      "FCMId": fcm,
      "IMEI": imei,
    });

    var data = json.decode(utf8.decode(response.bodyBytes));

    if (data['status'] == "200") {
      PrefsConfig.setUserId(UserModel.fromJson(data).result[0].userId);
      PrefsConfig.setUserName(UserModel.fromJson(data).result[0].userName);
      CustomSnackbar.snackbarNormal(context, 'Login successfully');
      Get.offAllNamed('/dashboard');
      return UserModel.fromJson(data);
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      return UserModel.fromJson(data);
    }
  }
}
