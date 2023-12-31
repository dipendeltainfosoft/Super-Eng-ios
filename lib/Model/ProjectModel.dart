class ProjectModel {
  String status;
  String message;
  List<Result> result;

  ProjectModel({this.status, this.message, this.result});

  ProjectModel.fromJson(Map<String, dynamic> json) {
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
  String projectId;
  String projectName;

  Result({this.projectId, this.projectName});

  Result.fromJson(Map<String, dynamic> json) {
    projectId = json['ProjectId'];
    projectName = json['ProjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectId'] = this.projectId;
    data['ProjectName'] = this.projectName;
    return data;
  }
}
