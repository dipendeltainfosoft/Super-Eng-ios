import 'dart:convert';
import 'package:duke_kanban/Model/EmpModel.dart';
import 'package:flutter/material.dart';
import '../../Configuration/APIConfig.dart';
import '../../Model/DeptModel.dart';
import 'package:http/http.dart' as http;

class DepartmentController {
  static Future<DepartmentModel> getDepartmentListByEmpAPI({
    @required final String userId,
    @required final String pri,
    @required final String taskGiven,
    @required final String viewFor,
  }) async {
    final response = await http.post(Uri.parse(getDeptList), body: {
      "UserId": userId,
      "Priority": pri,
      "TaskGiven": taskGiven,
      "ViewFor": viewFor
    });

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return DepartmentModel.fromJson(data);
    } else {
      return DepartmentModel.fromJson(data);
    }
  }

  static Future<EmpModel> getEmpbyDeptId({
    @required final String deptId,
  }) async {
    final response = await http.post(Uri.parse(getEmpByDPID), body: {
      "DeptId": deptId,
    });

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return EmpModel.fromJson(data);
    } else {
      return EmpModel.fromJson(data);
    }
  }
}
