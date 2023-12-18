class DropModel {
  String status;
  String message;
  List<Result> result;

  DropModel({this.status, this.message, this.result});

  DropModel.fromJson(Map<String, dynamic> json) {
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
  String textListId;
  String text;
  String name;
  String lgrId;

  Result({this.textListId, this.text});

  Result.fromJson(Map<String, dynamic> json) {
    textListId = json['TextListId'];
    text = json['Text'];
    name = json['Name'];
    lgrId = json['lgrId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TextListId'] = this.textListId;
    data['Text'] = this.text;
    data['Name'] = this.name;
    data['lgrId'] = this.lgrId;
    return data;
  }
}
