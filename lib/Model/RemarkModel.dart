class RemarkModel {
  String status;
  String message;
  List<Result> result;

  RemarkModel({this.status, this.message, this.result});

  RemarkModel.fromJson(Map<String, dynamic> json) {
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
  String dDLnId;
  String dDId;
  String startTime;
  String description;
  String typeText;
  String endTime;
  String hrs;
  String insertedOn;
  String lastUpdatedOn;
  String insertedByUserId;
  String lastUpdatedByUserId;
  String lnno;
  String startDate;
  String endDate;
  String dDLnsStatusTextListId;
  String tag;

  Result(
      {this.dDLnId,
      this.dDId,
      this.startTime,
      this.description,
      this.typeText,
      this.endTime,
      this.hrs,
      this.insertedOn,
      this.lastUpdatedOn,
      this.insertedByUserId,
      this.lastUpdatedByUserId,
      this.lnno,
      this.startDate,
      this.endDate,
      this.dDLnsStatusTextListId,
      this.tag});

  Result.fromJson(Map<String, dynamic> json) {
    dDLnId = json['DDLnId'];
    dDId = json['DDId'];
    startTime = json['StartTime'];
    description = json['Description'];
    typeText = json['TypeText'];
    endTime = json['EndTime'];
    hrs = json['Hrs'];
    insertedOn = json['InsertedOn'];
    lastUpdatedOn = json['LastUpdatedOn'];
    insertedByUserId = json['InsertedByUserId'];
    lastUpdatedByUserId = json['LastUpdatedByUserId'];
    lnno = json['Lnno'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    dDLnsStatusTextListId = json['DDLnsStatusTextListId'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DDLnId'] = this.dDLnId;
    data['DDId'] = this.dDId;
    data['StartTime'] = this.startTime;
    data['Description'] = this.description;
    data['TypeText'] = this.typeText;
    data['EndTime'] = this.endTime;
    data['Hrs'] = this.hrs;
    data['InsertedOn'] = this.insertedOn;
    data['LastUpdatedOn'] = this.lastUpdatedOn;
    data['InsertedByUserId'] = this.insertedByUserId;
    data['LastUpdatedByUserId'] = this.lastUpdatedByUserId;
    data['Lnno'] = this.lnno;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['DDLnsStatusTextListId'] = this.dDLnsStatusTextListId;
    data['Tag'] = this.tag;
    return data;
  }
}
