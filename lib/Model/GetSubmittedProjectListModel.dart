import 'dart:convert';

GetSubmittedProjectListModel getSubmittedProjectListModelFromJson(String str) =>
    GetSubmittedProjectListModel.fromJson(json.decode(str));

String getSubmittedProjectListModelToJson(GetSubmittedProjectListModel data) =>
    json.encode(data.toJson());

class GetSubmittedProjectListModel {
  GetSubmittedProjectListModel({
    this.status,
    this.message,
    this.projectList,
  });

  int status;
  String message;
  List<ProjectList> projectList;

  factory GetSubmittedProjectListModel.fromJson(Map<String, dynamic> json) =>
      GetSubmittedProjectListModel(
        status: json["Status"],
        message: json["Message"],
        projectList: List<ProjectList>.from(
            json["ProjectList"].map((x) => ProjectList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ProjectList": List<dynamic>.from(projectList.map((x) => x.toJson())),
      };
}

class ProjectList {
  ProjectList({
    this.id,
    this.projectname,
    this.createdByName,
    this.deadline,
    this.submittedDate,
    this.submittedByName,
    this.contactNo,
    this.isStd,
  });

  int id;
  String projectname;
  String createdByName;
  String deadline;
  String submittedDate;
  String submittedByName;
  String contactNo;
  bool isStd;

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        id: json["ID"],
        projectname: json["Projectname"],
        createdByName: json["CreatedByName"],
        deadline: json["Deadline"],
        submittedDate: json["SubmittedDate"],
        submittedByName: json["SubmittedByName"],
        contactNo: json["ContactNo"],
        isStd: json["IsStd"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Projectname": projectname,
        "CreatedByName": createdByName,
        "Deadline": deadline,
        "SubmittedDate": submittedDate,
        "SubmittedByName": submittedByName,
        "ContactNo": contactNo,
        "IsStd": isStd,
      };
}
