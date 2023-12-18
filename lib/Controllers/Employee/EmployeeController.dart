import 'package:duke_kanban/Configuration/APIConfig.dart';
import 'package:duke_kanban/Model/EmpModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeController {

  static Future getEmployeeList({
    String userId,
    String priority,
    String taskGiven,
    String viewFor,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(empListURL), body: {
      "UserId": userId,
      "Priority": priority,
      "TaskGiven": taskGiven,
      "ViewFor": viewFor,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }

  // ! This Create by HK for Employee list is already bind using for loop so i create this for normal call in future builder
  static Future<EmpModel> getEmployeeListSearch({
    String userId,
    String priority,
    String taskGiven,
    String viewFor,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(empListURL), body: {
      "UserId": userId,
      "Priority": priority,
      "TaskGiven": taskGiven,
      "ViewFor": viewFor,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return EmpModel.fromJson(data);
    } else {
      return EmpModel.fromJson(data);
    }
  }

  static Future<EmpModel> getMultipleUsers({
    String userId,
    String priority,
    String taskGiven,
    String viewFor,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(empListURL), body: {
      "UserId": userId,
      "Priority": priority,
      "TaskGiven": taskGiven,
      "ViewFor": viewFor,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return EmpModel.fromJson(data);
    } else {
      return EmpModel.fromJson(data);
    }
  }

  static Future getEmployeeListDropdown({
    String userId,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(empListURL), body: {
      "UserId": userId,
      "Priority": "1",
      "TaskGiven": "All",
      "ViewFor": "Company",
    });

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return data['result'];
    } else {
      return data['result'];
    }
  }

  static Future getStatusDropdown() async {
    final response = await http.post(
      Uri.parse(statusListURL),
    );

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return data['result'];
    } else {
      return data['result'];
    }
  }
}
