class DepartmentModel {
  String status;
  String message;
  List<Result> result;

  DepartmentModel({this.status, this.message, this.result});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
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
  String deptId;
  String deptName;
  String pendingCnt;
  String workingCnt;
  String doneCnt;
  String type;
  String empDept;
  String empStatus;
  String photolink;
  String empcount;
  String designation;
  String defaultProjectId;
  List<EmpDetails> empDetails;

  Result(
      {this.deptId,
      this.deptName,
      this.pendingCnt,
      this.workingCnt,
      this.doneCnt,
      this.type,
      this.empDept,
      this.empStatus,
      this.photolink,
      this.empcount,
      this.designation,
      this.defaultProjectId,
      this.empDetails});

  Result.fromJson(Map<String, dynamic> json) {
    deptId = json['DeptId'];
    deptName = json['DeptName'];
    pendingCnt = json['PendingCnt'];
    workingCnt = json['WorkingCnt'];
    doneCnt = json['DoneCnt'];
    type = json['Type'];
    empDept = json['EmpDept'];
    empStatus = json['EmpStatus'];
    photolink = json['photolink'];
    empcount = json['empcount'];
    designation = json['Designation'];
    defaultProjectId = json['DefaultProjectId'];
    if (json['EmpDetails'] != null) {
      empDetails = <EmpDetails>[];
      json['EmpDetails'].forEach((v) {
        empDetails.add(new EmpDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeptId'] = this.deptId;
    data['DeptName'] = this.deptName;
    data['PendingCnt'] = this.pendingCnt;
    data['WorkingCnt'] = this.workingCnt;
    data['DoneCnt'] = this.doneCnt;
    data['Type'] = this.type;
    data['EmpDept'] = this.empDept;
    data['EmpStatus'] = this.empStatus;
    data['photolink'] = this.photolink;
    data['empcount'] = this.empcount;
    data['Designation'] = this.designation;
    data['DefaultProjectId'] = this.defaultProjectId;
    if (this.empDetails != null) {
      data['EmpDetails'] = this.empDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmpDetails {
  String deptId;
  String deptName;
  String pendingCnt;
  String workingCnt;
  String doneCnt;
  String type;
  String empDept;
  String empStatus;
  String photolink;
  String empcount;
  String designation;
  String defaultProjectId;

  EmpDetails({
    this.deptId,
    this.deptName,
    this.pendingCnt,
    this.workingCnt,
    this.doneCnt,
    this.type,
    this.empDept,
    this.empStatus,
    this.photolink,
    this.empcount,
    this.designation,
    this.defaultProjectId,
  });

  EmpDetails.fromJson(Map<String, dynamic> json) {
    deptId = json['DeptId'];
    deptName = json['DeptName'];
    pendingCnt = json['PendingCnt'];
    workingCnt = json['WorkingCnt'];
    doneCnt = json['DoneCnt'];
    type = json['Type'];
    empDept = json['EmpDept'];
    empStatus = json['EmpStatus'];
    photolink = json['photolink'];
    empcount = json['empcount'];
    designation = json['Designation'];
    defaultProjectId = json['DefaultProjectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeptId'] = this.deptId;
    data['DeptName'] = this.deptName;
    data['PendingCnt'] = this.pendingCnt;
    data['WorkingCnt'] = this.workingCnt;
    data['DoneCnt'] = this.doneCnt;
    data['Type'] = this.type;
    data['EmpDept'] = this.empDept;
    data['EmpStatus'] = this.empStatus;
    data['photolink'] = this.photolink;
    data['empcount'] = this.empcount;
    data['Designation'] = this.designation;
    data['DefaultProjectId'] = this.defaultProjectId;

    return data;
  }
}
