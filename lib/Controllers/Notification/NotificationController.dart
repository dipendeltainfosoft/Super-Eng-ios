import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:duke_kanban/Configuration/APIConfig.dart';
import 'package:flutter/material.dart';

class NotificationController {
  static Future getNotification({
    String userId,
    BuildContext context,
  }) async {
    final response =
        await http.post(Uri.parse(notificationURL), body: {"UserId": userId});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }
}
