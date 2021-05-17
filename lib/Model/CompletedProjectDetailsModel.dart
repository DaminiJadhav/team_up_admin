import 'dart:convert';

CompletedProjectDetailsModel completedProjectDetailsModelFromJson(String str) =>
    CompletedProjectDetailsModel.fromJson(json.decode(str));

String completedProjectDetailsModelToJson(CompletedProjectDetailsModel data) =>
    json.encode(data.toJson());

class CompletedProjectDetailsModel {
  CompletedProjectDetailsModel({
    this.status,
    this.message,
    this.projectDetails,
  });

  int status;
  String message;
  ProjectDetails projectDetails;

  factory CompletedProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      CompletedProjectDetailsModel(
        status: json["Status"],
        message: json["Message"],
        projectDetails: ProjectDetails.fromJson(json["ProjectDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ProjectDetails": projectDetails.toJson(),
      };
}

class ProjectDetails {
  ProjectDetails({
    this.id,
    this.projectName,
    this.level,
    this.type,
    this.field,
    this.description,
    this.startDate,
    this.endDate,
    this.isReview,
    this.createdId,
    this.createdByName,
    this.submittedId,
    this.submittedByName,
    this.approvedId,
    this.approvedByName,
    this.isCreatedByStd,
    this.projectTeamLists,
  });

  int id;
  String projectName;
  String level;
  String type;
  String field;
  String description;
  String startDate;
  String endDate;
  bool isReview;
  int createdId;
  String createdByName;
  dynamic submittedId;
  dynamic submittedByName;
  int approvedId;
  String approvedByName;
  bool isCreatedByStd;
  List<ProjectTeamList> projectTeamLists;

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["ID"],
        projectName: json["ProjectName"],
        level: json["Level"],
        type: json["Type"],
        field: json["Field"],
        description: json["Description"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        isReview: json["IsReview"],
        createdId: json["CreatedId"],
        createdByName: json["CreatedByName"],
        submittedId: json["SubmittedId"],
        submittedByName: json["SubmittedByName"],
        approvedId: json["ApprovedId"],
        approvedByName: json["ApprovedByName"],
        isCreatedByStd: json["IsCreatedByStd"],
        projectTeamLists: List<ProjectTeamList>.from(
            json["ProjectTeamLists"].map((x) => ProjectTeamList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ProjectName": projectName,
        "Level": level,
        "Type": type,
        "Field": field,
        "Description": description,
        "StartDate": startDate,
        "EndDate": endDate,
        "IsReview": isReview,
        "CreatedId": createdId,
        "CreatedByName": createdByName,
        "SubmittedId": submittedId,
        "SubmittedByName": submittedByName,
        "ApprovedId": approvedId,
        "ApprovedByName": approvedByName,
        "IsCreatedByStd": isCreatedByStd,
        "ProjectTeamLists":
            List<dynamic>.from(projectTeamLists.map((x) => x.toJson())),
      };
}

class ProjectTeamList {
  ProjectTeamList({
    this.id,
    this.name,
    this.email,
    this.userName,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  dynamic userName;
  String imagePath;

  factory ProjectTeamList.fromJson(Map<String, dynamic> json) =>
      ProjectTeamList(
        id: json["ID"],
        name: json["Name"],
        email: json["Email"],
        userName: json["UserName"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Email": email,
        "UserName": userName,
        "ImagePath": imagePath,
      };
}
