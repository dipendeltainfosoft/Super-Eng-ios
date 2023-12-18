class UserModel {
  String status;
  String message;
  List<Result> result;

  UserModel({this.status, this.message, this.result});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    
    if (status == "210") {
      result =
          null; 
    } else if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
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
  String fullName;
  String userName;
  String password;

  Result({this.userId, this.fullName, this.userName, this.password});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    fullName = json['FullName'];
    userName = json['UserName'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FullName'] = this.fullName;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    return data;
  }
}
