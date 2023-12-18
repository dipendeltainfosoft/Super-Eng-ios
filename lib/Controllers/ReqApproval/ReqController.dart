import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Configuration/APIConfig.dart';

class ReqController {
  static Future getReqApprovalList({
    String userId,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(reqApprovalListURL), body: {
      "UserId": userId,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }

  static Future getUpdateReqTaskApprovalList({
    String userId,
    String dDid,
    String adStatus,
    String remarks,
    String targetDateRequisitionId,
    BuildContext context,
  }) async {
    final response = await http.post(Uri.parse(updateReqApprovalListURL), body: {
      "UserId": userId,
      "DDId": dDid,
      "ApprovedDisapproved": adStatus,
      "DisapprovedRemarks": remarks,
      "TargetDateRequisitionId": targetDateRequisitionId,
    });
    var data = jsonDecode(response.body);
    if (data['status'] == "200") {
      return data;
    } else {
      return data;
    }
  }
}
