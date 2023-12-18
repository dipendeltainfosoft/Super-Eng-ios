import 'package:duke_kanban/Configuration/APIConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController {
  static Future getProfileDetails({
    String userId,
    BuildContext context,
  }) async {
    print('user id');
    print(userId);
    final response =
        await http.post(Uri.parse(profileDetailsURL), body: {"UserId": userId});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }

  static Future updateProfilePic({
    String userId,
    String attachment,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(profileUpdateDetailsURL),
        body: {"UserId": userId, "Attachment": attachment});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }

  static Future updatePassword({
    String userId,
    String password,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(profileUpdateDetailsURL),
        body: {"UserId": userId, "Password": password});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }
}
