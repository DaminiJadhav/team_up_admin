// To parse this JSON data, do
//
//     final completedProjectListModel = completedProjectListModelFromJson(jsonString);

import 'dart:convert';

CompletedProjectListModel completedProjectListModelFromJson(String str) => CompletedProjectListModel.fromJson(json.decode(str));

String completedProjectListModelToJson(CompletedProjectListModel data) => json.encode(data.toJson());

class CompletedProjectListModel {
  CompletedProjectListModel({
    this.status,
    this.message,
    this.projectApprovedList,
  });

  int status;
  String message;
  List<ProjectApprovedList> projectApprovedList;

  factory CompletedProjectListModel.fromJson(Map<String, dynamic> json) => CompletedProjectListModel(
    status: json["Status"],
    message: json["Message"],
    projectApprovedList: List<ProjectApprovedList>.from(json["ProjectApprovedList"].map((x) => ProjectApprovedList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ProjectApprovedList": List<dynamic>.from(projectApprovedList.map((x) => x.toJson())),
  };
}

class ProjectApprovedList {
  ProjectApprovedList({
    this.id,
    this.projectname,
    this.approvedDate,
    this.isApprovedByAdmin,
    this.approvedByName,
  });

  int id;
  String projectname;
  String approvedDate;
  bool isApprovedByAdmin;
  String approvedByName;

  factory ProjectApprovedList.fromJson(Map<String, dynamic> json) => ProjectApprovedList(
    id: json["ID"],
    projectname: json["Projectname"],
    approvedDate: json["ApprovedDate"],
    isApprovedByAdmin: json["IsApprovedByAdmin"],
    approvedByName: json["ApprovedByName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Projectname": projectname,
    "ApprovedDate": approvedDate,
    "IsApprovedByAdmin": isApprovedByAdmin,
    "ApprovedByName": approvedByName,
  };
}
