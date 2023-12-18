import 'package:duke_kanban/Model/RemarkModel.dart';
import 'package:duke_kanban/Model/TaskModel.dart';
import 'package:duke_kanban/Widgets/Messages/Snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Configuration/APIConfig.dart';

class TaskController {
  static Future getTaskApprovalList({
    String userId,
    String type,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(taskApprovalListURL), body: {
      "UserId": userId,
      "ListType": type,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }
  static Future updateRemarks({
    String userId,
    String ddid,
    String remark,
    @required String type,
    BuildContext context,
  }) async {
    print('remark '+remark);
    final response = await http.post(Uri.parse(updateTaskList), body: {
      "Type": type,
      "DDid": ddid,
      "Remark": remark,
      "UserId": userId,
      "PDCA": "",
      // "Remark": how,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    }
  }
  static Future updateHowtoPlan({
    String userId,
    String ddid,
    String how,
    String remarks,
    @required String type,
    BuildContext context,
  }) async {
    print(how);
    final response = await http.post(Uri.parse(updateTaskList), body: {
      "Type": type,
      "DDid": ddid,
      "HowToPlan": how,
      "UserId": userId,
      "PDCA": "",
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    }
  }

  static Future updateStatus({
    String userId,
    String sId,
    String dId,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(updateStatusURL),
        body: {"TextListId": sId, "DDid": dId, "UserId": userId, "Text": ""});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      print(data);
      return data;
    }
  }

  static Future updateTargetDate({
    String userId,
    String sId,
    String dId,
    String remarks,
    String dt,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(updateTargetDateURL), body: {
      "DDid": dId,
      "Remarks": remarks,
      "NewTargetDate": dt,
      "UserId": userId
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      CustomSnackbar.snackbarNormal(context, data['message']);
      return data;
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      print(data);
      return data;
    }
  }

  static Future deleteTask({
    String userId,
    String dId,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(deletTaskURL),
        body: {"DDid": dId, "UserId": userId, "Text": ""});
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      return data;
    } else {
      print(data);
      return data;
    }
  }

  static Future updateTaskDetailAPI(
      {@required String dDid,
      @required String mainPoint,
      @required String howToPlan,
      @required String deptId,
      @required String projectTextListId,
      @required String statusTextListId,
      @required String pointGivenUserId,
      @required String remark,
      @required String pDCA,
      @required String userId,
      context}) async {
    final response = await http.post(Uri.parse(updateTaskDetailURL), body: {
      "DDid": dDid,
      "MainPoint": mainPoint,
      "HowToPlan": howToPlan,
      "DeptId": deptId,
      "ProjectTextListId": projectTextListId,
      "StatusTextListId": statusTextListId,
      "PointGivenUserId": pointGivenUserId,
      "Remark": remark,
      "PDCA": pDCA,
      "UserId": userId
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      print(data);
      CustomSnackbar.snackbarNormal(context, data['message']);

      return data;
    } else {
      CustomSnackbar.snackbarNormal(context, data['message']);
      print(data);
      return data;
    }
  }

  static Future getUpdateTaskApprovalList({
    String userId,
    String dDid,
    String status,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(updateApprovalListURL), body: {
      "UserId": userId,
      "DDid": dDid,
      "status": status,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }

  static Future<TaskModel> getTaskList({
    @required final String userId,
    @required final String pri,
    @required final String taskGiven,
    @required final String viewFor,
  }) async {
    final response = await http.post(Uri.parse(taskList), body: {
      "TaskUserId": userId,
      "UserId": userId,
      "TaskGiven": taskGiven,
      "ListType": viewFor,
    });

    var data = json.decode(response.body);
    print('Task List Data $data');
    if (data['status'] == "200") {
      return TaskModel.fromJson(data);
    } else {
      return TaskModel.fromJson(data);
    }
  }

  static Future<TaskModel> getTaskDetail({
    @required final String id,
  }) async {
    final response = await http.post(Uri.parse(taskDetailURL), body: {
      "DDId": id,
    });

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return TaskModel.fromJson(data);
    } else {
      return TaskModel.fromJson(data);
    }
  }

  static Future<RemarkModel> getRemarksHistory({
    @required final String id,
  }) async {
    final response = await http.post(Uri.parse(remarksList), body: {
      "DDId": id,
    });

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return RemarkModel.fromJson(data);
    } else {
      return RemarkModel.fromJson(data);
    }
  }

  static Future getProjectsList() async {
    final response = await http.post(
      Uri.parse(projectListURL),
    );

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      return data['result'];
    } else {
      return data['result'];
    }
  }
}
