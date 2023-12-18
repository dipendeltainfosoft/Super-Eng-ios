class ApprovalModel {
  String status;
  String message;
  List<Result> result;

  ApprovalModel({this.status, this.message, this.result});

  ApprovalModel.fromJson(Map<String, dynamic> json) {
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
  String advancedPaymentId;
  String no;
  String requestDt;
  String pRType;
  String project;
  String vendor;
  String dueAmt;
  String remarks;
  String advanceAmount;
  String tLApprovedAmt;
  String accApprovedAmt;
  String gSTHoldAmt;
  String gSTApprovedAmt;
  String accHODApprovedAmt;
  String bankingApprovedAmt;
  String approvedDisapprovedOnByAccHOD;
  String finalApprovedAmt;
  String pendBankApprovalAmt;

  Result(
      {this.advancedPaymentId,
      this.no,
      this.requestDt,
      this.pRType,
      this.project,
      this.vendor,
      this.dueAmt,
      this.remarks,
      this.advanceAmount,
      this.tLApprovedAmt,
      this.accApprovedAmt,
      this.gSTHoldAmt,
      this.gSTApprovedAmt,
      this.accHODApprovedAmt,
      this.bankingApprovedAmt,
      this.approvedDisapprovedOnByAccHOD,
      this.pendBankApprovalAmt,
      this.finalApprovedAmt});

  Result.fromJson(Map<String, dynamic> json) {
    advancedPaymentId = json['AdvancedPaymentId'];
    no = json['No'];
    requestDt = json['RequestDt'];
    pRType = json['PRType'];
    project = json['Project'];
    vendor = json['Vendor'];
    dueAmt = json['DueAmt'];
    remarks = json['Remarks'];
    advanceAmount = json['AdvanceAmount'];
    tLApprovedAmt = json['TLApprovedAmt'];
    accApprovedAmt = json['AccApprovedAmt'];
    gSTHoldAmt = json['GSTHoldAmt'];
    gSTApprovedAmt = json['GSTApprovedAmt'];
    accHODApprovedAmt = json['AccHODApprovedAmt'];
    bankingApprovedAmt = json['BankingApprovedAmt'];
    approvedDisapprovedOnByAccHOD = json['ApprovedDisapprovedOnByAccHOD'];
    finalApprovedAmt = json['FinalApprovedAmt'];
    pendBankApprovalAmt = json['PendingBankingApprovedAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdvancedPaymentId'] = this.advancedPaymentId;
    data['No'] = this.no;
    data['RequestDt'] = this.requestDt;
    data['PRType'] = this.pRType;
    data['Project'] = this.project;
    data['Vendor'] = this.vendor;
    data['DueAmt'] = this.dueAmt;
    data['Remarks'] = this.remarks;
    data['AdvanceAmount'] = this.advanceAmount;
    data['TLApprovedAmt'] = this.tLApprovedAmt;
    data['AccApprovedAmt'] = this.accApprovedAmt;
    data['GSTHoldAmt'] = this.gSTHoldAmt;
    data['GSTApprovedAmt'] = this.gSTApprovedAmt;
    data['AccHODApprovedAmt'] = this.accHODApprovedAmt;
    data['BankingApprovedAmt'] = this.bankingApprovedAmt;
    data['ApprovedDisapprovedOnByAccHOD'] = this.approvedDisapprovedOnByAccHOD;
    data['FinalApprovedAmt'] = this.finalApprovedAmt;
    data['PendingBankingApprovedAmt'] = this.pendBankApprovalAmt;
    return data;
  }
}
