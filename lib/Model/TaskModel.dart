class TaskModel {
  String status;
  String message;
  List<Result> result;

  TaskModel({this.status, this.message, this.result});

  TaskModel.fromJson(Map<String, dynamic> json) {
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
  String ddId;
  String no;
  String project;
  String mainPoint;
  String priority;
  String remarks;
  String empName;
  String date;
  String targetDt;
  String status;
  String statusName;
  String pDCA;
  String approvedBY;
  String approvalRemark;
  String insertedOn;
  String pointGivenUserId;
  String insertedByUserId;
  String remarksLn;
  String statusTextListId;
  String result;
  String pointGivenByName;
  String fileName;
  String p;
  String d;
  String c;
  String a;
  String taskDue;
  String tick;
  String approvedDisapproved;
  String pendingApprovalCnt;
  String view;
  String dailyCheckListReason;
  String dailyCheckListReasonTextListId;
  String weight;
  String marks;
  String priority1;
  String taskGeneratedDate;
  String requisitionCount;
  String projectId;
  String deptId;
  String deptName;
  String howToPlan;
  String projectName;
  String givenTo;

  Result(
      {this.ddId,
      this.no,
      this.project,
      this.mainPoint,
      this.priority,
      this.givenTo,
      this.remarks,
      this.empName,
      this.projectName,
      this.date,
      this.targetDt,
      this.status,
      this.statusName,
      this.pDCA,
      this.projectId,
      this.deptId,
      this.approvedBY,
      this.deptName,
      this.approvalRemark,
      this.insertedOn,
      this.pointGivenUserId,
      this.insertedByUserId,
      this.remarksLn,
      this.statusTextListId,
      this.result,
      this.pointGivenByName,
      this.howToPlan,
      this.fileName,
      this.p,
      this.d,
      this.c,
      this.a,
      this.taskDue,
      this.tick,
      this.approvedDisapproved,
      this.pendingApprovalCnt,
      this.view,
      this.dailyCheckListReason,
      this.dailyCheckListReasonTextListId,
      this.weight,
      this.marks,
      this.priority1,
      this.taskGeneratedDate,
      this.requisitionCount});

  Result.fromJson(Map<String, dynamic> json) {
    ddId = json['ddId'];
    no = json['No'];
    project = json['Project'];
    projectName = json['ProjectName'];
    mainPoint = json['MainPoint'];
    priority = json['Priority'];
    remarks = json['Remarks'];
    empName = json['EmpName'];
    date = json['Date'];
    targetDt = json['TargetDt'];
    status = json['Status'];
    pDCA = json['PDCA'];
    approvedBY = json['ApprovedBY'];
    approvalRemark = json['ApprovalRemark'];
    insertedOn = json['InsertedOn'];
    pointGivenUserId = json['PointGivenUserId'];
    insertedByUserId = json['InsertedByUserId'];
    remarksLn = json['RemarksLn'];
    statusTextListId = json['StatusTextListId'];
    result = json['Result'];
    pointGivenByName = json['PointGivenByName'];
    givenTo = json['GivenToUserName'];
    fileName = json['FileName'];
    p = json['P'];
    d = json['D'];
    c = json['C'];
    a = json['A'];
    taskDue = json['TaskDue'];
    tick = json['Tick'];
    approvedDisapproved = json['ApprovedDisapproved'];
    pendingApprovalCnt = json['PendingApprovalCnt'];
    view = json['View'];
    dailyCheckListReason = json['DailyCheckListReason'];
    dailyCheckListReasonTextListId = json['DailyCheckListReasonTextListId'];
    weight = json['Weight'];
    marks = json['Marks'];
    priority1 = json['Priority1'];
    taskGeneratedDate = json['TaskGeneratedDate'];
    requisitionCount = json['RequisitionCount'];
    projectId = json['ProjectTextListId'];
    deptId = json['DeptId'];
    deptName = json['DepartmentName'];
    howToPlan = json['HowToPlan'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ddId'] = this.ddId;
    data['No'] = this.no;
    data['Project'] = this.project;
    data['ProjectName'] = this.projectName;
    data['MainPoint'] = this.mainPoint;
    data['Priority'] = this.priority;
    data['Remarks'] = this.remarks;
    data['EmpName'] = this.empName;
    data['Date'] = this.date;
    data['TargetDt'] = this.targetDt;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['PDCA'] = this.pDCA;
    data['ApprovedBY'] = this.approvedBY;
    data['ApprovalRemark'] = this.approvalRemark;
    data['InsertedOn'] = this.insertedOn;
    data['PointGivenUserId'] = this.pointGivenUserId;
    data['InsertedByUserId'] = this.insertedByUserId;
    data['RemarksLn'] = this.remarksLn;
    data['StatusTextListId'] = this.statusTextListId;
    data['Result'] = this.result;
    data['PointGivenByName'] = this.pointGivenByName;
    data['GivenToUserName'] = this.givenTo;
    data['FileName'] = this.fileName;
    data['P'] = this.p;
    data['D'] = this.d;
    data['C'] = this.c;
    data['A'] = this.a;
    data['TaskDue'] = this.taskDue;
    data['Tick'] = this.tick;
    data['ApprovedDisapproved'] = this.approvedDisapproved;
    data['PendingApprovalCnt'] = this.pendingApprovalCnt;
    data['View'] = this.view;
    data['DailyCheckListReason'] = this.dailyCheckListReason;
    data['DailyCheckListReasonTextListId'] =
        this.dailyCheckListReasonTextListId;
    data['Weight'] = this.weight;
    data['Marks'] = this.marks;
    data['Priority1'] = this.priority1;
    data['TaskGeneratedDate'] = this.taskGeneratedDate;
    data['RequisitionCount'] = this.requisitionCount;
    data['ProjectTextListId'] = this.projectId;
    data['DeptId'] = this.deptId;
    data['DepartmentName'] = this.deptName;
    data['HowToPlan'] = this.howToPlan;
    return data;
  }
}
