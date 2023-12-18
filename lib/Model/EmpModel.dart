class EmpModel {
  String status;
  String message;
  List<Result> result;

  EmpModel({this.status, this.message, this.result});

  EmpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String userId;
  String empId;
  String empName;
  String typeName;
  String deptName;
  String designation;
  String defaultProjectId;
  String lastTask;
  String pendingCnt;
  String workingCnt;
  String doneCnt;
  String photoLink;
  String empStatus;
  String lastDate;
  String lastStatus;

  Result(
      {this.userId,
      this.empId,
      this.empName,
      this.typeName,
      this.deptName,
      this.designation,
      this.defaultProjectId,
      this.lastTask,
      this.pendingCnt,
      this.workingCnt,
      this.doneCnt,
      this.photoLink,
      this.empStatus,
      this.lastDate,
      this.lastStatus});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    empId = json['EmpId'];
    empName = json['EmpName'];
    typeName = json['TypeName'];
    deptName = json['DeptName'];
    designation = json['Designation'];
    defaultProjectId = json['DefaultProjectId'];
    lastTask = json['lastTask'];
    pendingCnt = json['PendingCnt'];
    workingCnt = json['WorkingCnt'];
    doneCnt = json['DoneCnt'];
    photoLink = json['PhotoLink'];
    empStatus = json['EmpStatus'];
    lastDate = json['LastDate'];
    lastStatus = json['LastStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['EmpId'] = this.empId;
    data['EmpName'] = this.empName;
    data['TypeName'] = this.typeName;
    data['DeptName'] = this.deptName;
    data['Designation'] = this.designation;
    data['DefaultProjectId'] = this.defaultProjectId;
    data['lastTask'] = this.lastTask;
    data['PendingCnt'] = this.pendingCnt;
    data['WorkingCnt'] = this.workingCnt;
    data['DoneCnt'] = this.doneCnt;
    data['PhotoLink'] = this.photoLink;
    data['EmpStatus'] = this.empStatus;
    data['LastDate'] = this.lastDate;
    data['LastStatus'] = this.lastStatus;
    return data;
  }
}
