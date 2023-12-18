class PaymentModel {
  String status;
  String message;
  List<Result> result;

  PaymentModel({this.status, this.message, this.result});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  String project;
  String vendor;
  String advanceAmount;
  String approvedDisapproved;
  String insertedBy;
  String pendingAmt;

  Result(
      {this.advancedPaymentId,
      this.no,
      this.requestDt,
      this.project,
      this.vendor,
      this.advanceAmount,
      this.approvedDisapproved,
      this.insertedBy,
      this.pendingAmt});

  Result.fromJson(Map<String, dynamic> json) {
    advancedPaymentId = json['AdvancedPaymentId'];
    no = json['No'];
    requestDt = json['RequestDt'];
    project = json['Project'];
    vendor = json['Vendor'];
    advanceAmount = json['AdvanceAmount'];
    approvedDisapproved = json['ApprovedDisapproved'];
    insertedBy = json['InsertedBy'];
    pendingAmt = json['PendingAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdvancedPaymentId'] = this.advancedPaymentId;
    data['No'] = this.no;
    data['RequestDt'] = this.requestDt;
    data['Project'] = this.project;
    data['Vendor'] = this.vendor;
    data['AdvanceAmount'] = this.advanceAmount;
    data['ApprovedDisapproved'] = this.approvedDisapproved;
    data['InsertedBy'] = this.insertedBy;
    data['PendingAmt'] = this.pendingAmt;
    return data;
  }
}
